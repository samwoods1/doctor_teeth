require 'nokogiri'
module DoctorTeeth
  class Parser

    attr_accessor :test_run

    def initialize(xml, opts={})
      xml = File.read(xml) if File.exists?(xml)
      @xml= Nokogiri::XML(xml)
      # TODO validate initial opts
      @test_run = extract_test_run(opts[:project], opts[:configuration], opts[:execution_id])
    end

    private
    def extract_test_run(project, configuration, execution_id)
      start_time = nil
      @xml.xpath('//testsuites//properties//property').each do |property|
        # do not know if this is part of the junit.xml
        name = property.attributes['name'].value
        if name == 'timestamp'
          # BigQuery doesn't like the timezone, providing it in UTC formats it correctly
          start_time = Time.parse(property.attributes['value'].value).utc
          break
        end
      end

      # update the way that we deal with configuration to match what is done
      # when we convert elasticsearch data to the BigQuery schema
      # we are assuming that the configuration is provided in the format of a hash

      conf = []
      configuration.each { |k,v| conf.push("#{k}=#{v}") }

      run = {
          'test_run' => {
              'project'       => project,
              'duration'      => 0.0, # this is the total duration of all contained test suites
              'configuration' => conf,
              'start_time'    => start_time,
              'execution_id'  => execution_id,
              'test_suites'   => extract_test_suites

          }
      }
      # calculate duration for test_run
      run["test_run"]['test_suites'].each do |suite|
        run["test_run"]['duration'] += suite['duration']
      end
      return run
    end

    def extract_test_suites
      test_suites = []

      suites = @xml.xpath('//testsuites//testsuite')
      suites.each do |suite|
        name = suite.attributes['name'].value
        duration = suite.attributes['time'].value.to_f
        test_count = suite.attributes['total'].value.to_i
        test_cases = extract_test_cases(suite)
        test_suites.push({'name' => name, 'duration' => duration, 'test_count' => test_count, 'test_cases' => test_cases})
      end

      return test_suites
    end

    def extract_test_cases(test_suite)
      test_cases = []

      test_suite.children.each do |tc|
        next unless tc.name == 'testcase'
        test_case = {}
        test_case['name'] = tc.attributes['name'].value
        test_case['duration'] = tc.attributes['time'].value.to_f
        test_case['status'] = 'pass'

        # set status
        tc.children.each do |child|
          n = child.name
          if n == 'failure'
            # this will set status to failure or error
            test_case['status'] = child.attributes['type'].value
          elsif ['skipped', 'pending'].any?{ |state| state == n }
            test_case['status'] = n
          end
        end

        if ['failure', 'error'].any?{ |state| state == test_case['status'] }
          tc.children.each do |child|
            n = child.name
            #only capture the system out if there we are in the status of failure or error
            if n == 'system-out'
              tc.children.each do |c|
                if test_case['system_out']
                  test_case['system_out'] << c.content
                else
                  test_case['system_out'] = c.content
                end
              end
            end
          end
        end


        test_cases.push(test_case)
      end

      return test_cases
    end

  end
end
