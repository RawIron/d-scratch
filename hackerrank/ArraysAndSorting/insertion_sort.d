#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.algorithm;
import std.array;


enum Env: int {local, submit};
enum What: int {totalTests, totalEntries, entries};

const Env myEnv = Env.local;


template match(Env e : Env.submit) {
  string data(What w) {
    return din.readLine();
  }
}

template match(Env e : Env.local) {
  string data(What w) {
    return "1";
  }
}


string reader(What w) {
  return match!(myEnv).data(w);
}


void insertionSort(int[] that) {
  foreach (entry; that) {
    writeln(entry);
  }
}

void printSorted(int[] sorted) {
  foreach (entry; sorted) {
    writeln(entry);
  }
}


int main() {
  int numberOfEntries = 0;
  int numberOfTests = 1;
  int[] population = new int[numberOfEntries];

  numberOfEntries = to!int(reader(What.entries));

  foreach (i; 0..numberOfTests) {
    population = splitter("3 5 1".strip(' ')).map!(to!int).array;
    insertionSort(population);
    printSorted(population);
  }

  return 1;
}

