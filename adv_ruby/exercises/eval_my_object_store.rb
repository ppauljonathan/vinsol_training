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
    raise ValidationError, 'validation error in given attributes' if !my_obj_validator && respond_to?(:validate) && !validate

    self.class.object_store << self
  end

  # module for defining class methods when MyObjectStore is included
  module ExtendedClassMethods
    def self.extended(klass)
      klass.object_store = []
    end

    # def method_missing(method)
    #   super unless object_store.respond_to? method

    #   object_store.public_send method
    # end

    def collect
      object_store.collect
    end

    def count
      object_store.count
    end

    def define_finder_methods(*attrs)
      attrs.each do |attr|
        define_singleton_method "find_by_#{attr}" do |val|
          object_store.select { |obj| obj.public_send(attr).include? val }
        end
      end
    end

    def attr_accessor(*attrs)
      super
      define_finder_methods(*attrs)
    end

    def validate_prescence_of(*attrs)
      class_eval do
        define_method :my_obj_validator do
          attrs.map { |attr| instance_variable_get("@#{attr}") }.all?
        end
      end
    end
  end
end

# class to demonstrate MyObjectStore functonality
class Play
  include MyObjectStore

  attr_accessor :age, :name, :email

  validate_prescence_of :name, :email

  def validate
    1 == 1
  end
end

p2 = Play.new
p2.name = 'Paul'
p2.email = 'ppaul.jonathan@vinsol.com'
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
