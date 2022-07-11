from math import pi, sqrt
from time import time

### Sin function
def get_sin(θ, precision = 1e-5):

    # Set up an iteration counter and max number of iterations
    max_iter = 100
    iter = 1

    # Save θ² value since it is used in every iteration
    θsqr = θ**2 

    # Create a variable to hold nth element of the Taylor series. 
    # First element is simply θ
    elem = θ

    # Create a variable for the output. Add the first term to it
    out = 0.0
    out += elem

    # Set up n value in the Taylor series
    n = 3
    while abs(elem) > precision:

        # Check if we exceeded the number of iterations
        if iter > max_iter:
            print("Does not converge")
            break

        # Update series element
        elem = -elem * θsqr / (n * (n-1))

        # Update output with the new term
        out += elem

        # Update n value (Note that we only run through odd values)
        n += 2

        # Update iteration counter
        iter += 1
    
    return out

### Accuracy check
angles = [0, pi/4,  pi/2, 3*pi/4, pi, 5*pi/4, 3*pi/2, 7*pi/4, 2*pi]
values = [0, sqrt(2)/2, 1.0, sqrt(2)/2, 0.0, -sqrt(2)/2, -1.0, -sqrt(2)/2, 0]

for (a,v) in zip(angles, values):
    err = get_sin(a) - v
    print("Angle:  {:f}  Error: {:f}".format(a, err))

## Performance Check
t = time()
for i in range(1000000):
    for a in angles:
        get_sin(a)
t = time() - t
print("Time for a million runs: {:f} seconds.".format(t))