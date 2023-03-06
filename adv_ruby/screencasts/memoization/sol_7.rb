# modules
# frozen_string_literal: true

# module for memoization
module Memoize
  def remember(name)
    # we can use space to make the method name not
    # callable by any explicit receiver except send
    old_name = "old #{name}"
    alias_method old_name, name
    mem ||= {}
    define_method(name) do |*args|
      return mem[args] if mem.key? args

      mem[args] = send(old_name, *args)
    end
  end
end

# class for discount calc
class Discounter
  extend Memoize

  # remember :discount # cannot be defined here as
  # :discount has not been defined yet

  def discount(*skus)
    expensive_discount_calcuation(*skus)
  end

  remember :discount

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
