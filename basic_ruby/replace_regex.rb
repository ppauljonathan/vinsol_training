# frozen_string_literal: true

# Using Ruby version: ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]
# Your Ruby code here

class String
  VOWEL_REGEX = /[aeiou]/i.freeze
  def replace_vowel_with_star
    gsub(VOWEL_REGEX, '*')
  end
end

if ARGV.empty?
  puts 'Please provide an input'
else
  puts ARGV[0].replace_vowel_with_star
end
