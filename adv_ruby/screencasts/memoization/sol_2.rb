# subclass memoization
# frozen_string_literal: true

# problem:
# subclass is too specific
class Discounter
  def discount(*skus)
    expensive_discount_calcuation(*skus)
  end

  private

  def expensive_discount_calcuation(*skus)
    puts "Expensive calculation for #{skus.inspect}"
    skus.inject { |m, n| m + n }
  end
end

# subclass for memoization
class MemoDiscount < Discounter
  def initialize
    super
    @mem = {}
  end

  def discount(*skus)
    return @mem[skus] if @mem.key? skus

    @mem[skus] = super
  end
end

d = MemoDiscount.new
puts d.discount(1, 2, 3)
puts d.discount(1, 2, 3)
puts d.discount(2, 3, 4)
puts d.discount(2, 3, 4)
