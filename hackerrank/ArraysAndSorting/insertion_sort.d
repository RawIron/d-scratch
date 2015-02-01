#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.algorithm;
import std.array;


enum ENV: int {LOCAL, SUBMIT};
enum WHAT: int {TOTAL_TESTS, TOTAL_ENTRIES, ENTRIES};

const ENV env = ENV.LOCAL;


template match(T...){
  string data = din.readLine();
}

template match(ENV e : ENV.SUBMIT) {
  string data = din.readLine();
}

template match(ENV e : ENV.LOCAL) {
  string data = "1";
}


string reader() {
  return match!(env).data;
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
  int numberOfEntries = 0;
  int numberOfTests = 1;
  int[] population = new int[numberOfEntries];

  numberOfEntries = to!int(reader());

  foreach (i; 0..numberOfTests) {
    population = splitter("3 5 1".strip(' ')).map!(to!int).array;
    insertion_sort(population);
    print_sorted(population);
  }

  return 1;
}

