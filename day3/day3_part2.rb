# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/3#part2

input = File.open('./day3/day3_input.txt').read

def find_bit_criteria(column, type)
  if type == 'max'
    column.count('1') >= column.count('0') ? '1' : '0'
  else
    column.count('1') >= column.count('0') ? '0' : '1'
  end
end

def find_rating(input, type: 'max')
  binary_codes = input.split(/\n/)
  binary_codes[0].size.times do |n|
    column = binary_codes.map(&:chars).transpose[n]
    bit_criteria = find_bit_criteria(column, type)
    binary_codes.select! { |binary_code| binary_code[n] == bit_criteria }

    return binary_codes[0].to_i(2) if binary_codes.size == 1
  end
end

oxygen_generator_rating = find_rating(input)
co2_scrubber_rating     = find_rating(input, type: 'min')

puts oxygen_generator_rating * co2_scrubber_rating
