import numpy as np

# Input parameters
print("Enter number of samples: ")
N = int(input())
n = 0

# Generate random points in a square
Xrand = np.random.default_rng().uniform(-1, 1, (N,))
Yrand = np.random.default_rng().uniform(-1, 1, (N,))

for i in range(N):
    x = Xrand[i]
    y = Yrand[i]
    # Check if the points are inside the circle
    if x ** 2 + y ** 2 <= 1:
        n = n + 1

pi = 4 * n / N
print("Value of Pi: ", pi)
