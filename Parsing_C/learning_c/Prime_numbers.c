#include <stdio.h>
int prime(int x);
int main(void) {
  for (int z = 2; z < 1000; z++) {
    prime(z);
  }
}
int prime(int x) {
  for (int i = 2; i < x / 2 + 2; i++) {
    if (x % i == 0) {
      break;
    }
    if (i > x / 2) {
      printf("%s %d\n", "Prime", x);
    }
  }
}
