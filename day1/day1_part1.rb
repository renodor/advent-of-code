# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/1

input = File.open('./day1/day1_input.txt').read

depths = input.split(/\n/).map(&:to_i)

count = 0
depths.each_cons(2) do |arr|
  count += 1 if arr[1] > arr[0]
end

puts count
