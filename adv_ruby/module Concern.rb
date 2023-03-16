module Concern
  def self.included(mod)
    def mod.included(cls)
      cls.extend self::ClassMethods
    end
  end
end


module Mixin
  include Concern
  module ClassMethods
    def abc
      puts 'abc'
    end
  end
  def bcd
    puts 'bcd'
  end
end

class A
  include Mixin
end
A.abc
A.new.bcd
