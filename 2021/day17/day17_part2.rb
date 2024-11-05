# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/17#part2

input = File.open('./day17/day17_input.txt').read

target = input.split(': ')[1].split(', ').each_with_object({}) do |coordinates, object|
  coordinates_array = coordinates.split('=')
  axis              = coordinates_array[0].to_sym
  range             = Range.new(*coordinates_array[1].split('..').map(&:to_i))

  object[axis] = range
end

valid_initial_velocity_count = 0

(0..target[:x].max).each do |x_range|
  (target[:y].min..500).each do |y_range|
    coordinates      = { x: x_range, y: y_range }
    initial_velocity = coordinates.dup
    position         = coordinates.dup
    step             = 0

    loop do
      # Prob reached the target
      if target[:x].include?(position[:x]) && target[:y].include?(position[:y])
        valid_initial_velocity_count += 1
        break
      end

      # Prob passed the target
      break if target[:x].max < position[:x] || target[:y].min > position[:y]

      if (initial_velocity[:x] - step).positive?
        position[:x] += (initial_velocity[:x] - step)
        position[:x] -= 1
      end

      position[:y] += (initial_velocity[:y] - step)
      position[:y] -= 1

      step += 1
    end
  end
end

puts valid_initial_velocity_count
