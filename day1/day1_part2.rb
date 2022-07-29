# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/1#part2

input = File.open('./day1/day1_input.txt').read

depths = input.split(/\n/).map(&:to_i)

count = 0
depths.each_cons(4) do |arr|
  count += 1 if arr[1..].sum > arr[..2].sum
end

puts count
