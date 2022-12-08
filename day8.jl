function parse_matrix(lines::Vector{String})
    matrix = Vector{Vector{Int}}()
    for line in lines
        vector = Int8[]
        for digit in line
            push!(vector, parse(Int, digit))
        end
        push!(matrix, vector)
    end
    reduce(hcat, matrix)
end

function count_viewing_distance(tree::Int, direction::Vector{Int})
    distance = 0
    for t in direction
        distance += 1
        if t >= tree
            break
        end
    end
    distance
end

function is_tree_visible(forest::Matrix{Int}, x::Int, y::Int)
    tree = forest[x, y]
    # Left
    if all(tree .>forest[1:x-1, y])
        true
    # Right
    elseif all(tree .> forest[x+1:end, y])
        true
    # Up
    elseif all(tree .> forest[x, 1:y-1])
        true
    # Down
    elseif all(tree .> forest[x, y+1:end])
        true
    else
        false
    end
end

function count_scenic_score(forest::Matrix{Int}, x::Int, y::Int)
    tree = forest[x, y]
    left = count_viewing_distance(tree, reverse(forest[1:x-1, y]))
    right = count_viewing_distance(tree, forest[x+1:end, y])
    up = count_viewing_distance(tree, reverse(forest[x, 1:y-1]))
    down = count_viewing_distance(tree, forest[x, y+1:end])
    left * right * up * down
end

lines = readlines("day8.data.txt")
forest = parse_matrix(lines)

(width, height) = size(forest)
visible_trees = width * 2 + height * 2 - 4
max_scenic_score = 0

for x in 2:width-1
    for y in 2:height-1
        # Part One
        # global visible_trees += is_tree_visible(forest, x, y)

        scenic_score = count_scenic_score(forest, x, y)
        if scenic_score > max_scenic_score
            global max_scenic_score = scenic_score
        end
    end
end

println(visible_trees)
println(max_scenic_score)
