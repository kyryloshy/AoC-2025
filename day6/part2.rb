
input = File.read("input.txt")

lines = input.split("\n")

operation_row = lines.last
number_rows = lines[...-1]

operations = operation_row.gsub(/\s+/, " ").split(" ")


number_columns = []
char_i = 0
column_numbers = []

while char_i < number_rows[0].size
	number_str = ""
	number_rows.each_with_index do |row, row_i|
		number_str += row[char_i]
	end
	
	if number_str.chars.uniq == [" "]
		number_columns.push column_numbers
		column_numbers = []
	else
		column_numbers.push number_str
	end
	
	char_i += 1
end
number_columns.push column_numbers # Push the last column


def calc(numbers, operation)
	numbers = numbers.map(&:to_i)
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

number_columns.zip(operations).each do |numbers, operation|
	grand_total += calc(numbers, operation)
end

p grand_total



