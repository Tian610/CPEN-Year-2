#include <stdio.h>

int func(int *A, int i, int j, int k) {
    if ( i == j ) {
        A[0] = A[1] + k;
    } else {
        A[1] = A[0] - k;
    }

    if ( i < k ) {
        if ( i < j ) {
            A[2] = -j;
        }
    } else {
        A[3] = j + 1;
    }
    
    for (i = 0; i < 4; i++) {
        printf("Index %d: %d\n", i, A[i]);
    }
    
    return i + j - k;
}

int main() {
    int array[] = {0,0,0,0};
    printf("result: %d", func(array, 1, 1, 1));

    return 0;
}