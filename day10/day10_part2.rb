# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/10#part2

input = File.open('./day10/day10_input.txt').read

lines = input.split(/\n/).map(&:chars)

symbol_mapping = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}

symbol_points = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

points = []

lines.each do |line|
  incomplete_line = []

  line.each_with_index do |symbol, index|
    if symbol_mapping.keys.include?(symbol)
      incomplete_line << symbol
    elsif symbol_mapping[incomplete_line[-1]] == symbol
      incomplete_line.pop
    else
      break
    end

    next unless index == line.size - 1

    line_score = 0
    incomplete_line.reverse.each do |sym|
      line_score = (5 * line_score) + symbol_points[symbol_mapping[sym]]
    end
    points << line_score
  end
end

puts points.sort[points.size / 2]
