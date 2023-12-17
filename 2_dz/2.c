#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <stdint.h>


int Re_in_1;
int Im_in_1;
int Re_in_2;
int Im_in_2;
int Re_out;
int Im_out;
int data_valid_in;
int data_valid_out;

int Multiplier(
    int input1,
    int input2
) {
    int result;
    result = input1 * input2;
    return result;
}


void Complex_Multiplier () {
    int a = 0;
    int b = 0;
    int c = 0;
    int d = 0;
    int k1 = 0;
    int k2 = 0;
    int k3 = 0;
    int x = 0;
    int y = 0;

    int state = 0;
    int flag = 0;
    int cnt = 0;

    a = Re_in_1;
    b = Im_in_1;
    c = Re_in_2;
    d = Im_in_2;
    int i = 1;
    while (i <= 3) {
        switch (i) {
            case 1: {
                k1 = Multiplier(c, (b-a));
                break;
            }
            case 2: {
                k2 = Multiplier(b, (c-d));
                break;
            }
            case 3: {
                k3 = Multiplier(a, (c+d));
                x = k2-k1;
                y = k1+k3;
                break;
            }
            default: {
                data_valid_out = 0;
                break;
            }
        }
        i++;
    }
    Re_out = x; 
    Im_out = y;
    data_valid_out = 1;
    printf("Re_out: %d, Im_out: %d, data_valid_out: %d\n", Re_out, Im_out, data_valid_out);
    data_valid_out = 0;
}

int main() {
    int counter = 0;

    while(1)
    {           
        if (counter > 3)
            exit(0);

        if (counter == 0){
            Re_in_1 = 3;
            Im_in_1 = 1;
            Re_in_2 = 3; 
            Im_in_2 = 1;
        }
        if (counter == 1){
            Re_in_1 = 2;
            Im_in_1 = 1;
            Re_in_2 = 2; 
            Im_in_2 = 1;
        }
        if (counter == 2){
            Re_in_1 = 1;
            Im_in_1 = 1;
            Re_in_2 = 1; 
            Im_in_2 = 1; 
        }
        if (counter == 3){
            Re_in_1 = 1;
            Im_in_1 = 2;
            Re_in_2 = 1; 
            Im_in_2 = 2; 
        }

        
        Complex_Multiplier();
    
        counter++;
    }

    return 0;
}
