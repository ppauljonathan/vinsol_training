# frozen_string_literal: true

def add_property_one(arr)
  arr.each do |x|
    x.store('new_property', 'new_value')
  end
end

def add_property_two(arr)
  fn = ->(x) { x.store('new_property', 'new_value') }

  arr.map(&fn)
  arr
end
