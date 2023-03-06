# DSL with method binding
# we can convert method to object
# frozen_string_literal: true

# module for memoization
module Memoize
  def remember(name, &block)
    define_method(name, &block)
    original_method = instance_method(name)
    mem = {}

    define_method(name) do |*args|
      return mem[args] if mem.key? args

      bound_method = original_method.bind(self)
      mem[args] = bound_method.call(*args)
    end
  end
end

# class for discount calc
class Discounter
  extend Memoize
  remember :discount do |*skus|
    expensive_discount_calcuation(*skus)
  end

  private

  def expensive_discount_calcuation(*skus)
    puts "Expensive calculation for #{skus.inspect}"
    skus.inject { |m, n| m + n }
  end
end

d = Discounter.new
puts d.discount(1, 2, 3)
puts d.discount(1, 2, 3)
puts d.discount(2, 3, 4)
puts d.discount(2, 3, 4)
