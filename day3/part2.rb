input = File.read("input.txt")

banks = input.split("\n")


def max_joltage(bank, n_batteries, battery_i, max_joltage_arr, start_i=0)
	check_range = start_i...(bank.size - n_batteries + 1 + battery_i)

	leading_digit = bank[check_range].max
	
	return max_joltage_arr if leading_digit < max_joltage_arr[battery_i]
	
	max_joltage_arr[battery_i] = leading_digit
	
	if battery_i + 1 == n_batteries
		return max_joltage_arr
	end
		
	check_range.each do |i|
		next if bank[i] != leading_digit
		
		max_joltage_arr = max_joltage(bank, n_batteries, battery_i + 1, max_joltage_arr, i + 1)
	end
	
	return max_joltage_arr
end

def max_joltage_start(bank, n_batteries)
	max_joltage_arr = max_joltage(bank, n_batteries, 0, [0] * n_batteries, 0)
	max_joltage_arr.each_with_index.map{|j, j_i| 10 ** (n_batteries - j_i - 1) * j }.sum
end


total_joltage = 0

banks.each_with_index do |bank, bank_i|
	print "\r#{bank_i + 1} / #{banks.size}"
	bank = bank.chars.map(&:to_i)
	total_joltage += max_joltage_start(bank, 12)
end

puts
p total_joltage
