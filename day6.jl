stream = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

marker_length = 4

for i in 1:length(stream)
    if length(unique(stream[i:i+marker_length-1])) == marker_length
        println(i+marker_length-1)
        break
    end
end
