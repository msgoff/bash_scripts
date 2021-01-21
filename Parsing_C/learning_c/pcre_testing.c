#include <pcre.h>
#include <stdio.h>
#include <string.h>
#define OVECCOUNT 30
int main(int argc, char *argv[]) {
  pcre *re;
  char *pattern;
  char *subject;
  const char *error;
  int erroffset;
  int ovector[OVECCOUNT];
  int rc;
  int input_length;
  pattern = argv[1];
  FILE *input = NULL;
  char *filename = NULL;
  filename = argv[2];
  input = fopen(filename, "r");
  const char *file_data;
  re = pcre_compile(pattern, 0, &error, &erroffset, NULL);
  file_data = input;
  input_length = sizeof(input);

  rc = pcre_exec(re,           /* the compiled pattern */
                 NULL,         /* no extra data - we didn't study the pattern */
                 input,        /* the subject string */
                 input_length, /* the length of the subject */
                 0,            /* start at offset 0 in the subject */
                 0,            /* default options */
                 ovector,      /* output vector for substring information */
                 OVECCOUNT);   /* number of elements in the output vector */

  printf("%d", rc);
  printf("\nMatch succeeded at offset %d\n", ovector[0]);
  // printf("%s",ovector[0]);
  return 0;
}
