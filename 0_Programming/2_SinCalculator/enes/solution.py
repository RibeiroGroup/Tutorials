import numpy as np

pi = np.pi
precision = 1e-5

def get_sin(x, precision):
    sin = x
    taylor = x
    n = 3
    count = 1
    while abs(taylor) > precision:
        # Taylor expansion terms for sin
        taylor = -taylor * (x ** 2) / (n * (n - 1))

        sin += taylor

        n += 2

        count += 1

        if count > 100:
            break

    return sin


# Error Calculations
Angles = np.array([0, pi / 4, pi / 2, 3 * pi / 4, pi, 5 * pi / 4, 3 * pi / 2, 7 * pi / 4, 2 * pi])

Values = np.array([0, np.sqrt(2) / 2, 1.0, np.sqrt(2) / 2, 0.0, -np.sqrt(2) / 2, -1.0, -np.sqrt(2) / 2, 0])

error = np.zeros(9)

for i in range(9):
    error[i] = get_sin(Angles[i], precision) - Values[i]
    print(error[i])

