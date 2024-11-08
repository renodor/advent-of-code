# frozen_string_literal: true

# Instructions: https://adventofcode.com/2023/day/1#part2

input = File.open("./day01/day1_input.txt")

word_to_number = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}

sum = input.sum do |line|
  numbers = line.scan(/(?=(#{word_to_number.keys.join("|")}|\d))/).flatten
  numbers = [numbers.first, numbers.last]
  numbers = numbers.map { |number| word_to_number[number] || number }.join

  numbers.to_i
end

puts sum