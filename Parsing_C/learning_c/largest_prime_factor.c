#include <stdio.h>
long x = 600;
int factors(long x);
long prime(long x);
long int array[25] = {0};
int counter = 0;
int main(void) {
  factors(x);
  for (int i = 0; i < 25; i++) {
    prime(array[i]);
  }
}

int factors(long x) {
  for (long i = 1; i < x / 2 + 1; i++) {
    if (x % i == 0) {
      array[counter] = i;
      counter += 1;
      printf("%ld\n", i);
    }
  }
}

long prime(long x) {
  for (int i = 2; i < x / 2 + 2; i++) {
    if (x % i == 0) {
      break;
    }
    if (i > x / 2) {
      printf("%s %ld\n", "Prime", x);
    }
  }
}
