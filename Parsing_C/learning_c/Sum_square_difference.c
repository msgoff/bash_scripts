#include <stdio.h>
long double power(long x, int pwr);
long double sum_of_squares = 0;
int sum = 0;
int main(void) {
  for (int i = 1; i <= 100; i++) {
    sum_of_squares += power(i, 2);
    sum += i;
  }
  printf("%Lf\n", power(sum, 2) - sum_of_squares);
}

long double power(long x, int pwr) {
  long double output = x;
  for (int i = 1; i < pwr; i++) {
    output *= x;
  }
  return output;
}
