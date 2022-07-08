import random
import math

# Read number in
print("Enter number of samples:")
N = int(input())

# Counter for the loop
i = 1

# Number of points inside the circle
hit = 0
while i < N:

    # Get x,y coordinates
    x = random.uniform(-1, 1)
    y = random.uniform(-1, 1)

    # Compute distance from origin
    dist = math.sqrt(x*x + y*y)

    # Check if the point lies within the circle
    if dist <= 1.0:

        # If yes, increase the hit counter
        hit += 1

    # Increase loop counter. Without this you are stuck!!
    i += 1

# Compute pi
pi = 4.0 * hit / N

# Print out value
print("Estimated value of pi: ", pi)

