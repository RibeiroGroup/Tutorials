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
