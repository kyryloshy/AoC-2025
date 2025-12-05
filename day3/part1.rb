input = File.read("input.txt")

banks = input.split("\n")


def max_joltage(bank)
	max = 0
	(bank.size - 1).times do |i1|
		((i1 + 1)...(bank.size)).each do |i2|
			joltage = bank[i1] * 10 + bank[i2]
			max = joltage if joltage > max
		end
	end
	return max
end


total_joltage = 0

banks.each_with_index do |bank, bank_i|
	print "\r#{bank_i + 1} / #{banks.size}"
	bank = bank.chars.map(&:to_i)
	total_joltage += max_joltage(bank)
end

puts

p total_joltage
