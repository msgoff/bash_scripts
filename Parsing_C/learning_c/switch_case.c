/*
 * =====================================================================================
 *
 *       Filename:  x.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  01/30/2020 12:05:07 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (),
 *   Organization:
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * ===  FUNCTION
 * ====================================================================== Name:
 * main Description:
 * =====================================================================================
 */
int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("%s", "input a string as your first argument.\n");
    return 1;
  }
  int i = 0;
  for (i = 0; argv[1][i] != '\0'; i++) {
    char letter = argv[1][i];
    switch (letter) {
    case 'a':
    case 'A':
      printf("%c", letter);
      break;
    default:
      printf("%d", i);
      break;
    }
  }
  return EXIT_SUCCESS;
} /* ----------  end of function main  ---------- */
