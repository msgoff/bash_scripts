/*
 * =====================================================================================
 *
 *       Filename:  system_call.c
 *
 *    Description:  simple system call
 *		    https://rosettacode.org/wiki/Get_system_command_output#C
 *        Version:  1.0
 *        Created:  01/28/2020 06:25:19 PM
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
#include <string.h>

int main(int argc, char *argv[]) {

  if (argc < 2)
    return 1;
  FILE *fd;
  fd = popen(argv[1], "r");
  if (!fd)
    return 1;

  char buffer[256];
  size_t chread;
  size_t comalloc = 256;
  size_t comlen = 0;
  char *comout = malloc(comalloc);

  while ((chread = fread(buffer, 1, sizeof(buffer), fd)) != 0) {
    if (comlen + chread >= comalloc) {
      comalloc *= 2;
      comout = realloc(comout, comalloc);
    }
    memmove(comout + comlen, buffer, chread);
    comlen += chread;
  }
  fwrite(comout, 1, comlen, stdout);
  free(comout);
  pclose(fd);
  return 0;
}
