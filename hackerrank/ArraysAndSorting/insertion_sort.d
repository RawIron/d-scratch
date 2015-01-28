#!/usr/bin/rdmd

import std.stdio;


enum ENV = {LOCAL, SUBMIT};
enum WHAT = {TOTAL_TESTS, TOTAL_ENTRIES, ENTRIES};

struct conf {
  immutable ENV env;
  WHAT read_what;
}


void insertion_sort(int[] that) {
  foreach (entry; that) {
    writeln(entry);
  }
}

void print_sorted(int[] sorted) {
  foreach (entry; sorted) {
    writeln(entry);
  }
}

void reader(conf) {
  match(conf.env) {
  SUBMIT: din.readLine()
  LOCAL:
    match(conf.read_what) {
      TOTAL_TESTS: "1"
      TOTAL_ENTRIES: "3"
      ENTRIES: "3 5 8"
    }
  }
}


int main() {
  conf conf = {LOCAL, TOTAL_TESTS}

  immutable int numberOfEntries;
  immutable int numberOfTests;
  int[] population = new int[numberOfEntries];

  numberOfEntries = std.conv.toInt(reader())

  for (0 .. numberOfTests) {
    population = splitter(strip("3 5 1"));

    insertion_sort(population);
  }

  return 1;
}
