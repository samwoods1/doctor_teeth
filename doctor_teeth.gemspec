# coding: utf-8
# place ONLY runtime dependencies in here (in addition to metadata)
require File.expand_path('../lib/doctor_teeth/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'doctor_teeth'
  s.authors       = ["Puppet, Inc.", 'Zach Reichert']
  s.email         = ["qa@puppet.com"]
  s.summary       = 'Logic to parse junit_xml into schema used in BigQuery'
  s.homepage      = "https://github.com/puppetlabs/doctor_teeth"
  s.version       = DoctorTeeth::Version::STRING
  s.files         = Dir['CONTRIBUTING.md', 'LICENSE.md', 'MAINTAINERS',
                        'README.md', 'lib/**/*']
  s.required_ruby_version = '>= 1.9.3'

  #Run time dependencies
  s.add_runtime_dependency 'nokogiri'
end
