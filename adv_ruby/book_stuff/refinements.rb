module StringExtensions
  refine String do
    def reverse
      'esrever'
    end
  end
end

# p "hola".reverse # => "aloh"

# module StrStuff
#   using StringExtensions
#   p "hello".reverse # => "esrever"
# end

# p "hello".reverse # => "olleh"

# using StringExtensions
# p "hola".reverse # => "esrever"

class MyClass
  def self.my_method
    "original my_method()"
  end
  def self.another_method
    my_method
  end
end
module MyClassRefinement
  refine MyClass do
    def self.my_method
      "refined my_method()"
    end
  end
end
using MyClassRefinement
p MyClass.my_method
p MyClass.another_method
