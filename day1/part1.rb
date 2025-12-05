
input_lines = File.readlines("input.txt")

loc = 50

count = 0	

input_lines.each do |line|
	dir = line[0]
	n = line[1..].to_i
	dir = dir == "R" ? 1 : -1
	
	loc += dir * n
	loc = loc % 100
	
	if loc == 0
		count += 1
	end
end

puts count

