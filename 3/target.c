#include<stdio.h>

int counter = 0;

int fibonacci(int n) {
    counter++;
    if (n <= 0) return 0;
    if (n == 1) return 1;
    if (n == 2) return 1;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    int n;
    scanf("%d", &n);
    int result = fibonacci(n);
    printf("%d %d\n", result, counter);
    return 0;
}