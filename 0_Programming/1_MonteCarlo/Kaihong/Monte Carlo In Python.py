import math
import random
k = 10000
r = 1
count = 0
for i in range(k):
    x = random.random()
    y = random.random()
    if x**2 + y**2 < r**2:
        count = count + 1
pi = count/k * 4
print(pi)

