#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double get_sin(double x, double precision) {

    // Set up an iteration counter and max number of iterations
    int MAX_ITER = 100;
    int iter = 1;

    // Save x² value since it is used in every iteration
    double xsqr = x*x;

    // Create a variable to hold nth element of the Taylor series. 
    // First element is simply θ
    double elem = x;

    // Create a variable for the output. Add the first term to it
    double out = 0.0;
    out = out + elem;

    // Set up n value in the Taylor series
    int n = 3;

    while (fabs(elem) > precision) {

        // Check if we exceeded the number of iterations
        if (iter > MAX_ITER) {
            printf("Does not converge\n");
            break;
        }

        // Update series element
        elem = -elem * xsqr / (double) (n * (n-1));

        // Update output with the new term
        out = out + elem;

        // Update n value (Note that we only run through odd values)
        n++;
        n++;

        // Update iteration counter
        iter++;
    }

    return out;
}