#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Auxiliary function to compute random numbers from -1.0 to 1.0
double get_rand() {
    return 2.0 * rand() / (RAND_MAX) - 1.0;
}

// This function takes in a number of samples and returns the estimate value of pi
double get_pi(int N) {

    // Number of points inside the circle
    int hit;

    // x and y coordinate
    double x, y;

    // Distance to the center
    double dist;

    for (int i = 1; i <= N; i++) {

        // Get x,y coordinates
        x = get_rand();
        y = get_rand();

        // Compute distance from origin
        dist = sqrt(x*x + y*y);

        // Check if the point lies within the circle
        if (dist <= 1.0) {

            // If yes, increase the hit counter
            hit++;
        }
    }

    // Return pi
    return 4.0 * hit / N;
}


int main() {

    // This is needed to generate random numbers
    time_t t;
    srand((unsigned) time(&t));

    // Declare variables
    // Number of samples
    int N;
    // Pi value
    double pi;

    // Read input from user
    printf("Enter number of samples: ");
    scanf("%d", &N);

    // Call function to compute pi
    pi = get_pi(N);

    // Print out value
    printf("Estimated value of pi: %f\n", pi);

    return 0;
}