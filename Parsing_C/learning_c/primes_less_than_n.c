#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {

  int passed_param = atoi(argv[1]);
  int arr[passed_param];
  memset(arr, 0, passed_param * sizeof(int));

  int i = 0;
  int j = 0;

  arr[0] = 2;
  printf("%d\n", arr[0]);

  /* keep track of the index with the first 0 */
  int index = 1;

  for (i = arr[index - 1]; i <= passed_param; i++) {

    for (j = 0; j < index; j++) {
      if (i % arr[j] == 0) {
        break;
      } else if (j == index - 1) {
        arr[index] = i;
        printf("%d\n", arr[index]);
        index++;
      }
    }
  }

  return 0;
}
