#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <unistd.h>

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


int main() {

    // Accuracy check
    double angles[9] = {0, M_PI/4,  M_PI/2, 3*M_PI/4, M_PI, 5*M_PI/4, 3*M_PI/2, 7*M_PI/4, 2*M_PI};
    double values[9] = {0, sqrt(2.0)/2.0, 1.0, sqrt(2.0)/2.0, 0.0, -sqrt(2.0)/2.0, -1.0, -sqrt(2.0)/2.0, 0};

    for (int i = 0; i < 9; i++) {
        double err = get_sin(angles[i], 1e-5) - values[i];
        printf("Angle:  %f  Error: %f\n", angles[i], err);
    }

    // Performance check
    struct timespec begin, end;
    clock_gettime(CLOCK_REALTIME, &begin);
    for (int i; i < 1000000; i++) {
        for (int j; j < 9; j++) {
            get_sin(angles[i], 1e-5);
            sleep(1);
        }
    }
    clock_gettime(CLOCK_REALTIME, &end);
    double elapsed = (double) (end.tv_nsec - begin.tv_nsec) * 1e-9;
    //double t = (double)(toc -tic) / CLOCKS_PER_SEC;
    //// I DONT THINK THIS WORKS
    printf("Time for a million runs: %f seconds.\n", elapsed);

    return 0;
}