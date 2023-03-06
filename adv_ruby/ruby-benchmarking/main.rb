# frozen_string_literal: true

require './iterate'

arr = [{ name: 'John', age: 23 }, { name: 'Jane', age: 18 }, { name: 'Joe', age: 21 }]
arr2 = arr.map(&:clone)

res1 = add_property_one(arr)
res2 = add_property_two(arr2)

puts "res1: #{res1}"
puts "res2: #{res2}"
