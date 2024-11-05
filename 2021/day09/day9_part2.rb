# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/9#part2

input = File.open('./day9/day9_input.txt').read

locations = input.split(/\n/).map { |line| line.chars.map { |point| { num: point.to_i, bassin: nil } } }

# Group each point in the bassin it belongs to
bassin_count = 0
locations.each_with_index do |line, line_number|
  line.each_with_index do |point, column_number|
    next if point[:num] == 9

    unless point[:bassin]
      bassin_count += 1
      point[:bassin] = bassin_count
    end

    left_point   = line[column_number - 1] unless column_number.zero?
    right_point  = line[column_number + 1]
    top_point    = locations[line_number - 1][column_number] unless line_number.zero?
    bottom_point = locations[line_number + 1]&.dig(column_number)

    [left_point, right_point, top_point, bottom_point].compact.each do |adjascent_point|
      next if adjascent_point[:num] == 9

      adjascent_point_bassin = adjascent_point[:bassin]
      adjascent_point[:bassin] = point[:bassin]
      next unless adjascent_point_bassin && adjascent_point_bassin != point[:bassin]

      # Find all points adjacent to the current point and change their bassin number if it has changed
      locations.each do |location|
        location.select { |pt| pt[:bassin] == adjascent_point_bassin }
                .each   { |pt| pt[:bassin] = point[:bassin] }
      end
    end
  end
end

# Count number of points per bassin
count_bassin_elements = Hash.new(0)
locations.flatten.each do |point|
  next unless point[:bassin]

  count_bassin_elements[point[:bassin].to_s] += 1
end

# Find the three largest basins and multiply their sizes together
puts count_bassin_elements.values.sort[-3..].inject(:*)
