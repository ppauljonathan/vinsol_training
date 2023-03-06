class Hash
  def to_ary
    ["Hello", "World"]
  end
end

h1 = {a: "b", b: "c"}
a1 = [1, 2, 3, 4]

p h1.object_id
p h1.to_ary.object_id

p a1 + h1
