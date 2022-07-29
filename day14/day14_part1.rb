# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/14

input = File.open('./day14/day14_input.txt').read

instructions = input.split(/\n\n/)
template     = instructions[0].chars
mapping      = instructions[1].split(/\n/).each_with_object({}) do |pair, hash|
  splited_pair = pair.split(' -> ')
  hash[splited_pair[0]] = splited_pair[1]
end

10.times do
  new_template = []
  template.each_cons(2) do |pair|
    new_template << pair[0]
    new_template << mapping[pair.join]
  end

  new_template << template.last

  template = new_template
end

element_count_values = template.tally.values

puts element_count_values.max - element_count_values.min
