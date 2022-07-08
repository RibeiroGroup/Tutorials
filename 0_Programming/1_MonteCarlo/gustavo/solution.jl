using Distributions

function get_pi(N)

    # Number of points inside the circle
    hit = 0
    # Counter for the loop
    i = 0
    while i < N

        # Get x,y coordinates
        x = rand(Uniform(-1,1))
        y = rand(Uniform(-1,1))

        # Compute distance from origin
        dist = sqrt(x^2 + y^2)

        # Check if the point lies within the circle
        if dist <= 1.0

            # If yes, increase the hit counter
            hit += 1
        end

        # Increase loop counter. Without this you are stuck!!
        i += 1
    end

    # Compute pi
    return 4.0 * hit / N
end

println("Enter number of samples: ")
N = parse(Int, readline())
println("Estimated value of pi: ", get_pi(N))