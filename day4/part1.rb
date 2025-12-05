
input = File.read("input.txt")

map = input.split("\n")

n_accessibe = 0

def is_accessible(map, x, y)
	n_rolls_around = 0
	((y-1)..(y+1)).each do |test_y|
		next if test_y < 0 || test_y >= map.size
		((x-1)..(x+1)).each do |test_x|
			next if test_x < 0 || test_x >= map[y].size
			next if test_x == x && test_y == y
			n_rolls_around += 1 if map[test_y][test_x] == "@"
		end
	end
	return n_rolls_around < 4
end

map.size.times do |y|
	map[y].size.times do |x|
		next if map[y][x] != "@" # Skip non-paper cells
		n_accessibe += 1 if is_accessible(map, x, y)
	end
end


p n_accessibe


