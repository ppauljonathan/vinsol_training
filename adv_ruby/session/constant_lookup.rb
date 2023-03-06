# frozen_string_literal: false
# Module.nesting

# 1) Module.nesting
# 2) Module.nesting.first's ancestor chain
# 3) Object

# C = 15
# module A
#   # C = 20
#   module B
#     C = 10
#   end

#   module D
#     # puts B::C
#     # puts ::C
#     # puts Object::C
#     # p Module.nesting
#     # p Module.nesting.first
#   end
# end

# module A
#   module D
#     # puts B::C
#     p Module.nesting
#   end
# end

# module A::D
#   # puts B::C # throws error
#   p Module.nesting
# end

# Ancestors

# looks in Module.nesting.first.ancestors
# class A
#   # C = 30
#   class B
#     C = 10
#   end
#   class D
#     # puts C
#     p Module.nesting
#   end
# end

# class A
#   class X < B
#     puts C
#     p Module.nesting
#     p Module.nesting.first.ancestors
#   end
# end

# class A::X
#   puts C
#   # p Module.nesting
#   # p Module.nesting.first.ancestors
# end

# does not look in ancestor chain of others in Module.nesting
# class A
#   class B
#     C = 10
#   end
# end

# class D < A
#   class E
#     p C # throws error
#     p ancestors
#   end
# end

# class_eval

# class A
#   B = 20
# end

# class C
#   B = 30
#   p A.class_eval { B }
#   p A.class_eval { B == A::B }
#   p A.class_eval { Module.nesting }
#   # because block takes the scope in which it is defined
# end

# class Y
#   B = 20
# end

# class A < Y
#   # module B; end
# end

# class C
#   B = 30
#   p A.class_eval 'B'
#   p A.class_eval 'B == A::B'
#   p A.class_eval 'Module.nesting'
#   # string is evaluated in A's scope
#   # nesting is [A, C] as A is opened inside C
# end

# instance eval

# class A
#   B = 20
# end

# class C
#   B = 10
#   p A.instance_eval { B }
#   p A.instance_eval { B == A::B }
#   p A.instance_eval { Module.nesting }
#   # because block takes the scope in which it is defined
# end

# class A
#   B = 10
# end

# class C
#   B = 30
#   p A.instance_eval 'B'
#   p A.instance_eval 'B == A::B'
#   p A.instance_eval 'Module.nesting'
#   class << A
#   end
#   # instance eval is evaluated in A's singleton
#   # nesting is [#<Class:A>, C] as A's singleton is opened inside C
# end

# A.new.instance_eval
# TODO

# class A
#   B = 10
# end

# class C
#   B = 30
#   p A.new.instance_eval 'B'
#   p A.new.instance_eval 'B == A::B'
#   p A.new.instance_eval 'Module.nesting'
#   # instance eval is evaluated in A's singleton
#   # nesting is [#<Class:A>, C] as A's singleton is opened inside C
# end

# singleton

# class A
#   module B; end
#   class << self
#     p B # this works
#     p Module.nesting # nesting includes A
#   end
# end

# class << A
#   # p B # doesn't work
#   p Module.nesting # nesting does not include A
#   p ancestors # ancestor chain does not include A
# end

# class BasicObject
#   C = 10
# end

# module X
#   puts C
# end

# class Y
#   puts C
# end

# p ::C
# p Object::C
# p C