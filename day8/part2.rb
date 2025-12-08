
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


def get_circuits(connected_boxes)
	circuits = []

	connected_boxes.each do |i1, i2|
		i1_circuit = circuits.each_with_index.filter{|circuit, circuit_i| circuit.include?(i1) }
		i2_circuit = circuits.each_with_index.filter{|circuit, circuit_i| circuit.include?(i2) }
		
		if i1_circuit.size == 0 && i2_circuit.size == 0
			circuits.push [i1, i2]
		elsif i1_circuit.size == 0
			circuits[i2_circuit[0][1]].push i1
		elsif i2_circuit.size == 0
			circuits[i1_circuit[0][1]].push i2
		else
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
	end
	
	circuits
end


# Sort-of a binary search to find the number of iterations when all boxes are connected

# First, find the lower and upper bounds for the number of iterations

start_iterations = 1

test1_iterations = start_iterations
test1_increment = 1000 # Increment for every iteration to find the upper bound

puts "Finding upper bound of iterations for a complete circuit"

while true
	puts "Testing #{test1_iterations} iterations"
	connected_boxes = get_n_closest_boxes(boxes, test1_iterations)
	circuits = get_circuits(connected_boxes)
	break if circuits[0].size == boxes.size && circuits.size == 1
	test1_iterations += test1_increment
end

upper_bound = test1_iterations # At this bound the circuit is complete
lower_bound = test1_iterations - test1_increment # At this bound the circuit is still incomplete

puts "\n\n"
puts "Finding the exact minimum amount of iterations for a complete circuit"

# Semi binary search to find when the circuit turns from incomplete to complete
while true
	iters_next = (upper_bound + lower_bound) / 2 # Current amount of iters
	iters_prev = iters_next - 1 # Previous amount of iters
	
	puts "Testing #{iters_prev} iterations"
	
	iters_prev_circuits = get_circuits(connected_boxes[...iters_prev])
	iters_prev_complete = iters_prev_circuits[0].size == boxes.size # Boolean that tells whether the circuit is complete at 'iters_prev'
	
	iters_next_circuits = get_circuits(connected_boxes[...iters_next]) # Boolean that tells whether the circuit is complete at 'iters_next'
	iters_next_complete = iters_next_circuits[0].size == boxes.size
	
	if !iters_prev_complete && iters_next_complete
		# Here if at iters_prev the circuit is incomplete, but is complete at 'iterations'
		# This means the correct value was found
		break
	elsif iters_next_complete && iters_prev_complete
		# If both circuits are complete, move the upper bound lower
		upper_bound = iters_next
	elsif !iters_next_complete && !iters_prev_complete
		# If both circuits are incomplete, move the lower bound higher
		lower_bound = iters_next
	else
		# This shouldn't happen (circuit complete at iters_prev, but not at iters_next)
		puts "SOMETHING IS WRONG"
		exit
	end
end

puts "\n\n"


final_iter = iters_prev

puts "The last iteration to complete the circuit is #{final_iter}"

puts "The last two boxes to connect are ##{connected_boxes[final_iter][0]} and ##{connected_boxes[final_iter][1]}"

b1 = boxes[connected_boxes[final_iter][0]]
b2 = boxes[connected_boxes[final_iter][1]]

puts "Box1_x * Box2_x is #{b1[0] * b2[0]}"


