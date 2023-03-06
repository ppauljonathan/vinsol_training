class Turtle
  def move(&block)
    instance_eval(&block)
    # block.call
  end

  private

  def u(n); print 'u' * n; end

  def l(n); print 'l' * n; end

  def r(n); print 'r' * n; end

  def d(n); print 'd' * n; end
end

t = Turtle.new

@count = 10

t.move do
  # p @count # nil in instance_eval
  # 10 in call
  u 10
  d 2
  l 3
  r 4
end
