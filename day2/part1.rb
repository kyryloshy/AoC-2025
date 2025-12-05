input = File.read("input.txt")

ranges = input.split(",").map{|range| range.split("-").map(&:to_i) }

invalid_id_sum = 0


def is_invalid_id(id)
	id_str = id.to_s
	return false if id_str.size % 2 != 0
	part_size = id_str.size / 2
	return id_str[0...part_size] == id_str[part_size..]
end


ranges.each do |range|
	(range[0]..range[1]).each do |id|
		if is_invalid_id(id)
			invalid_id_sum += id
		end
	end
end

p invalid_id_sum
