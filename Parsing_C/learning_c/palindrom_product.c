#include <stdio.h>
#include <string.h>

void reverse_string(char *str, int size);

int main() {
  /* 999*999 -> 6 chars */

  const char *fmt = "%d";
  int i, j;
  for (i = 100; i < 1000; i++) {
    for (j = 100; j < 1000; j++) {
      int sz = snprintf(NULL, 0, fmt, i * j);
      char buf[sz + 1]; // note +1 for terminating null byte
      snprintf(buf, sizeof buf, fmt, i * j);
      reverse_string(buf, sz);
    }
  }
}

void reverse_string(char *str, int size) {
  int i;
  int counter = 0;
  char rev_buf[size];

  for (i = size - 1; i >= 0; i--) {
    if (str[i] == str[counter]) {
      rev_buf[counter] = str[i];
    } else
      break;
    counter += 1;
  }

  if (counter == 6) {
    printf("%s\n", rev_buf);
  }
}
