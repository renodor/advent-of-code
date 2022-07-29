# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/5#part2

input = File.open('./day5/day5_input.txt').read

segments = input.split(/\n/).map do |line|
  segment_pair = line.split(' -> ')
  first_segment = segment_pair[0].split(',')
  second_segment = segment_pair[1].split(',')

  {
    x1: first_segment[0].to_i,
    y1: first_segment[1].to_i,
    x2: second_segment[0].to_i,
    y2: second_segment[1].to_i
  }
end

def distance_between(value1, value2)
  ([value1, value2].min..[value1, value2].max).size
end

diagram = Hash.new(0)

segments.each do |segment|
  x_coef = segment[:x1] < segment[:x2] ? 1 : -1
  y_coef = segment[:y1] < segment[:y2] ? 1 : -1

  distance = distance_between(segment[:x1], segment[:x2])

  if segment[:x1] == segment[:x2]
    x_coef = 0
    distance = distance_between(segment[:y1], segment[:y2])
  end

  y_coef = 0 if segment[:y1] == segment[:y2]

  distance.times do |index|
    diagram["x#{segment[:x1] + (index * x_coef)}y#{segment[:y1] + (index * y_coef)}"] += 1
  end
end

puts diagram.values.select { |value| value >= 2 }.size
