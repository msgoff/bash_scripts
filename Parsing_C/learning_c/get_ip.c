#define _GNU_SOURCE /* To get defns of NI_MAXSERV and NI_MAXHOST */
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <linux/if_link.h>
#include <netdb.h>
#include <regex.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

void re_findall(char *ip_address) {
  regex_t regex;
  int reti;
  char msgbuf[100];
  reti = regcomp(&regex, "192.168.*", 0);
  if (reti) {
    fprintf(stderr, "Could not compile regex\n");
    exit(1);
  }
  reti = regexec(&regex, ip_address, 0, NULL, 0);
  if (!reti) {
    puts(ip_address);
  }
  // else if (reti == REG_NOMATCH) {
  //    puts("No match");
  //}
  /*else {
      regerror(reti, &regex, msgbuf, sizeof(msgbuf));
      fprintf(stderr, "Regex match failed: %s\n", msgbuf);
      exit(1);
  }*/
  /* Free memory allocated to the pattern buffer by regcomp() */
  regfree(&regex);
}

int main(int argc, char *argv[]) {
  struct ifaddrs *ifaddr, *ifa;
  int family, s, n;
  char host[NI_MAXHOST];

  if (getifaddrs(&ifaddr) == -1) {
    perror("getifaddrs");
    exit(EXIT_FAILURE);
  }

  /* Walk through linked list, maintaining head pointer so we
     can free list later */

  for (ifa = ifaddr, n = 0; ifa != NULL; ifa = ifa->ifa_next, n++) {
    if (ifa->ifa_addr == NULL)
      continue;

    family = ifa->ifa_addr->sa_family;

    /* Display interface name and family (including symbolic
       form of the latter for the common families) */

    /* For an AF_INET* interface address, display the address */

    if (family == AF_INET) {
      s = getnameinfo(ifa->ifa_addr,
                      (family == AF_INET) ? sizeof(struct sockaddr_in) : 0,
                      host, NI_MAXHOST, NULL, 0, NI_NUMERICHOST);
      int y;
      y = strcmp(ifa->ifa_name, "lo");
      if (y != 0) {
        // printf("%s:%s\n",ifa->ifa_name, host);
        re_findall(host);
      }
    }
  }

  freeifaddrs(ifaddr);
  exit(EXIT_SUCCESS);
}
