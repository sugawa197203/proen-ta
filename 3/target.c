#include <stdio.h>
int count;
int Func(int n){
    count++;
    if(n<=2){
        return 1;
    }else{
        return Func(n-1)+Func(n-2);
    }
}

int main(void){
    int n,result;
    scanf("%d",&n);
    result=Func(n);
    printf("%d %d\n",result,count);
    return 0;
}