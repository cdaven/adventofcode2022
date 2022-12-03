function get_priority(item::Char)
    ascii_val = Int(item)
    if ascii_val >= 97
        # Lowercase
        ascii_val - 96
    else
        # Uppercase
        ascii_val - 38
    end
end

sum_of_priorities = 0
current_group = Vector{Char}[]

lines = readlines("day3.data.txt")
for i in eachindex(lines)
    # Part 1
    # compartment_size = Int(length(lines[i]) / 2)
    # comp1 = first(lines[i], compartment_size)
    # comp2 = last(lines[i], compartment_size)
    # common_item = first(intersect(unique(comp1), unique(comp2)))
    # priority = get_priority(common_item)
    # global sum_of_priorities += priority

    # Part 2
    push!(current_group, unique(lines[i]))
    if length(current_group) == 3
        common_item = first(intersect(current_group[1], intersect(current_group[2], current_group[3])))
        priority = get_priority(common_item)
        global sum_of_priorities += priority
        global current_group = Vector{Char}[]
    end
end

println(sum_of_priorities)
