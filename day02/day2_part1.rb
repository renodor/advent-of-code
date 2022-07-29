# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/2

input = File.open('./day2/day2_input.txt').read

depth = 0
horizontal_position = 0

input.split(/\n/).each do |command|
  direction = command.split[0]
  value = command.split[1].to_i

  case direction
  when 'forward'
    horizontal_position += value
  when 'down'
    depth += value
  when 'up'
    depth -= value
  end
end

puts depth * horizontal_position
