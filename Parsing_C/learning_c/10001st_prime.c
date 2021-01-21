#include <stdio.h>
long factors(long x);
long array[2500000] = {0};
int counter = 0;
long prime_counter = 0;
int main(void) {
  for (int i = 0; i < 200000; i++) {
    counter = 0;
    factors(i);
  }
}
long factors(long x) {
  for (long i = 1; i < x / 2 + 1; i++) {
    if (x % i == 0) {
      array[counter] = i;
      counter += 1;
      printf("%ld %s %d\n", i, " ", counter);
    }
  }
  if (counter == 1) {
    prime_counter += 1;
    printf("%ld %s %ld\n", x, "Prime", prime_counter);
  }
}

/* Useage ./10001st_prime |grep "Prime 10001$" */
