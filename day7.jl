struct File
    name::String
    size::Int
end

mutable struct Directory
    path::String
    name::String
    files::Vector{File}
    dirs::Vector{Directory}
    parent::Union{Directory, Missing}
end

filesystem = Directory("", "", [], [], missing)
current_dir = filesystem

lines = readlines("day7.data.txt")
for line in lines
    if line == "\$ cd /"
        global current_dir = filesystem
    elseif line == "\$ cd .."
        global current_dir = current_dir.parent
    elseif first(line, 5) == "\$ cd "
        d = line[6:end]
        current_dir = first(filter(dir -> d == dir.name, current_dir.dirs))
    elseif line == "\$ ls"
        continue
    elseif first(line, 4) == "dir "
        # Directory listing
        d = line[5:end]
        push!(current_dir.dirs, Directory("$(current_dir.path)/$d", d, [], [], current_dir))
    else
        # File listing, with size
        f = match(r"(\d+) (.+)", line)
        push!(current_dir.files, File(f.captures[2], parse(Int, f.captures[1])))
    end
end

dir_total_sizes = Dict{String, Int}()

function sumfilesize(dir::Directory)
    filesize = sum(map(f -> f.size, dir.files))
    for subdir in dir.dirs
        filesize += sumfilesize(subdir)
    end

    # Part One
    # if filesize <= 100000
    #     dir_total_sizes[dir.path] = filesize
    # end

    # Part Two
    dir_total_sizes[dir.path] = filesize
    # ...

    filesize
end

function traverse(dir::Directory, depth = 1)
    for subdir in dir.dirs
        traverse(subdir, depth + 1)
    end
end

# Part One
# traverse(filesystem)

# sizesum = 0
# for d in keys(dir_total_sizes)
#     global sizesum += dir_total_sizes[d]
# end

# println(dir_total_sizes)
# println(sizesum)

available = 70000000 - sumfilesize(filesystem)
to_delete = 30000000 - available

min_size::Union{Int, Missing} = missing
for (path, size) in dir_total_sizes
    if size >= to_delete && (ismissing(min_size) || size < min_size)
        global min_size = size
    end
end

println(min_size)
