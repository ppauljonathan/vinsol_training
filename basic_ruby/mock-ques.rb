# class A
#   attr_accessor :k
#   @k = 5
#   def initialize
#     @k = 55
#   end

#   @q = 5

#   def self.get_q
#     @k
#   end
  
#   class << self
#     attr_accessor :k
#   end

# end

# class B < A; end

# a = A.new

# # p a.k

# p A.k

# b = [1,2,3]

# p b
# # [1,2,3]
# # [1, 2, 3]

# '"hello" 
# '
# # "\"hello\"\n"

# print b
# # [1,2,3]
# # nil

# puts b
# # 1
# # 2
# # 3
# # nil


# class String
#   def inspect
#     self.downcase == 'hello' ? "Hello Paul" : self
#   end
# end

# p "hello"

# p "Hello"

# p "abc"



# class A
#   def xyz
#     2
#   end

#   def xyz
#     5
#   end

#   def xyz (a=4)
#     p a
#   end
# end

# a1 = A.new
# a2 = A.new
# a3 = A.new

# a1.xyz 10
# a2.xyz nil
# a3.xyz

# p ('abc'..'pat').to_a

# abc
# abd
# abe
# abf
# |
# |
# par
# pas
# pat

# [1,2,3,4,nil, nil, '', 5, [6, nil, '', 7]]
# [1,2,3,4,nil, nil, '8', 5, [6, nil, '', 7]].flatten..select { |e| e.class == Integer && e.even? }

class A
  attr_accessor :a
  def initialize
    @a
  end
  # prote/cted :a
end

class B < A; end
class C < A; end

# B.new.a
# C.new.a

p C.new.class.class.superclass
p C.new.class.class.new.superclass
        # C   Class  Inst Object
# Object
