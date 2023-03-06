class TaxCalculator
  def self.calc_sales_tax(price)
    price / 10.0
  end

  def self.calc_import_tax(price)
    price / 20.0
  end
end

class Product
  attr_accessor :name, :is_imported, :sales_tax_exempt, :price

  def initialize
    print "\nName of the product: "
    @name = gets.chomp
    print 'Imported?: '
    @is_imported = (gets.chomp == 'yes')
    print 'Exempted from sales tax?: '
    @sales_tax_exempt = (gets.chomp == 'yes')
    print 'Price: '
    @price = gets.chomp.to_f
  end
end

class Bill
  attr_accessor :bill

  def initialize
    @bill = []
  end

  def add_item(item)
    import_tax_levied = item.is_imported ? TaxCalculator.calc_import_tax(item.price) : 0.0
    sales_tax_levied = item.sales_tax_exempt ? 0.0 : TaxCalculator.calc_sales_tax(item.price)
    sub_total = import_tax_levied + sales_tax_levied + item.price
    @bill.push({ name: item.name, price: item.price, sales_tax: sales_tax_levied, import_tax: import_tax_levied, sub_total: sub_total })
  end

  def calc_grand_total
    @bill.inject(0) { |total, item| total + item[:sub_total] }
  end

  def generate_bill_string
    output = ''
    output << "\nBILL OF GOODS\n"
    output << "#{'ITEM'.ljust(15)}#{'PRICE'.ljust(15)}#{'SALES TAX'.ljust(15)}#{'IMPORT DUTY'.ljust(15)}#{'SUBTOTAL'.ljust(15)}\n"
    @bill.each do |item|
      output << "#{item[:name].ljust(15)}#{item[:price].to_s.ljust(15)}#{item[:sales_tax].to_s.ljust(15)}#{item[:import_tax].to_s.ljust(15)}#{item[:sub_total].to_s.ljust(15)}\n"
    end
    output << "#{''.ljust(45)}#{'GRAND TOTAL'.ljust(15)}#{calc_grand_total.to_i.to_f.to_s.ljust(15)}"
  end
end

class Sales
  def self.checkout
    add_more = 'y'
    bill = Bill.new
    while add_more == 'y'
      item = Product.new
      bill.add_item(item)
      print 'Do you want to add more items to your list(y/n): '
      add_more = gets.chomp
    end
    bill.generate_bill_string
  end
end

puts Sales.checkout
