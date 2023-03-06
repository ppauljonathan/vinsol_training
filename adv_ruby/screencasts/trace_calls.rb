# frozen_string_literal: true

module TraceCalls
  def self.included(klass)
    klass.instance_methods(false).each do |method|
      wrap_method(klass, method)
    end
    def klass.method_added(name)
      return if @_adding_a_method
      @_adding_a_method = true
      TraceCalls.wrap_method(self, name)
      @_adding_a_method = false
    end
  end

  def self.wrap_method(klass, name)
    original_method = "original #{name}"
    klass.alias_method original_method, name
    klass.define_method(name) do |*args, &block|
      puts "calling method #{name} with args #{args.inspect}"
      result = public_send original_method, *args, &block
      puts "result = #{result}"
    end
  end
end

# class Example
#   include TraceCalls

#   def some_method(arg1, arg2)
#     arg1 + arg2
#   end

#   def muliply(arg)
#     yield * arg
#   end

#   def name=(name)
#     name
#   end

#   def <<(thing)
#     puts "pushing #{thing}"
#   end
# end

# ex = Example.new
# ex.some_method(4, 5)
# ex.muliply(99) { 5 }
# ex.name = 'Paul'
# ex << 'hi'

# class Time
#   include TraceCalls
# end

# puts Time.now + 3600

class String
  include TraceCalls
end

'cat ' + 'dog'
