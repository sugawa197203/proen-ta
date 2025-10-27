#include <stdio.h>

void SumAndDifference(int *a, int *b){
    
    int sum = *a + *b;
    int diff = *a - *b;

    *a = sum;
    *b = diff;
}

int main(void){
    int a, b;

    scanf("%d %d", &a, &b);

    SumAndDifference(&a, &b);

    printf("%d %d\n", a, b);
    return 0;
}
