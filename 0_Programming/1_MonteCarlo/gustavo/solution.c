#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double get_rand() {
    int x;
    x = rand();
    return (float) 2*x / (RAND_MAX) - 1.0;
}

int main() {

    // This is needed to generate random numbers
    time_t t;
    srand((unsigned) time(&t));

    // Declare variables
    // Number of samples
    int N;

    // x and y coordinate
    double x, y;

    // Distance to the center
    double dist;

    // Pi value
    double pi;
    
    // Number of points inside the circle
    int hit;

    printf("Enter number of samples: ");
    scanf("%d", &N);

    for (int i = 1; i <= N; i++) {
        x = get_rand();
        y = get_rand();
        dist = sqrt(x*x + y*y);

        if (dist <= 1.0) {
            hit++;
        }
    }

    pi = 4.0 * hit / N;

    printf("Estimated value of pi: %f", pi);

    return 0;
}