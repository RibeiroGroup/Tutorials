# Data Parsing and Processing

In this project we will write routines to handle data. We organize this routine in three steps:

1. Parse (*read*)
2. Process (*do something with it*)
3. Plot (*get graphs*)

For this type of application, dynamical programming languages such as Python and Julia should be preferred over C. This is particularly true for the third step (plotting) since we are not writing code to plot figures from scratch, which is not feasible. Thus, to generate high quality plots suitable for publication we will use well established and maintained libraries. 

## Parsing

Data parsing is the process of acquiring data in one format (for example a `.txt` file you have some numbers saved) and transforming into a format we can work with (arrays to be used in our code). There are many ways to do that, and the exact code we will need depends on how the input data is formatted. Here we will look at a very simple format, a file with two columns of numbers:
```
10 2.7
50 5.0
30 0.3
```
The general procedure is:
1. Read each line as a string
2. Split line into columns
3. Convert column strings to numbers


<p align="left">
<img src="../1_MonteCarlo/assets/python.svg" alt="drawing" height="70"/>
</p>

In Python you must first open the file, read lines, then close the file. A convenient way to do it is using the `with` ... `as` statement combined with the `readlines` method. See the following example
```python
with open("myfile", "r") as f:

    lines = f.readlines()
```
here the file `"myfile"` is open and then read into the variable `lines`, which now contains an array of strings. Once your code quits this block, the file will be closed safely and you can use `lines` to continue parsing your data.

Once you have a string corresponding to a line of your data file, the problem is reduced to extracting the numerical values out of that strings. Some useful [string methods](https://www.w3schools.com/python/python_ref_string.asp) you can use are:

- `split()` which slices the string whenever it finds an whitespace
```python
>>> "a b      c".split()
['a', 'b', 'c']
```
- `strip()` removes a newline (`"\n"`) from the string
```python
>>> "some text\n".strip()
'some text'
```
- `replace(a, b)` replaces the first value with the second
```python
>>> "I like C".replace("C", "Python")
'I like Python'
```
Once your string contains only a numerical value (e.g. `"100"` or `"0.345"`) you can convert it to an integer or float:
```python
>>> int("100")
100
>>> float("0.345")
0.345
```

<p align="left">
<img src="../1_MonteCarlo/assets/julia.png" alt="drawing" height="70"/>
</p>

In Julia the function `readlines` can be used to quickly read all your data into an array of strings
```julia
julia> lines = readlines("myfile")
julia> lines[1]
"10 2.7"
```
then, similar to Python, you must handle this string until it holds a single numerical value. Useful string functions for this type of task are

- `split(x)` slices the string `x` whenever it finds a whitespace
```julia
julia> split("a b c")
3-element Vector{SubString{String}}:
 "x"
 "x"
 "x"
```
- `strip(x)` removes a newline character (`\n`) from the string.
```julia
julia> strip("some text\n")
"some text"
```
- `replace(a, b)` return string `a` with modification `b`
```julia
julia> replace("I like Python", "Python" => "julia")
"I like julia"
```
Once your string only holds numerical values, the `parse` function is used to convert it to a `Float64` or `Int`
```julia
julia> parse(Int, "100")
100
julia> parse(Float64, "0.345")
0.345
```

**SUMMARY**
> The goal of this step is to create a function that takes in the name of a file and returns two arrays of numbers corresponding to each columns found in that file. You will use this function to parse the `data.txt` file found in this directory.

## Processing

Having our data parse, we can star analyzing/modifying it as needed. Here we will perform a linear regression using the first column as abscissa (x values) and the second column as ordinate (y values). In a linear regression we try to determine the coefficients $A$ and $B$ of the straight line $y = Ax + B$ that minimizes the error with respect to our data. The values of $A$ and $B$ are determined analytically as

$\Huge A = \frac{n(\sum_i x_i y_i) - (\sum_i x_i)(\sum_i x_i)}{n(\sum_i x_i^2) - (\sum_i x_i)^2} $

$\Huge B = \frac{(\sum_i y_i)(\sum_i x_i^2) - (\sum_i x_i)(\sum_i x_iy_i)}{n(\sum_i x_i^2) - (\sum_i x_i)^2} $

*Tips*
1. In Python, this type of work with arrays is best performed using the `numpy` package.
2. In Julia, you can broadcast operators on entire arrays by adding `.` in front of it (e.g. you can multiply an array `u` by 2 using `2 .* u`).

## Plotting

For the final step, you must plot your results in a single image. It must contain

- Scatter plot of the raw data
- Line plot of the linear model

For practice, you should also try including the following

- Title
- Axis labels
- Legend

*Libraries*

In Python you can use [matplotlib](https://matplotlib.org/stable/gallery/index).

In Julia you can use [Makie](https://makie.juliaplots.org/stable/).






