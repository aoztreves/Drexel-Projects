
#include <stdio.h>
#include <ctype.h>
#include <string>
using namespace std;

#define Node 6
#define Infi 999

//can handle values up to 3 digits long
void printG(char name, int P[Node][Node]){
        int i,j,number;
        string infi = "∞";
        printf("\n%c[i][j]:\n", name);
        printf("     1   2   3   4   5   6\n");
        printf("   .---.---.---.---.---.---.\n");
        for(i=0; i< Node; i++){
                printf(" %d |",i+1);
                for(j=0; j <Node; j++){
                        number = P[i][j];
                        if (name == 'C'){
                                infi = " ";
                        }
                        if (number == Infi){
                                printf(" %s ", infi.c_str());
                        }
                        else if (number < 10){
                                printf(" %d ", number);
                        }
                        else if (number < 100 ){
                                printf(" %d", number);
                        }
                        else{
                                printf("%d", number);
                        }
                        if (j != Node - 1){
                                printf(" ");
                        }
                }
                printf("|\n   ");
                if (i == Node-1){
                        printf("'---'---'---'---'---'---'\n");
                }
                else{
                        printf("|---+---+---+---+---+---|\n");
                }
        }
}

int main() {
        int i,j,k;
        int C[Node][Node];
        int A[Node][Node];

        for(i=0; i<Node; i++){
                for(j=0; j<Node; j++){
                        C[i][j]=Infi;
                }
        }

        //initialize graph of problem 6 of review 2
        C[0][1]=4;
        C[0][2]=1;
        C[0][3]=5;
        C[0][4]=8;
        C[0][5]=10;
        C[2][1]=2;
        C[3][4]=2;
        C[4][5]=1;

        //Floyd's algorithm
        for(i=0; i<Node; i++){
                for(j=0; j<Node; j++) {
                        A[i][j] = C[i][j];
                }
        }

        for(i=0; i<Node; i++){
                A[i][i] = 0;
        }

        for(k=0; k<Node; k++){
                for(i=0; i<Node; i++){
                        for(j=0; j<Node; j++){
                                if( (A[i][k] + A[k][j]) < A[i][j]){
                                        A[i][j] = A[i][k] + A[k][j];
                                }
                        }
                }
        }

        printG('C',C);
        printG('A',A);
        printf("\n");
}
