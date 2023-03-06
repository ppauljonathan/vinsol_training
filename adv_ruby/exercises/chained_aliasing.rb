# frozen_string_literal: true

# module for implementing chained aliasing
module MyModule
  PREAMBLE_OR_BANG_REGEX = /(\?|!)$/.freeze

  def self.included(klass)
    klass.extend self
  end

  def new_method_name_end(method)
    method =~ PREAMBLE_OR_BANG_REGEX ? Regexp.last_match(1) : ''
  end

  def define_aliases
    alias_method @without_other, @original
    alias_method @original, @with_other
  end

  def make_methods_private
    method_private = private_instance_methods(false).include? @without_other.to_sym
    private @original, @with_other if method_private
  end

  def make_methods_protected
    method_protected = protected_instance_methods(false).include? @without_other.to_sym
    protected @original, @with_other if method_protected
  end

  def chained_aliasing(method1, method2)
    name_end = new_method_name_end(method1)
    method1 = method1.to_s.chop unless name_end == ''

    @original = "#{method1}#{name_end}"
    @with_other = "#{method1}_with_#{method2}#{name_end}"
    @without_other = "#{method1}_without_#{method2}#{name_end}"

    define_aliases
    make_methods_private
    make_methods_protected
  end
end

# class to test chained aliasing
class Hello
  def greet
    puts 'hello'
  end
end

puts 'without chaining'
say = Hello.new
say.greet # =>  hello

# reopening Hello class
class Hello
  include MyModule

  def greet_with_logger
    puts '--logging start'
    greet_without_logger
    puts '--logging end'
  end

  chained_aliasing :greet, :logger
end

puts 'with chaining'
say = Hello.new
say.greet

# --logging start
# hello
# --logging end

say.greet_with_logger
# --logging start
# hello
# --logging end

say.greet_without_logger
# hello
