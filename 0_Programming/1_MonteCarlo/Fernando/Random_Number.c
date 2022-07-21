#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Function to create the random numbers
double get_rand() {
	return 2.0 * rand() / (RAND_MAX) - 1.0;
}

int main() {

	time_t t;
	srand((unsigned) time(&t));

	int N, i;
	printf("Enter number of samples: ");
	scanf("%d", &N);
	// code to calculate pi
	int IN = 0;
       	int OUT  = 0;
	for (i=0;i<=N;i++)
	{
		double x = get_rand();
		double y = get_rand();
		double r = sqrt(x*x + y*y);
		if ( r < 1 ) {
			IN++;
		}
	}	
	printf("Number =  %d ", N);
	double  pi;
       	pi = 4*(double)IN / (double)N;
	// Print out value
	printf("Estimated value of pi: %f\n", pi);

	return 0;
}
