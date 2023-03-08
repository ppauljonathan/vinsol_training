# frozen_string_literal: true

require 'benchmark'
require './iterate'

input = ('a'..'z').map { |letter| [[letter, letter]].to_h }
n = 100_000

Benchmark.bmbm do |benchmark|
  benchmark.report('add_property_one') do
    n.times do
      add_property_one(input)
    end
  end

  benchmark.report('add_property_two') do
    n.times do
      add_property_two(input)
    end
  end
end
