using Makie
using WGLMakie

function read_data(fname)

    lines = readlines(fname)
    N = length(lines)
    xvals = zeros(N)
    yvals = zeros(N)

    for l in 1:N
        xstr, ystr = split(lines[l])
        xvals[l] = parse(Float64, xstr)
        yvals[l] = parse(Float64, ystr)
    end

    scatter(xvals, yvals)
end

read_data("data.txt")