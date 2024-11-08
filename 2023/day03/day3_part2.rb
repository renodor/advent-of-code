# frozen_string_literal: true

# Instructions: https://adventofcode.com/2023/day/3#part2

input = File.open("./day03/day3_input.txt").read

engine = input.split("\n").map(&:chars)

def adjacent_elements(engine, y, x)
  adjacent_positions = [
    [-1, -1], [-1, 0], [-1, 1], # Top-left, Top, Top-right
    [0, 1],                    # Right
    [1, 1], [1, 0], [1, -1],   # Bottom-right, Bottom, Bottom-left
    [0, -1]                    # Left
  ]

  adjacent_positions.filter_map do |adjacent_position_y, adjacent_position_x|
    adjacent_element_y = adjacent_position_y + y
    adjacent_element_x = adjacent_position_x + x

    next if adjacent_element_y.negative? || adjacent_element_x.negative? || adjacent_element_y >= engine.length || adjacent_element_x >= engine[0].length

    [engine[adjacent_element_y][adjacent_element_x], [adjacent_element_y, adjacent_element_x]]
  end.to_h
end

possible_gears = Hash.new { |h, k| h[k] = [] }

engine.each_with_index do |line, y|
  current_number = []
  possible_gear_coordinates = Set.new

  line.each_with_index do |element, x|
    if element.match?(/\d/)
      current_number << element

      adjacent_elements = adjacent_elements(engine, y, x)

      possible_gear_coordinates.add(adjacent_elements["*"]) if adjacent_elements["*"]
    end

    next if engine[y][x + 1]&.match?(/\d/)

    possible_gear_coordinates.each do |possible_gear_coordinate|
      possible_gears[possible_gear_coordinate] << current_number.join.to_i
    end

    current_number = []
    possible_gear_coordinates = Set.new
  end
end

sum = possible_gears.sum do |_, numbers|
  if numbers.length == 2
    numbers.inject(:*)
  else
    0
  end
end

p sum
