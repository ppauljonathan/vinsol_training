# frozen_string_literal: true

# class for ruby REPL
class Interactive
  def self.greeter
    puts 'Welcome to The Interactive Ruby Evaluator'
    puts 'enter a blank line to evaluate instructions typed above it'
    puts 'enter q to exit'
  end

  def self.evaluate(command)
    ret = eval(command, TOPLEVEL_BINDING)
  rescue  => e
    p e
  else
    puts "=> #{ret.inspect}"
  end

  def self.run
    greeter
    command = ''
    input = ''
    while input.downcase != "q\n"
      print 'eval> '
      input = gets
      command += input
      if input == "\n"
        evaluate(command)
        command = ''
      end
    end
  end
end

Interactive.run
