function move(amount::Int, from::Int, to::Int)
    # Part One
    # for _ in 1:amount
    #     crate = pop!(stacks[from])
    #     push!(stacks[to], crate)
    # end

    # Part Two
    crates = []
    for _ in 1:amount
        push!(crates, pop!(stacks[from]))
    end
    append!(stacks[to], reverse(crates))
end

stacks = Vector{Vector{Char}}()
moves = Vector{Vector{Int}}()

state = "crates"

lines = readlines("day5.data.txt")
for line in lines
    if first(line, 2) == " 1" || line == ""
        global state = "moves"
        continue
    end

    if state == "crates"
        num_stacks = Int((length(line)+1)/4)
        if length(stacks) == 0
            foreach(_ -> push!(stacks, []), 1:num_stacks)
        end

        for i in 1:num_stacks
            crate = line[Int((i-1)*4+2)]
            if crate != ' '
                push!(stacks[i], crate)
            end
        end
    else
        rxMatch = match(r"move (\d+) from (\d+) to (\d+)", line)
        push!(moves, map(c -> parse(Int, c), rxMatch.captures))
    end
end

stacks = map(stack -> reverse(stack), stacks)

for mv in moves
    move(mv[1], mv[2], mv[3])
end

message = map(last, stacks)
println(message)
