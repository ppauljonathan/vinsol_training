# frozen_string_literal: false

require 'csv'

# class to read csv file
class CsvReader
  CLASS_NAME_REGEX = /(\w+)\.csv/.freeze

  def create_class_from_file(path)
    csv_data = read_data path
    headers = extract_headers csv_data
    get_csv_class(headers, path)
    make_class_objects csv_data
  end

  def to_s
    @csv_detail_array.reduce('') { |mem, obj| mem << "#{obj}\n" }
  end

  private

  def read_data(path)
    CSV.read(path, headers: true, header_converters: ->(h) { h.strip }, converters: ->(f) { f.strip })
  rescue Errno::ENOENT => e
    raise StandardError, "ERROR: #{path} not found", "ERROR: #{e}"
  rescue CSV::MalformedCSVError => e
    raise StandardError, 'ERROR: there is something wrong with the file given', "ERROR: #{e}"
  end

  def extract_headers(csv_data)
    csv_data.headers
  end

  def make_class(headers)
    Class.new do
      attr_accessor(*headers)

      def initialize(details)
        details.each { |key, val| instance_variable_set("@#{key}", val) }
      end

      def to_s
        ivar_vals = instance_variables.map { |var| [var, instance_variable_get(var)] }
        ivar_vals.reduce('') { |oup, val| oup << "#{val[0]} = #{val[1]}, " }
      end
    end
  end

  def get_csv_class(headers, path)
    raise StandardError, 'Error: given file is not a csv file' unless path.match(CLASS_NAME_REGEX)

    class_name = Regexp.last_match(1)[0..-2].capitalize
    @csv_class = make_class(headers)
    Object.const_set(class_name, @csv_class)
  end

  def make_class_objects(csv_data)
    @csv_detail_array = []
    csv_data.each do |data|
      @csv_detail_array << @csv_class.new(data)
    end
  end
end

cr = CsvReader.new
cr.create_class_from_file('./persons.csv')
puts cr
