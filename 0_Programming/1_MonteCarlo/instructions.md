# Estimating $\pi$ stochastically

Imagine you have a circle of radius inscribed in a square. The radius of the circle is equal half the length of the square. Now imagine we pick a random point on this figure, that is, we select two random numbers ($x$, $y$) and place a dot at the coordinate. What is the probability that the random point is found within the circle?

<p align="center">
<img src="assets/dotcircle.png" alt="drawing" width="400"/>
</p>

This probability is equal to the ratio between the area of the circle and the square: $P = \frac{A_\text{circle}}{A_\text{square}} = \frac{\pi}{4}$

This means we can estimate the value of $\pi$ by determining this probability. How would we do this? We can run a virtual experiment!

## General instruction

In our simulation, we have a circle of radius 1.0 (arbitrary units) inscribed in a square of length 2.0. It is convenient to center the circle at the origin, such that the square extends from -1.0 to 1.0 in both directions. 

Your code must request an input (integer) and use it as the number of samples (i.e. the number of times our virtual experiment is repeated). For each experiment you must

1. Generate two random numbers representing Cartesian coordinates.
2. Determine whether the point lies within the circle.

After repeating the process $N$ times, the probability $P$ is approximated as the ratio between points inside the circle and the total number of sampled points. Finally, print the obtained value of $pi$.

# Programming languages

For this project, I will write instructions for three programming languages:

1. C
> C is one of the most influential programming languages. It is old, but it remains important as it is considered a very efficient tool often yielding the best runtime performance. C is a [compiled language](https://www.geeksforgeeks.org/difference-between-compiled-and-interpreted-language/) and [statically typed](https://www.geeksforgeeks.org/what-is-a-typed-language/). 
2. Python
> Python is one the most popular programming languages across different fields of applications. In science, it became mainstream since it is very convenient for prototyping numerical methods and data analysis. Python is an [interpreted language](https://www.geeksforgeeks.org/difference-between-compiled-and-interpreted-language/) and [dynamically typed](https://www.geeksforgeeks.org/what-is-a-typed-language/).
3. Julia
> Julia is a fairly new programming language that has been increasingly popular in scientific computing. It uses a *just-in-time* compilation scheme that provides the dynamic experience without sacrificing too much performance. 

I encourage you to solve the problem using the three languages. Starting with C! Once you solve the problem on C, moving it to Python and Julia should be fairly easy. Below, I provide language specific instructions.


<p align="center">
<img src="assets/c.png" alt="drawing" height="100"/>
</p>

## C instructions

### Basic structure and compilation
Your C code must be wrapped within a main function. For example, let us look at a simple hello world code
```c
#include <stdio.h>

int main() {
    printf("Hello World\n");
    return 0;
}
```
Remember the following:
1. You need to declare variable types and the return type of your functions (e.g. `int` for `main`). 
2. Semicolons (`;`) must be added at the end of every command.
3. Curly braces must wrap functions, loops, and if statements.
4. Comments can be written after `//`.

Once you are done writing your code you will need to compile it. In the terminal, run
```
gcc -Wall mycode.c -o mycode -lm
```
where `mycode.c` is the name of the file containing your C code. The file must end with `.c`. If the compilation is successful, a compiled version of your code (`mycode`) is created. You can run it as
```
./mycode
```

### Random Numbers
Generating random numbers in C is rather cumbersome. You can use the following function to generate a random `Float64` (called `double` in C) between -1.0 and 1.0.
```c
#include <stdlib.h>

// Auxiliary function to compute random numbers from -1.0 to 1.0
double get_rand() {
    return 2.0 * rand() / (RAND_MAX) - 1.0;
}
```
> Do not forget the `<stdlib.h>` at the top of your code!!

You will also need to add the following lines within your `main` function. 
```c
// This is needed to generate random numbers
time_t t;
srand((unsigned) time(&t));
```
#### Keyboard input
You can have your code to receive an input from the terminal using the function `scanf`. For example, the code below uses `scanf` to test if the input number is odd or even. Try it out!
```c
#include <stdio.h>

int main() {
    int x;
    printf("Give me a number: \n");
    scanf("%d", &x);
    if (x % 2 == 0) {   
        printf("You gave me an EVEN number!\n");
    } else {
        printf("You gave me an ODD number!\n");
    }

    return 0;
}
```

#### Template
You can use the following skeleton to start writing your solution
```c
#include <stdio.h>
#include <stdlib.h>

// Auxiliary function to compute random numbers from -1.0 to 1.0
double get_rand() {
    return 2.0 * rand() / (RAND_MAX) - 1.0;
}

int main() {

    // This is needed to generate random numbers
    time_t t;
    srand((unsigned) time(&t));

    // Read input from user (I did not declare N!!!!!)
    printf("Enter number of samples: ");
    scanf("%d", &N);

    // Your code goes here
    // pi = ... 

    // Print out value
    printf("Estimated value of pi: %f\n", pi);

    return 0;
}
```

<p align="center">
<img src="assets/python.svg" alt="drawing" height="100"/>
</p>

## Python instructions

> I highly recommend you to go through C first, the other way around is way more painful. Plus, while Python makes a lot of things easier, it also takes some control away from you and masks the real complexity/beauty of what you are doing. Is this an statement saying we should always use C? No! But making the effort to understand the basics of it will help you to better appreciate the remarkable things involved in writing and running code in this magic piece of silicon! 

### Basic structure

Your python code does not need any specific structure, in fact, a hello world can be as simple as
```python
print("Hello World!")
```
You can run the code from your terminal using
```
python3 mycode.py
```
In this case, you do not need the `.py` extension. However, as a good practice, you should still use it.

Remember the following

1. Indentation is fundamental in Python. You code may not run if you mess up your spaces/tabs. 
2. `for` loops in Python are different than `for` loops in C. Perhaps you should try a `while` loop instead.
3. Comments can be written after `#`.

### Random numbers

Use the function `uniform` from the module `random` to generate random numbers over the desired interval. For example, if you want to generate a random number from -5.0 to 5.0 you can use:
```python
import random

random.uniform(-5.0, 5.0)
```

### Keyboard input

The function `input` can be used to read in a `string` passed from the terminal. You will need to convert that `string` into an `int`. Look at the following snippet for reference
```python
print("Give me a number:" )
x = int(input())
if x % 2 == 0:
    print("You gave me an EVEN number!")
else:
    print("You gave me an ODD number!")
```

<p align="center">
<img src="assets/julia.png" alt="drawing" height="100"/>
</p>

## Julia instructions

Julia is not installed by default in most systems. Thus, you may need to [download and install it](https://julialang.org/downloads/).

> If you are feeling adventurous you can also [clone and compile](https://github.com/JuliaLang/julia) julia yourself! 

### Basic structure and compilation

Like in Python, Julia does not have a mandatory complicate structure. The Hello World looks just like Python
```julia
println("Hello World")
```
From the terminal, you can compile and run the code as
```
julia mycode.jl
```
Once again, the extension is not necessary, but recommended. Notice the difference here. This procedure looks a lot like what we did for Python, but I have claimed the julia is compiled. For C, we needed to compile then run, here both steps are coupled. This is because julia compiles its functions *just-in-time*, that is, just when they are called. 

Remember the following
1. `if`, `while`, and `for` statements need to have a corresponding `end`.
2. In julia, it is recommended (though not necessary) that your main code is encapsulated in a function. This has performance implications.
3. Strings must be written using double quotes `" "`.
4. Comments can be written after `#`.

### Random numbers

To get the uniform distribution we are looking for, the package `Distributions` is needed. You will likely need to install that yourself. Do not panic! Installing packages in julia is rather easy. We can do that using the julia `REPL` (julia terminal). To start it up just type `julia` in your shell.
```
shell> julia 
```
then type `]` to access the package manager, and finally use the `add` command to install the desired library
```
julia> ]
(@1.7) pkg> add Distributions
```

Finally, having it installed you can generate random numbers as
```julia
using Distributions

rand(Uniform(-1,1))
```

### Keyboard input

The input function in julia is `readline`. Similar to Python, the value read is a `String` and need to be converted to a `Int`. This is done using the `parse` function. Let us look again at our odd/even routine
```julia
println("Give me a number:" )
x = parse(Int, readline())
if x % 2 == 0
    println("You gave me an EVEN number!")
else
    println("You gave me an ODD number!")
end
```

### Template
You can use the following skeleton to start writing your solution
```julia
using Distributions

function get_pi(N)
    # Your code goes here
end

println("Enter number of samples: ")
N = parse(Int, readline())
println("Estimated value of pi: ", get_pi(N))
```













