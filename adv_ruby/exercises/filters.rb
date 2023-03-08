# frozen_string_literal: true

class PrivateMethodCalled < TypeError
end

# module
module MyModule
  def self.included(klass)
    klass.extend self
    klass.singleton_class.attr_accessor :filters_for_action_methods
  end

  def assign_filters_to_action_methods(filter_name, filters, options)
    filters_for_action_methods.each do |method, filter|
      if options.empty?
        filter[filter_name].append(*filters)
      elsif options[:only]
        filter[filter_name].append(*filters) if method == options[:only]
      else
        filter[filter_name].append(*filters) unless method == options[:except]
      end
    end
  end

  def before_filter(*filters, **options)
    assign_filters_to_action_methods(:before, filters, options)
  end

  def after_filter(*filters, **options)
    assign_filters_to_action_methods(:after, filters, options)
  end

  def action_methods(*methods)
    @filters_for_action_methods = Hash.new do |h, k|
      h[k] = { before: [], after: [] }
    end
    methods.each { |method| filters_for_action_methods[method] }
  end

  def check_private_and_exec(meth_name)
    return meth_name.call if meth_name.is_a? Proc
    unless private_instance_methods(false).include? meth_name
      raise PrivateMethodCalled, "method: #{meth_name} is not private"
    end

    new.instance_eval meth_name.to_s # since we need to call a private method
  end

  def define_action_method(method)
    old_method = instance_method(method)
    before = filters_for_action_methods[method][:before]
    after = filters_for_action_methods[method][:after]
    define_method method do
      before.each { |filter| self.class.check_private_and_exec filter }
      old_method.bind_call(self)
      after.each { |filter| self.class.check_private_and_exec filter }
    end
  end

  def method_added(method)
    return unless filters_for_action_methods.key? method
    return if @defining

    @defining = true
    define_action_method method
    @defining = false
  end
end

# class for executing mymodule functions
class MyClass
  include MyModule

  action_methods :my_method, :your_method

  before_filter proc { puts 'hello from proc' }, :except => :my_method
  before_filter :foo, :bar, :only => :my_method
  after_filter :baz
  after_filter :bat, :except => :my_method
  before_filter proc { puts 'hi proc2' }

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
