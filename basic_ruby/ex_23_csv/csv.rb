# frozen_string_literal: true

# Using Ruby version: ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]
# Your ruby code here
require 'csv'

class Employee
  attr_accessor :empid, :name, :designation

  def initialize(inp_hash)
    @empid = inp_hash[:empid]
    @name = inp_hash[:name]
    @designation = inp_hash[:designation]
  end
end

class DataReader
  def self.read_csv_data(path)
    CSV.read(path, converters: ->(f) { f.strip }, headers: true, header_converters: ->(f) { f.strip.downcase.to_sym })
  end

  def self.write_details_to_file(path, data)
    File.open(path, 'w') do |output_file|
      data.each do |emp_data|
        output_file.write("\n#{emp_data[0]}#{'s' if emp_data[1].size > 1}\n")
        emp_data[1].each do |individual|
          output_file.write("#{individual.name} (EmpId: #{individual.empid})\n")
        end
      end
    end
  end

  def self.get_data_from_csv_file(input_path, output_path)
    employees = []
    details = read_csv_data(input_path)
    details.each do |data|
      employees << Employee.new(data)
    end

    output_data = employees.group_by(&:designation).sort
    write_details_to_file(output_path, output_data)
  end
end

DataReader.get_data_from_csv_file('./employees.csv', './emp.txt')
