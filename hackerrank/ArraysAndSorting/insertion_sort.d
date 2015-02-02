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

template match(Env e : Env.local)
{
  string data(What w) {
    final switch (w) {
    case What.entries: return "5 3 1";
    case What.totalTests: return "1";
    case What.totalEntries: return "3";
    }
  }

  void print(int[] sorted) {
    foreach (entry; sorted) {
      writeln(entry);
    }
  }
}


string reader(What w) {
  return match!(myEnv).data(w);
}

void print(int[] sorted) {
  match!(myEnv).print(sorted);
}


void insertionSort(int[] that) {
  int keep, j;

  for (int i=1; i < that.length; i++) {
    keep = that[i];
    for (j = i-1; j >= 0 && that[j] > keep; j--) {
      that[j+1] = that[j];
    }
    that[j+1] = keep;
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

    print(population);
  }

  return 1;
}

