# frozen_string_literal: true

# class with extended string functions
class ExtendedString < String
  def exclude_all?(*others)
    others.none? { |other| include? other }
  end

  def reverse_word_order
    split.reverse.join ' '
  end

  def shift_cipher(shift = 3)
    split('').each { |letter| shift.to_i.times { letter.succ! } }.join
  end

  def take(len)
    self[0..len.to_i - 1]
  end

  def reverse_iterate(&block)
    reverse.split('').each(&block)
  end
end

# class to interact with user
class DynamicMethodCaller
  def initialize
    @arg_list = []
  end

  def read_details
    print 'enter the object of ExtendedString class: '
    @obj = ExtendedString.new gets.chomp

    puts 'below are the methods available on this object: '
    p ExtendedString.instance_methods(false)

    print 'enter the function to execute: '
    @func = gets.chomp
    read_and_classify_params
  end

  def parse_params_and_evaluate
    if @arg_list[-1] == {}
      @arg_list.pop
      block = instance_eval(@arg_list.pop)
    end
    @obj.method(@func).call(*@arg_list, &block)
  end

  private

  def req_param(param_name)
    print "enter required argument #{param_name}: "
    @arg_list << gets.chomp
  end

  def opt_param(param_name)
    print 'the function requires an optional argument, enter (y/n): '
    enter_more = gets.chomp.downcase
    return unless enter_more == 'y'

    print "enter optional argument #{param_name} (press enter to leave empty): "
    @arg_list << gets.chomp
  end

  def rest_param
    puts 'the function expects multiple arguments:'
    print 'do you want to enter any arguments (y/n): '
    enter_more = gets.chomp.downcase
    while enter_more == 'y'
      print 'enter an argument: '
      @arg_list << gets.chomp
      print 'do you want to enter more (y/n): '
      enter_more = gets.chomp.downcase
    end
  end

  def block_param
    $/ = 'END'
    puts 'enter the block, in block form (with arguments, if any), type END to finish typing:'
    @arg_list << "Proc.new  #{gets.chomp}"
    @arg_list << {}
    $/ = "\n"
  end

  def read_and_classify_params
    args = @obj.method(@func).parameters
    args.each do |type, param_name|
      case type
      when :req then req_param param_name
      when :opt then opt_param param_name
      when :rest then rest_param
      when :block then block_param
      end
    end
  end
end

dmc1 = DynamicMethodCaller.new
dmc1.read_details
dmc1.parse_params_and_evaluate
