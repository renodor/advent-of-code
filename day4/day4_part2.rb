# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/4#part2

input = File.open('./day4/day4_input.txt').read

boards = input.split(/\n/)[2..].reject(&:empty?).each_slice(5).map.each_with_index do |board, index|
  {
    index: index,
    lines: board.map(&:split),
    winners_by_columns: [0, 0, 0, 0, 0]
  }
end

winning_boards = []

numbers = input.split(/\n/)[0].split(',')
numbers.each do |number|
  boards.each do |board|
    board[:lines].each do |line|
      next unless line.include?(number)

      number_index = line.index(number)
      board[:winners_by_columns][number_index] += 1
      line[number_index] = nil

      next unless board[:lines].any? { |l| l.all?(&:nil?) } || board[:winners_by_columns].include?(5)

      winning_boards |= [board]
      return puts board[:lines].flatten.map(&:to_i).sum * number.to_i if winning_boards.size == boards.size
    end
  end
end
