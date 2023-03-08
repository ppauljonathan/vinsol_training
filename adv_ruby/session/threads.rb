# t = Thread.new { puts 'Hello from Thread' }
# 
# puts 'hello'
# t.join

# threads = []
# 10.times do |time|
#   threads << Thread.new { puts "thread no #{time}" }
# end
# 
# threads.each(&:join)

def page_load_display(page)
  sleep rand(5)
  puts page
end

pages = %w( index about contact sermons )

pages.each_with_index do |page, index|
  t = Thread.new { page_load_display page }
  t.join
end
