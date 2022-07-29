# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/7

input = File.open('./day7/day7_input.txt').read

crab_positions = input.split(',').map(&:to_i)

fuels = []
crab_positions.uniq.sort.each do |crab_uniq_position|
  distances = crab_positions.map do |current_crab_position|
    (current_crab_position - crab_uniq_position).abs
  end

  fuels << distances.sum
end

puts fuels.min
