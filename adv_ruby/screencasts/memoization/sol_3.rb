# subclass with generator
# frozen_string_literal: true

# problem:
# we may also do this with eigenclasses
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

def memoize(cls, meth)
  Class.new(cls) do
    mem = {} # not @mem as they are in the same scope
    define_method(meth) do |*args|
      return mem[args] if mem.key? args

      mem[args] = super(*args)
    end
  end
end

d = memoize(Discounter, :discount).new
puts d.discount(1, 2, 3)
puts d.discount(1, 2, 3)
puts d.discount(2, 3, 4)
puts d.discount(2, 3, 4)
