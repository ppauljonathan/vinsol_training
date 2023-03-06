# frozen_string_literal: true

# la = ->(a, b, c) { print [a, b, c] } # lambda{ |a| a + 1 } # l1
# la.call(1, 2, 3) # [1, 2, 3]
# la.call(1, 2) # fails
# la.call(1, 2, 3, 4) # fails

# la = ->(a, b, *c) { print [a, b, c] } # l2
# la.call(1, 2, 3) # [1, 2, [3]]
# la.call(1, 2) # fails
# la.call(1, 2, 3, 4) # [1, 2, [3, 4]]

# pr = proc { |a, b, c| print [a, b, c] } # p1
# pr.call(1, 2, 3) # [1, 2, 3]
# pr.call(1, 2) # [1, 2, nil]
# pr.call(1, 2, 3, 4) # [1, 2, 3] doesn't care about leftover arguments

# pr = proc { |a, b, *c| print [a, b, c] } # p2
# pr.call(1, 2, 3) # [1, 2, [3]]
# pr.call(1, 2) # [1, 2, []] # nil inside array
# pr.call(1, 2, 3, 4) # [1, 2, [3, 4]]

# Returning of proc and lambda
# def meth
#   puts 'at top'

#   # pr = proc do
#   #   puts 'in proc'
#   #   return
#   # end
#   # pr.call # returns out of the function immediately

#   # la = lambda do
#   #   puts 'in lambda'
#   #   return
#   # end
#   # la.call # returns back to the caller function

#   puts 'at bottom'
# end

# puts 'before method call'
# meth
# puts 'after method call'
