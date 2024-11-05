# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/5

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

def range_from_min_to_max(value1, value2)
  ([value1, value2].min..[value1, value2].max)
end

diagram = Hash.new(0)

segments.each do |segment|
  if segment[:x1] == segment[:x2] # vertical line
    range_from_min_to_max(segment[:y1], segment[:y2]).each { |point| diagram["x#{segment[:x1]}y#{point}"] += 1 }
  elsif segment[:y1] == segment[:y2] # horizontal line
    range_from_min_to_max(segment[:x1], segment[:x2]).each { |point| diagram["x#{point}y#{segment[:y1]}"] += 1 }
  end
end

puts diagram.values.select { |value| value >= 2 }.size
