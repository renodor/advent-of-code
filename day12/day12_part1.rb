# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/12

input = File.open('./day12/day12_input.txt').read

# Create an hash with empty array as default value
CAVES = Hash.new { |h, k| h[k] = [] }

# Add each cave to the hash with the cave name as key and its cave connections as values
input.split(/\n/).each do |line|
  caves = line.split('-')
  first_cave = caves[0]
  second_cave = caves[1]

  CAVES[first_cave] << second_cave unless %w[start end].include?(first_cave)
  CAVES[second_cave] << first_cave unless %w[start end].include?(second_cave)
end

# Iterate over all caves and generate all possible valid pathes
def count_valid_pathes(caves, current_path = [], valid_pathes = [])
  caves.each do |cave, connections|
    # We must start a path with a "starting" cave
    next if current_path.empty? && !connections.include?('start')

    # We must not have 2 small caves in the same path
    next if cave.match?(/[[:lower:]]/) && current_path.include?(cave)

    new_path = current_path + [cave]

    # If we reach here and current cave is a "ending" cave, we have a new valid path
    valid_pathes << new_path if connections.include?('end')

    # We then need to do the same for all caves connected to current cave
    connected_caves = CAVES.select { |_key, value| value.include?(cave) }
    count_valid_pathes(connected_caves, new_path, valid_pathes)
  end

  valid_pathes.size
end

puts count_valid_pathes(CAVES)
