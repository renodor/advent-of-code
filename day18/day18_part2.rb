# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/18

# This part is slow, take around 8 seconds to execute.

require 'json'

input = File.open('./day18/day18_input.txt').read

numbers = input.split("\n").map { |number| JSON.parse(number) }

def depth(array)
  return 0 unless array.is_a?(Array)

  array.to_a == array.flatten(1) ? 1 : depth(array.flatten(1)) + 1
end

def add_exploded_pair(numbers, nested_indexes, num_to_add, type:)
  # Define what are the "inside" and "outside" indexes, regarding if the num_to_add needs to be added to previous or next element
  # When adding to previous element, outside is on the left, (index 0 of a pair), and inside is on the right (index 1 of a pair),
  # When adding to next element, outside is on the right (index 1 of a pair), and inside is on the left (index 0 of a pair)
  case type
  when 'next'
    inside_index  = 0
    outside_index = 1
  when 'previous'
    inside_index  = 1
    outside_index = 0
  end

  # If there are no "outside" elements, the num_to_add can't be added to any element
  # If the num_to_add is 0, there is nothing to add
  return if nested_indexes.all? { |index| index == outside_index } || num_to_add.zero?

  # Find the closest element to which the num_to_add needs to be added
  # (for that we need to "climb back" array from the exploded pair until we are on the first "inside" element,
  # then the "outside" element of this "inside" element, is the element to which we need to add the exploded pair)
  nested_indexes.pop until nested_indexes.last == inside_index
  nested_indexes[-1] = outside_index
  closest_element = numbers.dig(*nested_indexes)

  # Dig into this closest element until we reach the first "inside" integer
  # the num_to_add needs to be added to this "inside" integer
  until closest_element.is_a?(Integer)
    nested_indexes << inside_index
    closest_element = numbers.dig(*nested_indexes)
  end

  # In order to use #[]= Array assignment method we need to climb back one step)
  last_index = nested_indexes.pop

  # Now if nested_indexes is empty, numbgers.dig(nil) would raise an error,
  # but this means the num_to_add can simply be added to the outside element of the highest pair of the array.
  # Otherwise just use #[]= with the last_index we saved to add the num_to_add to the correct element
  if nested_indexes.empty?
    numbers[outside_index] += num_to_add
  else
    numbers.dig(*nested_indexes)[last_index] += num_to_add
  end
end

def explode(numbers)
  wanted_depth   = 4
  nested_indexes = [0]
  depth          = depth(numbers.dig(*nested_indexes))

  # Find the first pair that is nested inside four pairs
  until nested_indexes.size == 4 && depth == 1
    if depth == wanted_depth
      nested_indexes << 0
      wanted_depth -= 1
    else
      nested_indexes[-1] += 1
    end

    depth = depth(numbers.dig(*nested_indexes))
  end

  exploded_pair = numbers.dig(*nested_indexes)

  # Replace the exploded pair with 0
  # (In order to use #[]= Array assignment method we need to climb back one step)
  numbers.dig(*nested_indexes[..-2])[nested_indexes[-1]] = 0

  # Add the right part of the exploded pair to the next element
  add_exploded_pair(numbers, nested_indexes.dup, exploded_pair[1], type: 'next')

  # Add the left part of the exploded pair to the previous element
  add_exploded_pair(numbers, nested_indexes, exploded_pair[0], type: 'previous')

  numbers
end


def split(numbers)
  nested_indexes  = [0]
  current_element = numbers[0]

  # Find the nested indexes of the integer that is >= 10
  until current_element.is_a?(Integer) && current_element >= 10
    if current_element.is_a?(Array)
      nested_indexes << 0
    else
      nested_indexes.pop until nested_indexes.last.zero?
      nested_indexes[-1] += 1
    end

    current_element = numbers.dig(*nested_indexes)
  end

  # Split the integer that is >= 10
  last_index = nested_indexes.pop
  numbers.dig(*nested_indexes)[last_index] = [current_element / 2, (current_element.to_f / 2).ceil]

  numbers
end

def magnitude(array)
  until depth(array) == 1
    array.map! do |element|
      if element.is_a?(Array) && depth(element) > 1
        magnitude(element)
      elsif element.is_a?(Array)
        (element[0] * 3) + (element[1] * 2)
      else
        element
      end
    end
  end

  (array[0] * 3) + (array[1] * 2)
end

biggest_magnitude = 0
numbers.each do |array|
  numbers.each do |other_array|
    next if other_array == array

    # Arrays and sub arrays are modified during the explode, split or magnitude operations,
    # so we need to make a deep copy of the original arrays before manipulating it
    addition = Marshal.load(Marshal.dump([array, other_array]))

    loop do
      if depth(addition) == 5
        addition = explode(addition)
      elsif addition.flatten.any? { |num| num >= 10 }
        addition = split(addition)
      else
        break
      end
    end

    biggest_magnitude = [magnitude(addition), biggest_magnitude].max
  end
end

puts biggest_magnitude
