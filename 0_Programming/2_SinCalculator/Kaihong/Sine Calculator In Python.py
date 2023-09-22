import math
def get_sin(x, precision):
   a = 0
   b = precision
   c = 0
   for i in range(100):
       c = a
       a = a + (-1)**(i) * x**(2*i+1)/math.factorial(2*i+1)
        if abs(a - c) <= 10**(-b-2):
            print(round(a,b), i+1)
            break
