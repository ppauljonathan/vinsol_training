class String
  def to_time
    hms_arr = split(':')
    Time.new(0, 1, 1, hms_arr[0], hms_arr[1], hms_arr[2])
  end
end

class Time
  TIME_REGEX = /^([0-9]|0[0-9]|1[0-9]|2[0-3]):([0-9]|[0-5][0-9]):([0-9]|[0-5][0-9])$/.freeze

  def format_time_object
    no_of_days = (to_i - Time.new(0).to_i) / (3600 * 24)
    if no_of_days.nonzero?
      "#{no_of_days} day#{no_of_days > 1 ? 's ' : ' '}& #{strftime('%H:%M:%S')}".inspect
    else
      strftime('%H:%M:%S').inspect
    end
  end

  def self.add(time_string_array)
    if time_string_array.all?(TIME_REGEX)
      new_time_array = []
      time_string_array.each { |time_string| new_time_array << time_string.to_time }
      total_time = new_time_array.inject do |time_a, new_time|
        time_a + new_time.sec + new_time.min * 60 + new_time.hour * 3600
      end
      total_time.format_time_object
    else
      'Invalid 24-hour time value'
    end
  end
end

if ARGV.empty?
  puts 'Please provide an input'
else
  p Time.add ARGV
end
