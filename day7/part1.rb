input = File.read("input.txt")

grid = input.split("\n").map(&:chars)


def get(grid, pos)
	return grid[pos[0]][pos[1]]
end

def out_of_bounds(pos, grid)
	return pos[0] < 0 || pos[0] >= grid.size || pos[1] < 0 || pos[1] >= grid[0].size
end

def process_beams(beams, grid)
	
	new_beams = []
	n_splits = 0
	
	beams.each do |beam|
		new_pos = [beam[0] + 1, beam[1]]
		
		next if out_of_bounds(new_pos, grid) # Skip when out of bounds
		
		if get(grid, new_pos) == "^"
			splitbeam_1 = [new_pos[0], new_pos[1] - 1]
			splitbeam_2 = [new_pos[0], new_pos[1] + 1]
			
			new_beams.push(splitbeam_1) if !out_of_bounds(splitbeam_1, grid) && !new_beams.include?(splitbeam_1)
			new_beams.push(splitbeam_2) if !out_of_bounds(splitbeam_2, grid) && !new_beams.include?(splitbeam_2)
			n_splits += 1
		else
			new_beams.push(new_pos) if !new_beams.include?(new_pos)
		end
	end
	
	return n_splits, new_beams
end


beams = []

start_line, start_y_pos = grid.each_with_index.filter{|line, line_i| line.include?("S") }[0]
_, start_x_pos = start_line.each_with_index.filter{|char, x_pos| char == "S" }[0]

beams.push [start_y_pos, start_x_pos]

total_splits = 0

while true
	n_splits, beams = process_beams(beams, grid)
	total_splits += n_splits
	break if beams.size == 0
end

p total_splits


