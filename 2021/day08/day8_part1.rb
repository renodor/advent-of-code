# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/8

input = File.open('./day8/day8_input.txt').read

easy_digits = [2, 4, 3, 7]

count = input.split(/\n/).map do |output|
  output.split(' | ')[1].split(' ').count do |digit|
    easy_digits.include?(digit.size)
  end
end

puts count.sum
