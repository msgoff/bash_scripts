#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  printf("%s \n", "print the sum of even Fibonacci number less than a number");
  int total = 0;
  int i = 0;
  int place_holder = 0;
  int passed_param = atoi(argv[1]);

  int arr[2] = {1, 2};

  while (arr[1] < passed_param) {

    if (arr[1] % 2 == 0) {
      total += arr[1];
      printf("%d\n", arr[1]);
    }

    place_holder = arr[0] + arr[1];
    arr[0] = arr[1];
    arr[1] = place_holder;
  }

  printf("%d \n", total);

  return 0;
}
