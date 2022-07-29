locations = File.open('day9_inputs.txt').read.split(/\n/).map! { |location_line| location_line.split('').map!(&:to_i) }

def change_bassin_number(bassin_lines, old_bassin_number, new_bassin_number)
  bassin_lines.each_value do |points_infos|
    points_infos.each do |point_info|
      next unless point_info[:bassin_number] == old_bassin_number

      point_info[:bassin_number] = new_bassin_number
    end
  end
end

bassin_lines = {}
locations.each_with_index do |location_line, line_number|
  bassin_lines["_#{line_number}".to_sym] = []
  bassin_line = { point_indexes: [], bassin_number: nil }
  location_line.each_with_index do |point, index|
    if point == 9
      bassin_lines["_#{line_number}".to_sym] << bassin_line if bassin_line[:point_indexes].any?
      bassin_line = { point_indexes: [], bassin_number: nil }
    else
      bassin_line[:point_indexes] << index
    end
  end
  bassin_lines["_#{line_number}".to_sym] << bassin_line if bassin_line[:point_indexes].any?
end

bassin_count = 0
bassin_lines.each do |line_number, points_infos|
  points_infos.each_with_index do |point_info, i|
    unless point_info[:bassin_number]
      point_info[:bassin_number] = bassin_count
      bassin_count += 1
    end

    next_line = bassin_lines["_#{line_number.to_s.delete('_').to_i + 1}".to_sym]
    next unless next_line

    next_line.each do |next_line_point_infos|
      next unless (point_info[:point_indexes] & next_line_point_infos[:point_indexes]).any?

      next_line_point_infos[:bassin_number] = point_info[:bassin_number]

      next unless points_infos[i + 1] && (points_infos[i + 1][:point_indexes] & next_line_point_infos[:point_indexes]).any?

      old_bassin_number = points_infos[i + 1][:bassin_number]
      points_infos[i + 1][:bassin_number] = point_info[:bassin_number]
      change_bassin_number(bassin_lines, old_bassin_number, point_info[:bassin_number]) if old_bassin_number
    end
  end
end

bassins = Hash.new(0)
bassin_lines.each do |line_number, points_infos|
  points_infos.each do |point_info|
    bassins[point_info[:bassin_number]] += point_info[:point_indexes].size
  end
end

p bassins.values.sort[-3..-1].inject(:*)
