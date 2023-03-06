class A
  class << self
    attr_accessor :v1
  end

  def initialize
    self.class.v1 ||= 0
    self.class.v1 += 1
  end
end

class B < A; end
class C < A; end

p A.new.class.v1
p A.new.class.v1
p C.new.class.v1
p B.new.class.v1

