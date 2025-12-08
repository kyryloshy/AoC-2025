
input = File.read("input.txt")

box_data = input.split("\n")

boxes = box_data.map{|box| box.split(",").map(&:to_i) }

def calc_distance(box1, box2)
	return Math.sqrt((box1[0] - box2[0]) ** 2 + (box1[1] - box2[1]) ** 2 + (box1[2] - box2[2]) ** 2)
end


def get_n_closest_boxes(boxes, n)
	closest_distances = []
	closest_indexes = []
	
	(0...(boxes.size - 1)).each do |i_b1|
		print "\r#{i_b1 + 2} / #{boxes.size}"
		((i_b1 + 1)...boxes.size).each do |i_b2|
			distance = calc_distance(boxes[i_b1], boxes[i_b2])
			# puts "#{[i_b1, i_b2]} - #{distance}"
			if closest_distances.size < n || distance < closest_distances.last
				i = closest_distances.size
				while i > 0
					break if closest_distances[i - 1] < distance
					i -= 1
				end
				# puts "Set #{i}"
				closest_distances.insert i, distance
				closest_indexes.insert i, [i_b1, i_b2]
				closest_distances = closest_distances[...n]
				closest_indexes = closest_indexes[...n]
			end
		end
	end
	
	puts
	
	closest_indexes
end


iterations = 1000

connected_boxes = get_n_closest_boxes(boxes, iterations)


circuits = []

connected_boxes.each do |i1, i2|
	# puts
	# p [i1, i2]
	
	i1_circuit = circuits.each_with_index.filter{|circuit, circuit_i| circuit.include?(i1) }
	i2_circuit = circuits.each_with_index.filter{|circuit, circuit_i| circuit.include?(i2) }
	
	if i1_circuit.size == 0 && i2_circuit.size == 0
		# puts "S1"
		circuits.push [i1, i2]
	elsif i1_circuit.size == 0
		# puts "S2"
		circuits[i2_circuit[0][1]].push i1
	elsif i2_circuit.size == 0
		# puts "S3"
		circuits[i1_circuit[0][1]].push i2
	else
		# puts "S4"
		c1_i = i1_circuit[0][1]
		c2_i = i2_circuit[0][1]
		if c1_i != c2_i
			c1 = circuits[c1_i]
			c2 = circuits[c2_i]
			c1 = (c1 + c2).uniq
			circuits[c1_i] = c1
			circuits.delete_at c2_i
		end
	end
	
	# p circuits
end


circuit_sizes = circuits.map(&:size)

circuit_sizes.sort!.reverse!

out = 1

circuit_sizes[...3].each do |size|
	out *= size
end

p out


