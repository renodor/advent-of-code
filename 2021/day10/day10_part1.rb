# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/10

input = File.open('./day10/day10_input.txt').read

lines = input.split(/\n/).map(&:chars)

symbol_mapping = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}

symbol_points = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}

total_points = 0

lines.each do |line|
  chunk_checker = []

  line.each do |symbol|
    if symbol_mapping.keys.include?(symbol)
      chunk_checker << symbol
    elsif symbol_mapping[chunk_checker[-1]] == symbol
      chunk_checker.pop
    else
      total_points += symbol_points[symbol]
      break
    end
  end
end

puts total_points