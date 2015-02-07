#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.cstream, std.algorithm;
import std.array;


int[] emptyArray;


enum ptree = true;
enum tabSize = 2;

struct Print {
  int height = 0;
  char[tabSize] tab = "  ";
  char[] ident;
}

void print(int[] sorted)
{
  foreach (entry; sorted) {
    write(to!string(entry) ~ " ");
  }
  writeln;
}


int[] swap(int[] that, int i, int j)
{
  int tmp = that[i];
  that[i] = that[j];
  that[j] = tmp;
  return that;
}


int[] quicksort(int[] that)
{
  int[] inplace(int[] that, int left, int p, int right, Print d)
  {
    ++d.height;
    d.ident ~= d.tab;
    writefln("%s called %d %d %d", d.ident, left, p, right);

    if (left > right) return emptyArray;
    
    int cutHere = 0;
    int i = 0;
    while (i < that[left..right].length) {
      if (that[i] <= p) {
        ++cutHere;
      }
      else {
        bool foundSwap = false;
        int j = i+1;
        while (!foundSwap && j<=right) {
          if (that[j] <= p) {
            swap(that, i, j);
            foundSwap = true;
            ++cutHere;
          }
          ++j;
        }
      }
      ++i;
    }

    if (cutHere < that[left..right].length) {
      int[] sorted = swap(that, left + cutHere, right+1);
    }
    else {
    }

    int[] leftSorted = inplace(that, left, that[left + cutHere], left + cutHere-1, d);
    writef("%s left ", d.ident);
    writefln("%s", leftSorted);
    //if (leftSorted.length > 1) print(leftSorted);

    int[] rightSorted = inplace(that, left + cutHere+1, that[right+1], right, d);
    writef("%s right ", d.ident);
    writefln("%s", rightSorted);
    //if (rightSorted.length > 1) print(rightSorted);

    return that[left..right+1];
  }

  static if (ptree) {
    Print d;
  }

  if (that.length <= 1) return that;
  else return inplace(that, 0, that[$-1], to!int(that.length-2), d);
}


int main()
{
  int numberOfEntries = 0;
  int[] population = new int[numberOfEntries];

  //numberOfEntries = to!int(din.readLine());
  //population = splitter(din.readLine().strip(' ')).map!(to!int).array;
  numberOfEntries = 7;
  //population = splitter("5 8 1 3 7 9 2".strip(' ')).map!(to!int).array;
  population = splitter("2 1 7".strip(' ')).map!(to!int).array;

  int[] sorted = quicksort(population);

  print(population);

  return 0;
}

