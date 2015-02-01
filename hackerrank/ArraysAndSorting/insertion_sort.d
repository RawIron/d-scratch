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
    final switch (w) {
    case What.entries: return "5 3 1";
    case What.totalTests: return "1";
    case What.totalEntries: return "3";
    }
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

  numberOfTests = to!int(reader(What.totalTests));

  foreach (i; 0..numberOfTests) {
    numberOfEntries = to!int(reader(What.totalEntries));
    population = splitter(reader(What.entries).strip(' ')).map!(to!int).array;

    insertionSort(population);
    printSorted(population);
  }

  return 1;
}

