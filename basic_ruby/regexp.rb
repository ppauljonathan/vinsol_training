foo = 30

def m1(a)
  foo = a
end

def m2
  foo
end

m1(10)
p foo
p m2