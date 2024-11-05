# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/9

input     = File.open('./day9/day9_input.txt').read
locations = input.split(/\n/).map { |line| line.chars.map(&:to_i) }

risk = 0
locations.each_with_index do |location_line, line_number|
  location_line.each_with_index do |point, column_number|
    left_point   = location_line[column_number - 1] unless column_number.zero?
    right_point  = location_line[column_number + 1]
    top_point    = locations[line_number - 1][column_number] unless line_number.zero?
    bottom_point = locations[line_number + 1]&.dig(column_number)

    adjacent_points = [left_point, right_point, top_point, bottom_point].compact

    risk += (point + 1) if adjacent_points.all? { |adjacent_point| adjacent_point > point }
  end
end

puts risk
