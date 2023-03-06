# frozen_string_literal: false

# class for Item of shopping list
class Item
  def initialize(name, qty)
    @name = name
    @qty = qty
  end

  def to_s
    "#{@name} #{@qty}\n"
  end
end

# DSL for defining shopping list
class ShoppingList
  def initialize
    @list = []
  end

  def to_s
    @list.reduce("Shopping List\n") { |out, item| out << item.to_s }
  end

  def items(&block)
    instance_eval(&block)
  end

  private

  def add(name, qty)
    @list << Item.new(name, qty)
  end
end

sl = ShoppingList.new
sl.items do
  add('Toothpaste', 2)
  add('Computer', 1)
end

puts sl
