input = File.read("input.txt")

ranges = input.split(",").map{|range| range.split("-").map(&:to_i) }

invalid_id_sum = 0

def is_repeat_n_times(id, n)
	str = id.to_s
	return false if str.size % n != 0
	part_size = str.size / n
	return str[...part_size] * n == str	
end

def is_invalid_id(id)
	(2..(id.size)).each do |repeat_n|
		return true if is_repeat_n_times(id, repeat_n)
	end
	return false
end


ranges.each do |range|
	(range[0]..range[1]).each do |id|
		if is_invalid_id(id)
			invalid_id_sum += id
		end
	end
end

p invalid_id_sum
