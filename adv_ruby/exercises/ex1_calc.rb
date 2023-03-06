# frozen_string_literal: true

# Numeric class monkeypatched with calculator class method
class Numeric
  DECIMAL_REGEX = /\d*\.{1}\d*/.freeze
  def self.calculator(calc_string)
    calc_array = calc_string.split(',')
    operator = calc_array[1][-1]
    num1 = calc_array[0] =~ DECIMAL_REGEX ? calc_array[0].to_f : calc_array[0].to_i
    num2 = calc_array[2] =~ DECIMAL_REGEX ? calc_array[2].to_f : calc_array[2].to_i
    num1.send(operator, num2)
  end
end

if ARGV.empty?
  puts 'Please provide an input'
else
  puts Numeric.calculator(ARGV[0])
end
