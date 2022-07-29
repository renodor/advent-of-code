# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/14#part2

input = File.open('./day14/day14_input.txt').read

instructions = input.split(/\n\n/)
template     = instructions[0].chars
mapping      = instructions[1].split(/\n/).each_with_object({}) do |pair, hash|
  splited_pair = pair.split(' -> ')
  hash[splited_pair[0]] = splited_pair[1]
end

polymeres_count = template.each_cons(2).map(&:join).tally
polymeres_count.default = 0

elements_count = template.tally
elements_count.default = 0

40.times do
  current_pairs = polymeres_count.keys
  dup           = polymeres_count.dup

  current_pairs.each do |pair|
    pair_count  = dup[pair]
    new_element = mapping[pair]

    elements_count[new_element] += pair_count
    polymeres_count[pair]       -= pair_count

    polymeres_count["#{pair[0]}#{new_element}"] += pair_count
    polymeres_count["#{new_element}#{pair[1]}"] += pair_count
  end
end

puts elements_count.values.max - elements_count.values.min
