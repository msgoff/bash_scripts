#include <stdio.h>

int main() {

  unsigned long long i, j, x = 600851475143;

  for (i = 3; i < x / 2; i += 2) {
    for (j = 2; j < i / 2 + 1; j++) {
      if (i % j == 0) {
        break;
      } else if (j == i / 2 - 1) {
        if (x % i == 0) {
          printf("%llu \n", i);
        }
      }
    }
  }

  return 0;
}
