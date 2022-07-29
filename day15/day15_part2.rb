# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/15#part2

# Using Dijkstra's algorithm for finding shortest paths between nodes: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
# Also took inspiration from here: https://github.com/gchan/advent-of-code-ruby/tree/master/2021/day-15
# and here: https://github.com/damyvv/advent-of-code-2021/blob/master/solutions/day15.rb

# This part is slow, take around 25 seconds to execute.

input = File.open('./day15/day15_input.txt').read

small_grid = input.split("\n").map(&:chars).map { |row| row.map(&:to_i) }

small_grid_width  = small_grid[0].length
small_grid_height = small_grid.length

# Build the 5*5 bigger grid
grid = Array.new(small_grid_height * 5) { Array.new(small_grid_width * 5) }

small_grid.each_with_index do |row, row_number|
  row.each_with_index do |risk, column_number|
    5.times do |row_count|
      5.times do |column_count|
        new_row      = (row_count * small_grid_height) + row_number
        new_column   = (column_count * small_grid_width) + column_number
        new_risk     = risk + column_count + row_count
        new_risk    -= 9 if new_risk > 9

        grid[new_row][new_column] = new_risk
      end
    end
  end
end

def find_neighbours(grid, point)
  x = point[0]
  y = point[1]

  top    = [x - 1, y] unless x.zero?
  left   = [x, y - 1] unless y.zero?
  right  = [x, y + 1] unless (y + 1) == grid[0].length
  bottom = [x + 1, y] unless (x + 1) == grid.length

  [top, left, right, bottom].compact
end

risks          = {}
visited_points = {}

start_point = [0, 0]
end_point   = [grid.length - 1, grid[0].length - 1]

risks[start_point] = 0

loop do
  point = risks.min_by { |_point, risk| risk }[0]

  visited_points[point] = true

  find_neighbours(grid, point).each do |neighbour|
    next if visited_points[neighbour]

    x = neighbour[0]
    y = neighbour[1]

    new_neighbour_value  = grid[x][y] + risks[point]
    risks[neighbour]     = [new_neighbour_value, (risks[neighbour] || Float::INFINITY)].min
  end

  break if point == end_point

  risks.delete(point)
end

puts risks[end_point]
