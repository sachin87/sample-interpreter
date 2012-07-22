# This program is written with ruby version ruby 1.9.3p194 (2012-04-20 revision 35410) [i686-linux]
# Author: Sachin Singh
# Date: 19-7-2012
# Version: 1.0.0

# Note: To this script you should have ruby(version 1.9.3) installed on your system,
# then to execute it write "ruby /path/to/ruby_interpreter.rb" on command prompt,
# means you have to specify file path

#require 'debugger'

class Interpreter

  attr_accessor :input, :hash
 
  def initialize
    @input = []
    @starting_square_brackets = 0
    @ending_square_brackets = 0
    @hash = Hash.new{|hash,key| hash[key] = []}
  end

  def run
    read_input
    evaluate_input
  end

  private

  def evaluate_input
    remove_outer_brackets
    input.each do |i|
      begin
        add_new_scope if i.include?('[')
        remove_upper_scope if i.include?(']')
        i.include?("print") ? display_output(i) : process_variables(i)
      rescue => e
        if e.class == NameError
          puts 0
        end
      end
    end
  end

  def read_input
    while true
      str = gets.chomp.downcase
      input << str
      show_error_message unless starting_with_square_bracket?
      if str == "["
        @starting_square_brackets +=1
      elsif str == "]"
        @ending_square_brackets +=1
        break if brackets_equal?
      end
    end
  end

  def brackets_equal?
    @starting_square_brackets == @ending_square_brackets
  end

  def remove_outer_brackets
    input.shift
    input.pop
  end

  def add_new_scope
    hash.each{|k,v| hash[k].unshift('.')}
  end

  def remove_upper_scope
    hash.each do |k,v|
      hash[k].each do |e|
        hash[k].shift
        break if e == '.'
      end
    end
  end

  def display_output(i)
    value = hash[i.split(" ").last]
    puts value.find{|i| i != "."}.to_i
  end

  def process_variables(i)
    sub = i.split(" ")
    first_element = sub[0]
    if first_element != '[' && first_element != ']'
      if sub[1].to_i != 0
        hash[first_element].unshift(sub[1])
      else
        hash[first_element].unshift(hash[sub[1]].find{|i| i != "."}.to_i)
      end
    end
  end

  def starting_with_square_bracket?
    input.first == "["
  end

  def show_error_message
    puts "Your input should start with opening square
          bracket([) and end with closing square bracket(])"
    exit
  end

end

obj = Interpreter.new
obj.run
