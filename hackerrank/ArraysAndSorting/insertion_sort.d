#!/usr/bin/rdmd

import std.stdio, std.conv;


enum ENV: int {LOCAL, SUBMIT};
enum WHAT: int {TOTAL_TESTS, TOTAL_ENTRIES, ENTRIES};

struct conf {
  immutable ENV env;
  WHAT read_what;
}

template match(T...){
  string data = din.readLine();
}

template match(ENV e : SUBMIT) {
  string data = din.readLine();
}

template match(ENV e : LOCAL, WHAT w: TOTAL_TESTS) {
  string data = "1";
}

template match(ENV e : LOCAL, WHAT w: TOTAL_ENTRIES) {
  string data = "3";
}

template match(ENV e : LOCAL, WHAT w: ENTRIES) {
  string data = "3 5 8";
}

string reader(conf) {
  return match!(conf.env, conf.read_what).data;
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


int main() {
  conf conf = {LOCAL, TOTAL_TESTS};

  immutable int numberOfEntries;
  immutable int numberOfTests;
  int[] population = new int[numberOfEntries];

  numberOfEntries = toInt(reader(conf));

  foreach (i; 0 .. numberOfTests) {
    population = splitter(strip("3 5 1"));

    insertion_sort(population);
  }

  return 1;
}
