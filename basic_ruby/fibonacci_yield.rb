# frozen_string_literal: true

# Using Ruby version: ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]
# Your Ruby code here

class Integer
  def fib_up_to
    n1, n2 = 1, 1
    while n1 <= self
      yield n1
      n1, n2 = n2, n2 + n1
    end
  end
end

if ARGV.empty?
  puts 'Please provide an input'
else
  ARGV[0].to_i.fib_up_to { |num| print num, ' ' }
end
