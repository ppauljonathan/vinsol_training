# frozen_string_literal: true

# animal = "cat"

# def animal.speak
#   puts "meow"
# end

# animal.speak

# other = animal.clone # copies singleton methods and state unlike .dup which only passes state

# other.speak

# # In the below example of prototype programming we can replace animal with Animal
# # and cat with Cat to make it seem as if they are classes

# animal = Object.new

# def animal.no_of_feet=(feet)
#   @no_of_feet = feet
# end

# def animal.no_of_feet
#   @no_of_feet
# end

# def animal.with_feet(feet)
#   new_animal = clone
#   new_animal.no_of_feet = 4
#   new_animal
# end

# # animal.no_of_feet = 4
# # puts animal.no_of_feet

# # cat = animal.clone
# cat = animal.with_feet(4)
# # cat.no_of_feet = 4
# # puts cat.no_of_feet

# felix = cat.clone

# # puts felix.instance_variable_get(:@no_of_feet) # if .dup
# puts felix.no_of_feet
