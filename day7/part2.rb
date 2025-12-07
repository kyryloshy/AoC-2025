input = File.read("input.txt")

grid = input.split("\n").map(&:chars)

def get(grid, pos)
	return grid[pos[0]][pos[1]]
end

# Implement a simple cache, because a lot of timelines will overlap
TIMELINES_CACHE = {}
def n_timelines(beam, grid)
	cache = TIMELINES_CACHE.fetch(beam) {|key| nil }
	if cache != nil
		return cache
	end
	
	new_pos = [beam[0] + 1, beam[1]]
	
	# If reached the end of the grid, only one timeline
	return 1 if new_pos[0] >= grid.size
	
	if get(grid, new_pos) == "^"
		splitbeam_left = [new_pos[0], new_pos[1] - 1]
		splitbeam_right = [new_pos[0], new_pos[1] + 1]
		total_timelines = n_timelines(splitbeam_left, grid) + n_timelines(splitbeam_right, grid)
		TIMELINES_CACHE[beam] = total_timelines
	else
		total_timelines = n_timelines(new_pos, grid)
		TIMELINES_CACHE[beam] = total_timelines
	end
	
	return total_timelines
end


start_line, start_y_pos = grid.each_with_index.filter{|line, line_i| line.include?("S") }[0]
_, start_x_pos = start_line.each_with_index.filter{|char, x_pos| char == "S" }[0]

start_beam = [start_y_pos, start_x_pos]

puts n_timelines(start_beam, grid)


