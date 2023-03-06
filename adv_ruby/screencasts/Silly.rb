class Silly
  def meth_1
    @var = 99 # inst var alwys stored in self
    meth_2 # default receiver -> self
  end

  def meth_2
    puts "@var is #{@var}" # calls self.var since no explicit
  end
end

s = Silly.new
s.meth_1
# s is explicitly called
# self -> s .class -> meth_1

class A
  def pub_meth
    self.priv_meth # still implicit calling as self is not changed
  end

  private
  def priv_meth
    p "hi"
  end
end

A.new.pub_meth
