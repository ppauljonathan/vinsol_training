# frozen_string_literal: true

class PrivateMethodCalled < TypeError
end

# module
module MyModule
  def self.included(klass)
    klass.extend self
    class << klass
      attr_accessor :action_method_list, :before_methods, :after_methods
    end
  end

  def before_filter(*filters, **options)
    @before_methods ||= []
    before_methods << [filters, options]
  end

  def after_filter(*filters, **options)
    @after_methods ||= []
    after_methods.append [filters, options]
  end

  def check_options_for_filter(options, method)
    return true if options.empty? || options[:only] == method
    return true if options[:only].nil? && !options[:except].nil? && options[:except] != method

    false
  end

  def get_filter_methods_for(method)
    output = { before: [], after: [] }
    before_methods.each do |filters, options|
      output[:before].append(*filters) if check_options_for_filter(options, method)
    end

    after_methods.each do |filters, options|
      output[:after].append(*filters) if check_options_for_filter(options, method)
    end
    output
  end

  def action_methods(*methods)
    @action_method_list ||= {}
    methods.each do |method|
      action_method_list[method] = get_filter_methods_for method
    end
    # pp action_method_list
  end

  def check_private_and_exec(meth_name)
    return meth_name.call if meth_name.is_a? Proc
    unless private_instance_methods(false).include? meth_name
      raise PrivateMethodCalled, "method: #{meth_name} is not private"
    end
    new.instance_eval(meth_name.to_s) # since we need to call a private method
  end

  def define_action_method(method)
    old_method = instance_method(method)
    before = action_method_list[method][:before]
    after = action_method_list[method][:after]
    define_method method do
      before.each { |filter| self.class.check_private_and_exec filter }
      old_method.bind_call(self)
      after.each { |filter| self.class.check_private_and_exec filter }
    end
  end

  def method_added(method)
    return unless action_method_list.key? method
    return if @defining

    @defining = true
    define_action_method method
    @defining = false
  end
end

# class for executing mymodule functions
class MyClass
  include MyModule

  before_filter proc { puts 'hello from proc' }, :except => :my_method
  before_filter :foo, :bar, :only => :my_method
  after_filter :baz, :except => :your_method
  after_filter :bat, :except => :my_method
  before_filter proc { puts 'hi proc2' }

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
