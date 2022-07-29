# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/4

input = File.open('./day4/day4_input.txt').read

boards = input.split(/\n/)[2..].reject(&:empty?).each_slice(5).map do |board|
  {
    lines: board.map(&:split),
    winners_by_columns: [0, 0, 0, 0, 0]
  }
end

numbers = input.split(/\n/)[0].split(',')
numbers.each do |number|
  boards.each do |board|
    board[:lines].each do |line|
      next unless line.include?(number)

      number_index = line.index(number)
      board[:winners_by_columns][number_index] += 1
      line[number_index] = nil

      next unless board[:lines].any? { |l| l.all?(&:nil?) } || board[:winners_by_columns].include?(5)

      return puts board[:lines].flatten.map(&:to_i).sum * number.to_i
    end
  end
end
