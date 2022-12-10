struct Pos
    x::Int
    y::Int
end

function is_touching(pos1::Pos, pos2::Pos)
    abs(pos1.x - pos2.x) <= 1 && abs(pos1.y - pos2.y) <= 1
end

function move_towards(from::Pos, towards::Pos)
    Δx = sign(towards.x - from.x)
    Δy = sign(towards.y - from.y)
    Pos(from.x + Δx, from.y + Δy)
end

function move(from::Pos, direction::Char, distance::Int)
    if direction == 'R'
        Pos(from.x + distance, from.y)
    elseif direction == 'L'
        Pos(from.x - distance, from.y)
    elseif direction == 'U'
        Pos(from.x, from.y + distance)
    elseif direction == 'D'
        Pos(from.x, from.y - distance)
    end
end

function move_if_not_touching(tail::Pos, head::Pos)
    if is_touching(tail, head)
        tail
    else
        move_towards(tail, head)
    end
end

head_pos = Pos(1, 1)
t1_pos = Pos(1, 1)
t2_pos = Pos(1, 1)
t3_pos = Pos(1, 1)
t4_pos = Pos(1, 1)
t5_pos = Pos(1, 1)
t6_pos = Pos(1, 1)
t7_pos = Pos(1, 1)
t8_pos = Pos(1, 1)
t9_pos = Pos(1, 1)

all_tail_positions = [t9_pos]

println("head starts at $head_pos")
println("tail starts at $t9_pos")

moves = readlines("day9.data.txt")
for mv in moves
    direction = mv[1]
    distance = parse(Int, mv[3:end])

    for _ in 1:distance
        # Move head one distance at a time
        global head_pos = move(head_pos, direction, 1)
        global t1_pos = move_if_not_touching(t1_pos, head_pos)
        global t2_pos = move_if_not_touching(t2_pos, t1_pos)
        global t3_pos = move_if_not_touching(t3_pos, t2_pos)
        global t4_pos = move_if_not_touching(t4_pos, t3_pos)
        global t5_pos = move_if_not_touching(t5_pos, t4_pos)
        global t6_pos = move_if_not_touching(t6_pos, t5_pos)
        global t7_pos = move_if_not_touching(t7_pos, t6_pos)
        global t8_pos = move_if_not_touching(t8_pos, t7_pos)
        global t9_pos = move_if_not_touching(t9_pos, t8_pos)
        push!(all_tail_positions, t9_pos)
   
    end
end

println("head ends at $head_pos")
println("tail ends at $t9_pos")

println(length(unique(all_tail_positions)))
