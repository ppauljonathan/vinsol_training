# ghost class
# frozen_string_literal: true

# problem:
# best yet, but tedious
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

def memoize(obj, meth)
  # ghost = class << obj; self; end
  ghost = obj.singleton_class # same as above
  ghost.class_eval do
    mem ||= {}
    define_method(meth) do |*args|
      return mem[args] if mem.key? args

      mem[args] = super(*args)
      # does not run if obj.class.class_eval as obj.class = Discounter super discount doesnt exist
    end
  end
end

d = Discounter.new
memoize(d, :discount)

puts d.discount(1, 2, 3)
puts d.discount(1, 2, 3)
puts d.discount(2, 3, 4)
puts d.discount(2, 3, 4)
