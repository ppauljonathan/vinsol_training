# ||= memoizaton
# frozen_string_literal: true

# problem:
# method which does discount has more code for memoization
class Discounter
  def initialize
    @mem = {}
  end

  def discount(*skus)
    return @mem[skus] if @mem.key? skus

    @mem[skus] = expensive_discount_calcuation(*skus)
    # @mem[skus] ||= expensive_discount_calcuation(*skus) # only if rhs returns non nil
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
