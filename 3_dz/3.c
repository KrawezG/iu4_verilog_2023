#include <stdio.h>

#define N 10 // Длина входного сигнала

void variant1(double *x, double *y, double a, double b, int n) {
    for (int i = 0; i < n; i++) {
        if (i<1) {
            y[i] = x[i]*b;
        } else {
            y[i] = y[i-1]*a + x[i]*b;
        }
    }
}

void variant2(double *x, double *y, double a, double b, int n) {
    for (int i = 0; i < n; i++) {
        if (i<1) {
            y[i] = x[i]*b;
        } else if(i<2) {
            y[i] = y[i-1]*a + x[i]*b;
        }else {
            y[i] = y[i-2]*a*a + x[i-1]*a*b  + x[i]*b;
        }
    }
}

void variant3(double *x, double *y, double a, double b, int n) {
    for (int i = 0; i < n; i++) {
        if (i<1) {
            y[i] = x[i]*b;
        } else if(i<2) {
            y[i] = y[i-1]*a + x[i]*b;
        }else if(i<3) {
            y[i] = y[i-2]*a*a + x[i-1]*a*b  + x[i]*b;
        }else {
            y[i] = y[i-3]*a*a*a + x[i-2]*a*a*b + x[i-1]*a*b  + x[i]*b;
        }
    }
}

int main() {
    double x[N] = {1, 2, 1, 2, 1, 2, 1, 2, 1, 2};
    double y1[N] = {0};
    double y2[N] = {0};
    double y3[N] = {0};
    
    double a = 1;
    double b = -1;
    
    variant1(x, y1, a, b, N);
    variant2(x, y2, a, b, N);
    variant3(x, y3, a, b, N);
    
    printf("Variant 1:\n");
    for (int i = 0; i < N; i++) {
        printf("%f ", y1[i]);
    }
    printf("\n\nVariant 2:\n");
    for (int i = 0; i < N; i++) {
        printf("%f ", y2[i]);
    }
    printf("\n\nVariant 3:\n");
    for (int i = 0; i < N; i++) {
        printf("%f ", y3[i]);
    }
    printf("\n");

    return 0;
}
