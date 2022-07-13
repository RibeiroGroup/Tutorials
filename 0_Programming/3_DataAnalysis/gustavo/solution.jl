using Makie
using WGLMakie

function read_data(fname)

    # Read the file as an array of Strings (each line is one element in the array)
    lines = readlines(fname)

    # Get number of lines (equals the number of data points)
    N = length(lines)
    xvals = zeros(N)
    yvals = zeros(N)

    # Loop through lines
    for l in 1:N

        # Split line into two blocks (`split` uses whitespace as the breaking point)
        xstr, ystr = split(lines[l])

        # Parse String into Float64 values
        xvals[l] = parse(Float64, xstr)
        yvals[l] = parse(Float64, ystr)
    end

    # Return arrays
    return xvals, yvals
end

function linear_regression(xvals, yvals)

    # Compute coefficients A,B of the line
    # y = Ax + B
    n = length(xvals)
    Σy  = sum(yvals)
    Σx  = sum(xvals)
    Σx2 = sum(xvals .^ 2)
    Σxy = sum(xvals .* yvals)

    A = (n * Σxy - Σx * Σy) / (n * Σx2 - Σx ^2)

    B = (Σy * Σx2 - Σx * Σxy) / (n * Σx2 - Σx ^2)

    return A, B
end

function plot_data(xvals, yvals, A, B)

    # Compute values for the straight line model
    yline = [A*x + B for x in xvals]

    # Create Figure
    fig = Figure()

    # Create axis within the figure
    ax = Axis(fig[1,1], xlabel = "X values", ylabel = "Y values", title = "Linear Regression")

    # Plot to axis
    scatter!(ax, xvals, yvals, label="Raw")
    lines!(xvals, yline, color=:red, linewidth = 3, label="Model")
    axislegend(position = :rb)

    # Show figure
    display(fig)
end

# Parse data
x,y = read_data("../data.txt")
# Process data
A, B = linear_regression(x, y)
# Plot data
plot_data(x, y, A, B)