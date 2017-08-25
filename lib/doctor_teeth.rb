# the whole shebang
module DoctorTeeth

  require 'doctor_teeth/parser'
  require 'doctor_teeth/json_parser'

  # method stub for parsing
  # @return test_run
  def self.parse(xml, opts)
    DoctorTeeth::Parser.new(xml, opts).test_run
  end

  # method stub for parsing json
  # @return test_run
  def self.parse_json_file(json)
    #@todo: make file????
    DoctorTeeth::NewLineJsonFileParser.new(json)
  end
end
