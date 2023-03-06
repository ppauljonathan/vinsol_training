class Module
  def included(mod)
    puts "#{self} included in #{mod}"
  end
end

class A
  include Comparable
  def <=>(other)
    puts 'comparing...'
    0
  end
end

a = A.new
a < 123
