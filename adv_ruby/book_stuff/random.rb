def abc
  v2 = 10
  p v2
  yield if block_given?
end


v1 = 1

b = proc do
  p v1
  abc
end

v2 = 2

abc(&b)
