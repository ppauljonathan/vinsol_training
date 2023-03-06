# frozen_string_literal: true

class String
  NON_ALPHABET_REGEX = /[^a-z]/i.freeze
  def occurence_hash
    # oup_hash = Hash.new(0)
    # each_char do |char|
    #   oup_hash[char] += 1 unless char =~ NON_ALPHABET_REGEX
    # end
    # oup_hash
    split('')
      .inject(Hash.new(0)) do |result, char|
        result[char] += 1 unless char =~ NON_ALPHABET_REGEX
        result
      end
  end
end

if ARGV.empty?
  puts 'Please provide an input'
else
  p ARGV[0].occurence_hash
end
