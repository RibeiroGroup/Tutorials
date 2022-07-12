# Constructing a sine calculator

In this project you will construct a function to compute the sine of a given angle. To do that, we will use the Taylor expansion of $\sin(x)$ around $x = 0$

$\sin(x) = x - \frac{x^3}{3!} + \frac{x^5}{5!} - \frac{x^7}{7!} + \frac{x^9}{9!} + ... $

Note that the $n$-th element of this series is $(-1)^n \frac{x^n}{n!}$ where $n$ is an odd integer.

Your function must take in two arguments, an angle value and a precision parameter. Let us take a look at the syntax for defining function

1. C

```c
double get_sin(double x, double precision) {
    // Your code goes here
}
```
> Note that in C, the syntax start with the return type of the function
2. Python
```python
def get_sin(x, precision):
    # Your code goes here
```
3. Julia
```julia
function get_sin(x, precision)
    # Your code goes here
end
```
> In both Python and Julia we can define arguments with a predefined value `get_sin(x, precision = 1e-5)`. If this function is called without the precision argument, the standard value (`1e-5`) is used.

Inside your function, you must construct a loop structure that compute elements of the Taylor series successively until the computed term is smaller than the `precision` parameter. When that happens you must quit the loop.

Another important parameter you must include is the maximum number of iterations and a corresponding iteration counter. This parameters must be used to ensure that the loop will break after a number of iterations. This is necessary because for certain values (very large values of $x$) our function converges very slowly, and we do not want to be stuck in it forever. 

You can use `1e-5` and `100` as your standard `precision` and maximum number of iterations, respectively. 

## Accuracy test

To verify if our function is working as expected, we should test it against known values of the sin function. Compute the output of your function on the following angles and print out the error with respect to the tabulated result.

| $x$ | $\sin(x)$ |
|---|:---:|
| $0$ | $0$ | 
| $\frac{\pi}{4}$ | $\frac{\sqrt{2}}{2}$ | 
| $\frac{\pi}{2}$ | $1$ | 
| $\frac{3\pi}{4}$ | $\frac{\sqrt{2}}{2}$ | 
| $\pi$ | $0$ | 
| $\frac{5\pi}{4}$ | $-\frac{\sqrt{2}}{2}$ | 
| $\frac{3\pi}{2}$ | $-1$ | 
| $\frac{7\pi}{4}$ | $-\frac{\sqrt{2}}{2}$ | 
| $2\pi$ | $0$ | 

Here's the expected output (from my Python solution)
```
Angle:  0.000000  Error: 0.000000
Angle:  0.785398  Error: 0.000000
Angle:  1.570796  Error: -0.000000
Angle:  2.356194  Error: -0.000000
Angle:  3.141593  Error: 0.000000
Angle:  3.926991  Error: -0.000000
Angle:  4.712389  Error: 0.000000
Angle:  5.497787  Error: -0.000000
Angle:  6.283185  Error: 0.000000
```

## Performance test

The final step is to verify the performance of our code by measuring the runtime for a large number of function calls. Write a loop that execute you code a million times and print the elapsed time.

1. C
To measure runtime in C you will need to include a few lines of code. You can use the following template
```c
#include <time.h>

struct timespec begin, end;
clock_gettime(CLOCK_REALTIME, &begin);

// Your code to be timed goes here

clock_gettime(CLOCK_REALTIME, &end);
printf ("Total time for a million runs: %f seconds\n",
        (end.tv_nsec - begin.tv_nsec) / 1000000000.0 +
        (end.tv_sec  - begin.tv_sec));
```
2. Python

In Python the function `time` from the library `time` can be used to get the time before and after the code is ran. Subtracting the two values yields the elapsed time. 
```python
from time import time

t = time()

# Your code to be timed goes here

t = time() - t
print("Time for a million runs: {:f} seconds.".format(t))
```

3. Julia

Julia offers a simple macro `@elapsed` that can be wrapped around a portion of code.
```julia
t = @elapsed begin

# Your code to be timed goes here

end
println("Time for a million runs: $t seconds.")
```

## Comparing programming languages

If you write a version of your function in each programming language described here, you will have the opportunity to compare the performance of the three different codes!

Ask yourself the following questions:

1. Which language yields the best performance?
2. Which language was easier to use?
3. For what type of applications would Python be better than C?
4. For what type of applications would C be better than Python?
5. How does Julia compare to C and Python?