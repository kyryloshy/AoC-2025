


input = File.read("input.txt")

ranges_txt, product_ids_txt = input.split("\n\n")

ranges = []
ranges_txt.split("\n").each do |range_str|
    ranges.push(range_str.split("-").map(&:to_i))
end


considered_ranges = []

n_ids = 0

ranges.sort_by!{|r| -r[1] + r[0]}

ranges.each do |range|

    considered_ranges.each do |considered_range|
        lower_bound = range[0]
        upper_bound = range[1]
        if range[0] >= considered_range[0] && range[0] <= considered_range[1]
            lower_bound = considered_range[1] + 1
        end
        if range[1] >= considered_range[0] && range[1] <= considered_range[1]
            upper_bound = considered_range[0] - 1
        end
        range[0] = lower_bound
        range[1] = upper_bound
    end

    next if range[0] > range[1]

    n_range_ids = range[1] - range[0] + 1
    n_ids += n_range_ids
    considered_ranges.push range
end

p n_ids





