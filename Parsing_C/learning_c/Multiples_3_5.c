#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  printf("%s \n",
         "print the sum of 3's and 5's less than the paramater passed");
  int total = 0;
  int i = 0;
  int passed_parameter = atoi(argv[1]);

  for (i = 0; i < passed_parameter; i++) {
    if (i % 3 == 0 || i % 5 == 0) {
      total += i;
    }
  }

  printf("%d \n", total);

  return 0;
}
