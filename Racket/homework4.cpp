//Diego Fernando Montaño Pérez A01282875
// Date: 24/08/2020
// Homework 4 Programming Languages
#include <iostream>
using namespace std;

int Sum(int arr[], int i) {

    if( i < 1 ){ return 0;}
    return Sum(arr,i-1) + arr[i-1];
}

int FibonacciNumbers(int n){
    if(n == 0){
        return 0;
    }
    if(n == 1){
        return 1;
    }
    return FibonacciNumbers(n-1)+FibonacciNumbers(n-2);
}

void DecimalToBinary(int i){
    if(i == 0){
        cout << "Result: ";
        return; //ends recursion 
    }
    DecimalToBinary(i/2);
    cout << i%2;
}

int main(){

    //Sum
    int arr[] = {1,2,3,4,5,6,7,8,9};
    int sizeArr = *(&arr + 1) - arr;
    cout << "Sum of numbers = " << Sum(arr,sizeArr) << endl;

    //Fibonacci Numbers
    int n;
    cout << "How many Fibonacci numbers you want to see: " ;
    cin >> n;
    for(int i = 0; i < n ; i++){
        cout << FibonacciNumbers(i) << " ";
    }

    cout << endl;

    //Converting to Binary
    int decimal;
    cout << "Input decimal number to make it binary: " ;
    cin >> decimal;
    DecimalToBinary(decimal);

    return 0;
}