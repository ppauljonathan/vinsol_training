# frozen_string_literal: true

# module
module MyModule
  def self.included(klass)
    klass.extend self
    klass.singleton_class.attr_accessor :before_methods, :after_methods, :action_method_list
  end

  def map_specifiers(functions, specifiers)
    specifiers_for_functions = []
    if specifiers.key? :only
      functions.each do |function|
        specifiers_for_functions.append [function, specifiers.assoc(:only)]
      end
    else
      functions.each do |function|
        specifiers_for_functions.append [function, specifiers.assoc(:except)]
      end
    end
    specifiers_for_functions
  end

  def before_filter(*functions, **specifiers)
    @before_methods ||= []
    before_methods.append(*map_specifiers(functions, specifiers))
  end

  def after_filter(*functions, **specifiers)
    @after_methods ||= []
    after_methods.append(*map_specifiers(functions, specifiers))
  end

  def action_methods *functions
    @action_method_list ||= []
    action_method_list.push(*functions)
  end

  def methods_for(method_name, filter)
    filter&.reduce([]) do |method_array, filtered_method|
      if !filtered_method[1] ||
         (filtered_method[1][0] == :only && filtered_method[1][1] == method_name.to_sym) ||
         ((filtered_method[1][0] == :except && filtered_method[1][1] != method_name.to_sym))

        method_array.append(filtered_method[0])
      else
        method_array
      end
    end
  end

  def check_private_and_exec(method_name)
    return method_name.call if method_name.is_a? Proc

    raise TypeError, "filter: #{method_name} is not private" unless private_instance_methods(false).include? method_name

    new.instance_eval(method_name.to_s)
  end

  def def_method_wrapper(method_name)
    old_method = instance_method(method_name)
    before = methods_for(method_name, before_methods)
    after = methods_for(method_name, after_methods)
    define_method(method_name) do
      before&.each { |method| self.class.check_private_and_exec method }
      old_method.bind_call(self)
      after&.each { |method| self.class.check_private_and_exec method }
    end
  end

  def method_added(method_name)
    return unless action_method_list.include? method_name
    return if @defining

    @defining = true
    def_method_wrapper(method_name)
    @defining = false
    super
  end
end

# class for executing mymodule functions
class MyClass
  include MyModule

  before_filter proc { puts 'hello from proc' }, except: :my_method
  before_filter :foo, :bar
  after_filter :baz, except: :your_method
  after_filter :bat, except: :my_method

  action_methods :my_method, :your_method

  def my_method
    puts 'my_method1'
  end

  private def foo
    puts 'foo'
  end

  private def bar
    puts 'bar'
  end

  private def baz
    puts 'baz'
  end

  private def bat
    puts 'bat'
  end

  def my_method
    puts 'my_method2'
  end

  def your_method
    puts 'your_method'
  end

  def fake_method
    puts 'fake_method'
  end
end

mc = MyClass.new
mc.my_method
puts
mc.your_method
puts
mc.fake_method
puts
