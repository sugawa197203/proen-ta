#include <stdio.h>
#define SIZE 10

void Bsort(int data[], int size) {
    int i, j;
    for (i = 0; i < size; i++)
    {
        for (j = 0; j < size - i - 1; j++)
        {
            if (data[j] > data[j + 1])
            {
                int tmp = data[j];
                data[j] = data[j + 1];
                data[j + 1] = tmp;
            }
        }
    }
}

void printArray(int ar[], int size) {
	int i;
	for (i = 0; i < size; i++) {
		printf("%4d", ar[i]);
	}
	printf("\n");
}

int main(void) {
	int i;
	int data[SIZE];

	for (i = 0; i < SIZE; i++) {
		scanf("%d", &data[i]);
	}

	printf("before:");
	printArray(data, SIZE);

	Bsort(data, SIZE);

	printf(" after:");
	printArray(data, SIZE);

	return 0;
}