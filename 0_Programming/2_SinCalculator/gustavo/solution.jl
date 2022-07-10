### Sin function
function get_sin(x, precision = 10^-5)

    # Set up an interation counter and max number of iterations
    max_iter = 100
    iter = 1

    # Save x² value since it is used in every iteration
    xsqr = x^2 

    # Create a variable for output. Initial value is simply x
    out = x


    # Set up variables to hold nth element of the Taylor series. 
    elem = x

    # Set up n value in the Taylor series
    n = 3
    while abs(elem) > precision

        # Check if we exceeded the number of iterations
        if iter > max_iter
            println("Does not converge")
            break
        end

        # Update series element
        elem = -elem * xsqr / (n * (n-1))

        # Update output with the element
        out += elem

        # Update n value (Note that we only run through odd values)
        n += 2

        # Update iteration counter
        iter += 1
    end
    
    return out
end

### Accuracy check
angles = [0, pi/4,  pi/2, 3*pi/4, pi, 5*pi/4, 3*pi/2, 7*pi/4, 2*pi]
values = [0, sqrt(2)/2, 1.0, sqrt(2)/2, 0.0, -sqrt(2)/2, -1.0, -sqrt(2)/2, 0]

for (a,v) in zip(angles, values)
    err = get_sin(a) - v
    println("Angle:  $a  Error: $(err)")
end

### Performance Check
t = @elapsed begin
    for i = 1:1000000
        for a in angles
            get_sin(a)
        end
    end
end

println("Time for 9000000 runs: $t seconds.")
