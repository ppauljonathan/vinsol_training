# frozen_string_literal: true

# def simple(param)
#   lvar = 'value of lvar'
#   binding # takes the binding  as obj
# end

# b = simple(99) { 'in block of simple' }

# # eval executes string as ruby code
# # when given the binding parameter
# # eval executes the code in the scope of where binding was defined
# eval('puts param', b)
# eval('puts lvar', b)
# eval('puts yield', b)

# class Simple
#   def initialize
#     @ivar = 'ivar'
#   end

#   def simple(param)
#     lvar = 'lvar'
#     binding
#   end
# end

# s = Simple.new
# b = s.simple(99) { 'inside block' }

# eval('puts param', b)
# eval('puts lvar', b)
# eval('puts yield', b)
# eval('puts @ivar', b)
# eval('puts self', b)

# p b
# eval("v1 = 1\nb = binding\nv2 = 2\neval('puts v1', b)\neval('puts v2', b)")

# def n_times(num)
#   ->(val) { puts num * val }
# end

# two_times = n_times(2)

# two_times.call(3)

# puts eval('n', two_times.binding) # things in the binding of a block are available in the entire lifetime of the block

# exercise

# def count_with_increment(start, increment)
#   start -= increment
#   -> { puts start += increment }
# end

# counter = count_with_increment(10, 3)
# counter.call
# counter.call
# counter.call

v1 = 1
b = binding
v2 = 2

eval('puts v1', b)
eval('puts v2', b)
