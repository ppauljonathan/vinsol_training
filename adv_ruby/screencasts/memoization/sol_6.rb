# alias
# frozen_string_literal: true

# discounter class
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

# monkeypatch for alias method
class Discounter
  alias _old_discount_ discount
  def discount(*skus)
    @mem ||= {}
    return @mem[skus] if @mem.key? skus

    @mem[skus] = _old_discount_(*skus)
  end
end

d = Discounter.new
puts d.discount(1, 2, 3)
puts d.discount(1, 2, 3)
puts d.discount(2, 3, 4)
puts d.discount(2, 3, 4)
