
input = File.read("input.txt")

lines = input.split("\n")

rows = lines.map{|line| line.gsub(/\s+/, " ").split(" ") }

columns = []

rows[0].size.times do |col_i|
	col = []
	rows.each do |row|
		col.push row[col_i]
	end
	columns.push col
end

def calc(problem)
	operation = problem.last
	numbers = problem[...-1].map(&:to_i)
	case operation
	when "*"
		out = 1
		numbers.each {|num| out *= num }
		return out
	when "+"
		return numbers.sum
	end
end


grand_total = 0

columns.each do |col|
	grand_total += calc(col)
end

p grand_total


