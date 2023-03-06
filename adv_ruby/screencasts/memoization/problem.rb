# frozen_string_literal: true

# class for discount calc
class Discounter
  def discount(*skus)
    expensive_discount_calcuation(*skus)
  end

  private

  def expensive_discount_calcuation(*skus)
    puts "Expensive calculation for #{skus.inspect}"
    skus.inject { |m, n| m + n }
    # skus.inject(:+)
  end
end

d = Discounter.new
puts d.discount(1, 2, 3)
puts d.discount(1, 2, 3)
puts d.discount(2, 3, 4)
puts d.discount(2, 3, 4)
