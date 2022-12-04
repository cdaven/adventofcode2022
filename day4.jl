function get_sections(interval::AbstractString)
    st, en = split(interval, "-")
    Set(range(parse(Int32, st), parse(Int32, en)))
end

count_fully_contained = 0
count_overlaps = 0

lines = readlines("day4.data.txt")
for i in eachindex(lines)
    elf1, elf2 = split(lines[i], ",")
    section1 = get_sections(elf1)
    section2 = get_sections(elf2)

    if issubset(section1, section2) || issubset(section2, section1)
        global count_fully_contained += 1
    end

    if length(intersect(section1, section2)) > 0
        global count_overlaps += 1
    end
end

println(count_fully_contained)
println(count_overlaps)
