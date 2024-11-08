# frozen_string_literal: true

# Instructions: https://adventofcode.com/2023/day/2#part2

input = File.open("./day02/day2_input.txt").read

requirements = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

sum_of_power = input.split("\n").sum do |game|
  game = game.split(": ")

  game_id = game[0].match(/Game (\d+)/)[1]
  sets = game[1].split("; ")
  min_cubes = Hash.new(0)

  sets.each do |set|
    set.split(", ").each do |cube|
      quantity = cube.split[0].to_i
      color = cube.split[1]

      min_cubes[color] = [min_cubes[color], quantity].max
    end
  end

  min_cubes.values.inject(&:*)
end

puts sum_of_power
