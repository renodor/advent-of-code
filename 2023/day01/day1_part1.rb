# frozen_string_literal: true

# Instructions: https://adventofcode.com/2023/day/1

input = File.open("./day01/day1_input.txt")

sum = input.sum do |line|
  numbers = line.scan(/\d/)
  "#{numbers.first}#{numbers.last}".to_i
end

puts sum
