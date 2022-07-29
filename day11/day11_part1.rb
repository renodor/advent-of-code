# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/11

input = File.open('./day11/day11_input.txt').read

GRID = input.split(/\n/).map.each_with_index do |line, line_number|
  line.chars.map.each_with_index do |num, col_number|
    {
      num: num.to_i,
      x: col_number,
      y: line_number,
      flashed_this_step: false
    }
  end
end

def increase_adjascent_points(line, column)
  top_left     = GRID[line - 1]&.fetch(column - 1, nil) if column - 1 >= 0 && line - 1 >= 0
  top          = GRID[line - 1]&.fetch(column, nil) if line - 1 >= 0
  top_right    = GRID[line - 1]&.fetch(column + 1, nil) if line - 1 >= 0
  right        = GRID[line][column + 1]
  bottom_right = GRID[line + 1]&.fetch(column + 1, nil)
  bottom       = GRID[line + 1]&.fetch(column, nil)
  bottom_left  = GRID[line + 1]&.fetch(column - 1, nil) if column - 1 >= 0
  left         = GRID[line][column - 1] if column - 1 >= 0

  [top_left, top, top_right, right, bottom_right, bottom, bottom_left, left].compact.each do |adjascent_point|
    process_point(adjascent_point)
  end
end

def process_point(point)
  return if point[:flashed_this_step]

  point[:num] += 1

  return unless point[:num] == 10

  point[:num] = 0
  point[:flashed_this_step] = true
  increase_adjascent_points(point[:y], point[:x])
end

flash_count = 0
100.times do
  # At the beginning of each step, reset flashed_this_step to false for every point
  GRID.each { |line| line.each { |point| point[:flashed_this_step] = false } }

  # At each step, process each point
  GRID.each { |line| line.each { |point| process_point(point) } }

  # At the end of each step, count the flashes
  flash_count += GRID.map { |line| line.select { |point| point[:num].zero? } }.flatten.size
end

puts flash_count
