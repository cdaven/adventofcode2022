function split_by_elf(lines::Vector{String})
    grouped_lines = Vector{Int32}[]
    current_group = Int32[]
    for i in 1:length(lines)
        if lines[i] == ""
            push!(grouped_lines, current_group)
            current_group = Int32[]
        else
            push!(current_group, parse(Int32, lines[i]))
        end
    end
    grouped_lines
end

lines = readlines("day1.data.txt")
calories_by_elf = split_by_elf(lines)
total_calories_by_elf = sort(map(calories -> sum(calories), calories_by_elf))

println(last(total_calories_by_elf, 1))
println(sum(last(total_calories_by_elf, 3)))
