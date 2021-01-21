/*
 * =====================================================================================
 *
 *       Filename:  list_of_strings.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  01/30/2020 12:45:34 AM
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
  char *list[] = {"this", "is a", "test"};
  int i = 0;
  for (i = 0; i < 3; i++) {
    printf("%s\n", list[i]);
  }
  return EXIT_SUCCESS;
} /* ----------  end of function main  ---------- */
