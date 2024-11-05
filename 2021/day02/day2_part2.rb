# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/2#part2

input = File.open('./day2/day2_input.txt').read

depth = 0
horizontal_position = 0
aim = 0

input.split(/\n/).each do |command|
  direction = command.split[0]
  value = command.split[1].to_i

  case direction
  when 'forward'
    horizontal_position += value
    depth += (aim * value)
  when 'down'
    aim += value
  when 'up'
    aim -= value
  end
end

puts depth * horizontal_position
