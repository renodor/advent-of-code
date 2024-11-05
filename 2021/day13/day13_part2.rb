# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/13#part2

input = File.open('./day13/day13_input.txt').read

splited_input     = input.split(/\n\n/)
points            = splited_input[0].split(/\n/).map { |point| point.split(',').map(&:to_i) }
fold_instructions = splited_input[1].split(/\n/).map { |instruction| instruction.delete('fold along ').split('=') }

number_of_lines   = points.map(&:last).max + 1
number_of_columns = points.map(&:first).max + 1

# Build grid
grid = {}
number_of_lines.times do |line|
  grid[line.to_s] = Array.new(number_of_columns, false)
end

points.each do |point|
  grid[point[1].to_s][point[0]] = true
end

def fold_y(grid, y_axis)
  grid.each do |line, columns|
    next if line.to_i < y_axis

    columns.each_with_index do |column, index|
      next unless column

      grid[(y_axis - (line.to_i - y_axis)).to_s][index] = true
    end

    grid.delete(line)
  end
end

def fold_x(grid, x_axis)
  grid.each do |line, columns|
    new_columns = []
    columns.each_with_index do |column, index|
      if index < x_axis
        new_columns << column
      elsif index > x_axis && column
        new_columns[x_axis - (index - x_axis)] = true
      end
    end

    grid[line] = new_columns
  end
end

def fold(grid, instruction)
  if instruction[0] == 'x'
    fold_x(grid, instruction[1].to_i)
  else
    fold_y(grid, instruction[1].to_i)
  end
end

# Fold grid
fold_instructions.each do |fold_instruction|
  fold(grid, fold_instruction)
end

# Visualize grid
grid.each_value do |column|
  puts column.map { |point| point ? '#' : '.' }.join(' ')
end
