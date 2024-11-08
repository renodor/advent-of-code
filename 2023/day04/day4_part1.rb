# frozen_string_literal: true

# Instructions: https://adventofcode.com/2023/day/4

input = File.open("./day04/day4_input.txt").read

result = input.split("\n").map do |line|
  card_number, all_numbers = line.split(": ")
  winning_numbers_string, numbers = all_numbers.split(" | ")

  winning_numbers = winning_numbers_string.split(" ").each_with_object({}) do |winning_number, hash|
    hash[winning_number] = true
  end

  wining_number_quantity = numbers.split(" ").filter_map { |number| winning_numbers[number] }.length

  [card_number, wining_number_quantity.positive? ? 2**(wining_number_quantity - 1) : 0]
end.to_h

p result.values.sum
