@enum Shape begin
    rock = 1
    paper = 2
    scissors = 3
end

@enum Outcome begin
    lose = 1
    draw = 2
    win = 3
end

function to_shape(shape::Char)
    if shape == 'A' || shape == 'X'
        rock::Shape
    elseif shape == 'B' || shape == 'Y'
        paper::Shape
    elseif shape == 'C' || shape == 'Z'
        scissors::Shape
    end
end

function to_outcome(token::Char)
    if token == 'X'
        lose::Outcome
    elseif token == 'Y'
        draw::Outcome
    elseif token == 'Z'
        win::Outcome
    end
end

function get_shape(other_shape::Shape, outcome::Outcome)
    if outcome == draw
        other_shape
    elseif outcome == win
        if other_shape == rock
            paper::Shape
        elseif other_shape == paper
            scissors::Shape
        elseif other_shape == scissors
            rock::Shape
        end
    elseif outcome == lose
        if other_shape == rock
            scissors::Shape
        elseif other_shape == paper
            rock::Shape
        elseif other_shape == scissors
            paper::Shape
        end
    end
end

function get_score(your_shape::Shape, other_shape::Shape)
    local score = Int(your_shape)

    if your_shape == other_shape
        score += 3
    elseif your_shape == rock && other_shape == scissors
        score += 6
    elseif your_shape == scissors && other_shape == paper
        score += 6
    elseif your_shape == paper && other_shape == rock
        score += 6
    end

    score
end

rounds = readlines("day2.data.txt")
total_score = 0

for i in eachindex(rounds)
    other_shape = to_shape(first(rounds[i]))
    # Part 1
    #your_shape = to_shape(last(rounds[i]))

    # Part 2
    outcome = to_outcome(last(rounds[i]))
    your_shape = get_shape(other_shape, outcome)

    global total_score += get_score(your_shape, other_shape)
end

println(total_score)
