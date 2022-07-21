import math
import random
print("Give me a number:" )
N = int(input())
IN = 0
i = 1
while i < N:
    x = random.uniform(-1.0, 1.0)
    y = random.uniform(-1.0, 1.0)
    r = math.sqrt(x ** 2 + y ** 2)
    if r < 1:
        IN += 1
    i += 1
pi = 4*IN/N
print("The approximate pi number is", pi)
