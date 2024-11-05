# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/15

# Using Dijkstra's algorithm for finding shortest paths between nodes: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
# Also took inspiration from here: https://github.com/gchan/advent-of-code-ruby/tree/master/2021/day-15
# and here: https://github.com/damyvv/advent-of-code-2021/blob/master/solutions/day15.rb

input = File.open('./day15/day15_input.txt').read

grid = input.split("\n").map(&:chars).map { |row| row.map(&:to_i) }

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
