#include <stdio.h>

float total = 0;
int negative = 0;
int zero = 0;
int positive = 0;
int main() {
  int n;
  scanf("%d", &n);
  int arr[n];
  for (int arr_i = 0; arr_i < n; arr_i++) {
    scanf("%d", &arr[arr_i]);
    if (arr[arr_i] == 0) {
      zero += 1;
    }
    if (arr[arr_i] > 0) {
      positive += 1;
    }
    if (arr[arr_i] < 0) {
      negative += 1;
    }
    total += 1;
  }
  printf("%.05f\n", positive / total);
  printf("%.05f\n", negative / total);
  printf("%.05f\n", zero / total);
  return 0;
}
