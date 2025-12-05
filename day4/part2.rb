
input = File.read("input.txt")

map = input.split("\n")

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

def remove_accessible_rolls(map)
	n_removed = 0
	map.size.times do |y|
		map[y].size.times do |x|
			next if map[y][x] != "@"
			next if !is_accessible(map, x, y)
			n_removed += 1
			map[y][x] = "."
		end
	end
	return n_removed, map
end

n_removed = 0
n_prev_removed = -1


while n_prev_removed != n_removed
	n_prev_removed = n_removed
	n_newly_removed, map = remove_accessible_rolls(map)
	n_removed += n_newly_removed
end

p n_removed

