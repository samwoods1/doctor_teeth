module DoctorTeeth

  require 'doctor_teeth/parser'

  def self.parse(xml, opts)
    DoctorTeeth::Parser.new(xml, opts).test_run
  end
end
