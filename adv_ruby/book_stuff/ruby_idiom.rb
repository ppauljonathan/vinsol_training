class A
  def xyz
    puts 'xyz'
  end
  p class << self;self;end
  p self
end

a = A.new
a.xyz

