# ghost class
# frozen_string_literal: true

# problem:
# scope for optimization
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

d = Discounter.new

def d.discount(*skus)
  @mem ||= {}
  return @mem[skus] if @mem.key? skus

  @mem[skus] = super
end

puts d.discount(1, 2, 3)
puts d.discount(1, 2, 3)
puts d.discount(2, 3, 4)
puts d.discount(2, 3, 4)
