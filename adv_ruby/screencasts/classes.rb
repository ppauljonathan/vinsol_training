# puts "Before Class, self = #{self}"
# 
# var = class Dave
#   puts "Inside Class, self = #{self}"
#   def say_hello
#     puts "hi"
#   end
#   self
# end
# 
# puts "After Class, self = #{self}"
# 
# puts var.new.say_hello

# cls = Class.new
# p cls
# 
# Dave = cls
# p cls

class Dave
  def self.say_hello # singleton class
    puts 'hi'
  end
end

Dave.say_hello

animal = 'cat'
def animal.speak # singleton class
  puts 'meow'
end

# class << animal # singleton class
#   def speak
#     puts 'meow'
#   end
# end

animal.speak
