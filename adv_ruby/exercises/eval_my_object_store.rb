# frozen_string_literal: true

class ValidationError < NameError
end

# module to implement MyObjectStore functonality
module MyObjectStore
  def self.included(klass)
    klass.singleton_class.attr_accessor :object_store
    klass.extend(ExtendedClassMethods)
  end

  def save
    my_obj_validator
    raise ValidationError, 'custom validation failed' if respond_to?(:validate) && !validate

    self.class.object_store << self
  end

  # module for defining class methods when MyObjectStore is included
  module ExtendedClassMethods
    def self.extended(klass)
      klass.object_store = []
    end

    def respond_to_missing?(method)
      super unless object_store.respond_to? method

      true
    end

    def method_missing(method)
      super unless object_store.respond_to? method

      object_store.public_send method
    end

    def define_finder_methods(*attrs)
      attrs.each do |attr|
        define_singleton_method "find_by_#{attr}" do |keyword|
          object_store.select do |obj|
            val = obj.public_send(attr)
            val.is_a?(Numeric) ? val == keyword : val&.include?(keyword)
          end
        end
      end
    end

    def attr_accessor(*attrs)
      super
      define_finder_methods(*attrs)
    end

    def validate_prescence_of(*attrs)
      define_method :my_obj_validator do
        attrs.each do |attr| 
          raise ValidationError, "attribute #{attr} undefined" unless instance_variable_get("@#{attr}")
        end
      end
    end
  end
end

# class to demonstrate MyObjectStore functonality
class Play
  EMAIL_CHECK_REGEX = /.*@.*\.com/.freeze
  include MyObjectStore

  attr_accessor :age, :name, :email

  validate_prescence_of :name, :email

  def validate
    raise ValidationError, 'please enter a valid email' unless EMAIL_CHECK_REGEX =~ email

    true
  end
end

p2 = Play.new
p2.name = 'Paul'
p2.email = 'ppaul.jonathan@vinsol.com'
p2.age = 21
p2.save

p1 = Play.new
p1.name = 'Jon'
p1.email = 'jon@gmail.com'
p1.age = 23
p1.save

p3 = Play.new
p3.name = 'Jonathan'
p3.email = 'jonathan@gmail.com'
p3.save

p Play.find_by_name('Paul') #=> gives p2 object
p Play.find_by_email('gmail') #=> returns array of email with gmail in it
p Play.find_by_age(10) #=> []
