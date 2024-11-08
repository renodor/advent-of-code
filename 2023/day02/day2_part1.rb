# frozen_string_literal: true

# Instructions: https://adventofcode.com/2023/day/2

input = File.open("./day02/day2_input.txt").read

requirements = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

game_ids_sum = input.split("\n").sum do |game|
  game = game.split(": ")

  game_id = game[0].match(/Game (\d+)/)[1]
  sets = game[1].split("; ")

  allowed = sets.all? do |set|
    set.split(", ").all? do |cube|
      quantity = cube.split[0].to_i
      color = cube.split[1]

      quantity <= requirements[color]
    end
  end

  allowed ? game_id.to_i : 0
end

puts game_ids_sum
