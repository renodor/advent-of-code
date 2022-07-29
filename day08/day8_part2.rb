# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/8#part2

# (Brute force solution)

input = File.open('./day8/day8_input.txt').read

def validate_digits_against_mapping(digits, mapping)
  positions_needed_by_number = {
    '0' => %i[top top_left top_right bottom_left bottom_right bottom].sort,
    '1' => %i[top_right bottom_right].sort,
    '2' => %i[top top_right middle bottom_left bottom].sort,
    '3' => %i[top top_right middle bottom_right bottom].sort,
    '4' => %i[top_left top_right middle bottom_right].sort,
    '5' => %i[top top_left middle bottom_right bottom].sort,
    '6' => %i[top top_left middle bottom_left bottom_right bottom].sort,
    '7' => %i[top top_right bottom_right].sort,
    '8' => %i[top top_left top_right middle bottom_left bottom_right bottom].sort,
    '9' => %i[top top_left top_right middle bottom_right bottom].sort
  }

  digits_mapping = digits.chars.map do |letter|
    mapping.key(letter)
  end

  positions_needed_by_number.key(digits_mapping.sort)
end

outputs = input.split(/\n/).map do |entry|
  splited_entry = entry.split(' | ')
  signal = splited_entry[0].split(' ')
  output = splited_entry[1].split(' ')

  entry_mapping = {
    top: [],
    top_left: [],
    top_right: [],
    middle: [],
    bottom_left: [],
    bottom_right: [],
    bottom: []
  }

  # Find the obvious mapping thanks to the "easy" numbers
  signal.each do |digits|
    entries = digits.split('')

    case digits.size
    when 4
      entry_mapping[:top_left] = entries
      entry_mapping[:top_right] = entries
      entry_mapping[:middle] = entries
      entry_mapping[:bottom_right] = entries
    when 3
      entry_mapping[:top] = entries
      entry_mapping[:top_right] = entries
      entry_mapping[:bottom_right] = entries
    when 2
      entry_mapping[:top_right] = entries
      entry_mapping[:bottom_right] = entries
    else
      entry_mapping[:bottom_left] |= entries
      entry_mapping[:bottom] |= entries
    end
  end

  # Deducing all possible mappings from this initial "easy" numbers
  positions = entry_mapping.keys
  entries = entry_mapping.values
  # Seems to be Ruby conventional solution to combine array of array into all possible combinations:
  # https://stackoverflow.com/questions/5226895/combine-array-of-array-into-all-possible-combinations-forward-only-in-ruby
  mappings = entries[0].product(*entries[1..])
  all_possible_mapings = mappings.filter_map do |mapping|
    positions.zip(mapping).to_h unless mapping.uniq!
  end

  correct_mapping = all_possible_mapings.find do |possible_mapping|
    signal.all? { |digits| validate_digits_against_mapping(digits, possible_mapping) }
  end

  output_value = output.map { |digits| validate_digits_against_mapping(digits, correct_mapping) }

  output_value.join.to_i
end

puts outputs.sum
