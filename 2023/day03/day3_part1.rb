# frozen_string_literal: true

# Instructions: https://adventofcode.com/2023/day/3

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

    engine[adjacent_element_y][adjacent_element_x]
  end
end

numbers = []
rejected_numbers = []
engine.each_with_index do |line, y|
  current_number = []
  add_to_numbers = false

  line.each_with_index do |element, x|
    if element.match?(/\d/)
      current_number << element
      add_to_numbers = true if adjacent_elements(engine, y, x).any? { |adjacent_element| adjacent_element.match?(/[^.\d]/) }
    end

    next if engine[y][x + 1]&.match?(/\d/)

    numbers << current_number.join.to_i if add_to_numbers
    rejected_numbers << current_number.join.to_i if current_number.any? && !add_to_numbers
    current_number = []
    add_to_numbers = false
  end
end

p numbers.sum
