class A
	@var = 1
	@@var2 = 1
	
	class << self
		attr_accessor :var, :var2
	end
	
	
	def getvar2
		@var
	end
	
	def setvar2(arg)
		@var = arg
	end
end

class B < A
end

a = A.new
b = B.new

# p A.var2
# A.var2=10
# p A.var2
# p B.var2

p a.getvar2 
p b.getvar2 
p a.setvar2 10
p a.getvar2
p b.getvar2


str.sub(/\w+$/, 'Shubham')

[1].any? {}, false
[1].all? {}, false
[1].none? {}, true
[nil].any?, true
[nil].all? {}, false
[nil].none? {} true


%w{1 2 nil}.compact

['1', '2', 'nil']


('cat'..'mat').to_a

cat
cau
cav


mar
mas
mat


class A
module
object
basicobject

class Movie
	@@movies = []
end

class Bollywo


Bol
@@movies << self

self.all

@@movies.map { |movie|  movie.name if movie.class == self }.compact

@@movies.select { |movie| movie.class }

