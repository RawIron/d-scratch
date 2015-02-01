#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.algorithm;
import std.array;


enum env: int {local, submit};
enum what: int {TOTAL_TESTS, TOTAL_ENTRIES, entries};

const env my_env = env.local;


template match(env e : env.submit) {
  string data(what w) {
    return din.readLine();
  }
}

template match(env e : env.local) {
  string data(what w) {
    return "1";
  }
}


string reader(what w) {
  return match!(my_env).data(w);
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

  numberOfEntries = to!int(reader(what.entries));

  foreach (i; 0..numberOfTests) {
    population = splitter("3 5 1".strip(' ')).map!(to!int).array;
    insertion_sort(population);
    print_sorted(population);
  }

  return 1;
}

