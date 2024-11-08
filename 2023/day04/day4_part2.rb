# frozen_string_literal: true

# Instructions: https://adventofcode.com/2023/day/4#part2

require "pry"

input = File.open("./day04/day4_input.txt").read

cards_quantity = Hash.new(0)

input.split("\n").map do |line|
  card_number, all_numbers = line.split(": ")
  winning_numbers_string, numbers = all_numbers.split(" | ")
  card_number = card_number.split.last.to_i

  winning_numbers = winning_numbers_string.split(" ").each_with_object({}) do |winning_number, hash|
    hash[winning_number] = true
  end

  winning_number_quantity = numbers.split(" ").filter_map { |number| winning_numbers[number] }.length
  cards_quantity[card_number] += 1

  winning_number_quantity.times do |n|
    cards_quantity[card_number + n + 1] += cards_quantity[card_number]
  end
end

p cards_quantity.values.sum
