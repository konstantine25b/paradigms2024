#include <stdio.h>  // For printf and scanf
#include <stdbool.h>  // For using 'true' keyword in C

// Function definition
int find(int x, int n) {
    int result = x + n;  // Just an example, you should define your logic here
    return result;
}

int main() {
    int x; 
    int n;

    // Infinite loop to keep reading and processing inputs
    while (true) {
        printf("Enter x: ");
        scanf("%d", &x);

        printf("Enter n: ");
        scanf("%d", &n);

        // Call the find function and print the result
        printf("Result: %d\n", find(x, n));
    }

    return 0;
}
