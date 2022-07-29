# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/6

input = File.open('./day6/day6_input.txt').read

qty_of_fishes_by_age = Hash.new(0)

input.split(',').map(&:to_i).each { |fish| qty_of_fishes_by_age[fish] += 1 }

80.times do
  zero_day_fishes = qty_of_fishes_by_age[0]

  (0..7).each { |n| qty_of_fishes_by_age[n] = qty_of_fishes_by_age[n + 1] }

  qty_of_fishes_by_age[6] += zero_day_fishes
  qty_of_fishes_by_age[8] = zero_day_fishes
end

puts qty_of_fishes_by_age.values.sum
