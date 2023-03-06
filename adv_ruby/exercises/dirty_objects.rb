# frozen_string_literal: false

# module for implementing dirty objects
module DirtyObject
  def method_missing(method_name, *args, &block)
    method_name.to_s =~ /(.+)_was$/
    super unless instance_variables.map(&:to_s).include?("@#{Regexp.last_match 1}")

    "undefined method #{method_name}"
  end

  def self.included(klass)
    klass.extend ExtendedFunctions
    klass.attr_reader :changes, :changed
  end

  def changed?
    changed
  end

  def save
    changes.clear
    @changed = false
    true
  end

  def initialize
    @changes = Hash.new { |h, k| h[k] = [] }
  end

  # module for defining dirty attributes
  module ExtendedFunctions
    def define_dirty_setter(attr)
      define_method("#{attr}=") do |val|
        changes[attr] << instance_variable_get("@#{attr}") if changes[attr].empty?
        changes[attr].pop if changes[attr].size > 1

        changes[attr][0] == val ? changes.delete(attr) : changes[attr] << val
        @changed = !changes.empty?
        instance_variable_set("@#{attr}", val)
      end
    end

    def define_dirty_getter(attr)
      define_method("#{attr}_was") { changes[attr][0] }
    end

    def define_dirty_attributes(*args)
      args.each do |arg|
        define_dirty_setter arg
        define_dirty_getter arg
      end
    end
  end
end

# class which demonstrates use of dirty objects
class User
  include DirtyObject

  attr_accessor :name, :age, :email, :dob

  define_dirty_attributes :name, :age
end

u = User.new

u.name = 'Akhil'
u.email = 'akhil@vinsol.com'
u.age = 30

p u.changed? #=> true
p u.changes #=> { name: [nil, 'Akhil], age: [nil, 30] }

p u.name_was #=> nil
p u.email_was #=> "undefined method email_was"
p u.age_was #=> nil

p u.save #=> true

p u.changed? #=> false
p u.changes #=> {}

u.name = 'New name'
u.age  = 31
p u.changes #=> {name: ['Akhil', 'New name'], age: [30, 31]}
p u.name_was #=> 'Akhil'

u.name = 'Akhil'
p u.changes #=> {age: [30, 31]}
p u.changed? #=> true

u.age = 30
p u.changes #=> {}

p 'User 2'
u2 = User.new
u2.name = 'Paul'
u2.age = 21
u2.email = 'ppaul.jonathan@vinsol.com'
u2.dob = Time.new(2002, 2, 3, 0, 0, 0)

p u2.changed? #=> true
p u2.changes #=> {:name=>[nil, "Paul"], :age=>[nil, 21]}

p u2.save #=> true
p u2.changed? #=> false
p u2.changes #=> {}

u2.name = 'Jonathan'
p u2.changes #=>{:name=>["Paul", "Jonathan"]}
u2.name = 'hello'
p u2.changes #=>{:name=>["Paul", "hello"]}
p u2.changed? #=> true

p u2.dob_was #=> "undefined method dob_was"
p u2.grade_was
