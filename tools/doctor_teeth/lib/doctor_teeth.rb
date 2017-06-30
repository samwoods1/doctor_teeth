module DoctorTeeth

  require 'doctor_teeth/parser'
  require 'doctor_teeth/json_parser'

  def self.parse(xml, opts)
    DoctorTeeth::Parser.new(xml, opts).test_run
  end

  def self.parse_json_file(json)
    #TODO make file????
    DoctorTeeth::NewLineJsonFileParser.new(json)
  end
end
