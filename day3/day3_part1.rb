# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/3

input = File.open('./day3/day3_input.txt').read

gamma_rate = []
epsilon_rate = []
input.split(/\n/).map(&:chars).transpose.each do |numbers|
  if numbers.count('0') > numbers.count('1')
    gamma_rate << 0
    epsilon_rate << 1
  else
    gamma_rate << 1
    epsilon_rate << 0
  end
end

gamma_rate = gamma_rate.join.to_i(2)
epsilon_rate = epsilon_rate.join.to_i(2)

puts gamma_rate * epsilon_rate
