# frozen_string_literal: true

class DynamicClass
  def self.get_class_details
    print 'Please enter the class name: '
    class_name = gets.chomp
    my_class = new(class_name)
    print 'Please enter the method name you wish to define: '
    meth_name = gets.chomp
    print 'Please enter the method\'s code: '
    meth_body = gets.chomp
    my_class.def_method(meth_name, meth_body)

    print "\n--- Result ---\nHello, Your class #{class_name} is ready. Calling: #{class_name}.new.#{meth_name}:\n"
    puts my_class.call(meth_name)
    puts
  end

  def initialize(class_name)
    @class = Class.new
    Object.const_set(class_name, @class)
  end

  def def_method(meth_name, meth_body)
    @class.class_eval %{
      def #{meth_name}
        #{meth_body}
      end
    }
  end

  def call(meth_name)
    @class.new.send(meth_name.to_sym)
  end
end

DynamicClass.get_class_details
