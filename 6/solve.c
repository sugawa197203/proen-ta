#include <stdio.h>
#include <string.h>
#define SIZE 30
#define LENGTH 30 

void strSort(char data[SIZE][LENGTH+1], int size){
    int i, j;
    char tmp[LENGTH+1];
    
    for (i = 0; i < size; i++){
        for (j = 0; j < size - i - 1; j++){
            if (strcmp(data[j], data[j + 1]) > 0){
                strcpy(tmp, data[j]);
                strcpy(data[j], data[j + 1]);
                strcpy(data[j + 1], tmp);
            }
        }
    }
    
}

void printStringArray(char data[SIZE][LENGTH+1], int size){
    int i;
    for(i=0;i<size;i++){
        printf("\n%s", data[i]);
    }    
}

int main(void){
    int i,size = SIZE;
    char data[SIZE][LENGTH+1];
    char tmp[LENGTH+1];
    for(i=0;i<SIZE;i++){
        if(scanf("%s",data[i]) == EOF){
            size = i;
            break;
        }
    }
    printf("before:");
    printStringArray(data,size);
    puts("\n");

    strSort(data, size);

    printf("after:");
    printStringArray(data, size);
    return 0;
}
