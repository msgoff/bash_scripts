#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct Person {
  char *name;
  int age;
  int height;
  int weight;
};

struct Person *Person_create(char *name, int age, int height, int weight) {
  struct Person *who = malloc(sizeof(struct Person));
  assert(who != NULL);

  who->name = strdup(name);
  who->age = age;
  who->height = height;
  who->weight = weight;

  return who;
}

void Person_destroy(struct Person *who) {
  assert(who != NULL);
  free(who->name);
  free(who);
}

void Person_print(struct Person *who) { printf("Name %s\n", who->name); }

int main(int argc, char *argv[]) {

  struct Person *joe = Person_create("asdf", 1, 2, 3);
  Person_print(joe);
  Person_destroy(joe);
}
