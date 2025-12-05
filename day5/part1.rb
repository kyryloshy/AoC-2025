
input = File.read("input.txt")

ranges_txt, product_ids_txt = input.split("\n\n")

ranges = []
ranges_txt.split("\n").each do |range_str|
    ranges.push(range_str.split("-").map(&:to_i))
end

product_ids = product_ids_txt.split("\n").map(&:to_i)

def is_fresh(id, ranges)
    ranges.each do |range|
        if id <= range[1] && id >= range[0]
            return true
        end
    end
    return false
end


fresh_n = 0

product_ids.each do |id|
    fresh_n += 1 if is_fresh(id, ranges)
end

p fresh_n




