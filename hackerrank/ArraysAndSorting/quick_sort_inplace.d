#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.cstream, std.algorithm;


void print(int[] sorted)
{
  foreach (entry; sorted) {
    write(to!string(entry) ~ " ");
  }
  writeln;
}


int[] swapIfReverse(int[] that, int i, int j)
{
  if (that[i] < that[j]) return that;
  else return swap(that, i, j);
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
  int[] inplace(int[] that, int left, int p, int right)
  {
    if (that.empty || that[left..right].length == 1) return that;
    else if (that[left..right].length == 2) swapIfReverse(that, 0, 1);
    
    int cutHere = 0;
    int i = 0;
    while (i < that[left..right].length) {
      if (that[i] > p)
        boolean foundSwap = false;
        int j = i;
        while (! foundSwap && j<right) {
          if (that[j] <= p) {
            swap(that, i, j);
            foundSwap = true;
            ++cutHere;
          }
          ++j;
        }
    }

    int[] leftSorted = inplace(that, left, p, right);
    if (leftSorted[].length > 1) print(leftSorted);
    int[] rightSorted = inplace(that, left, p, right);
    if (rightSorted[].length > 1) print(rightSorted);

    sorted = swap(that, right, p);

    return sorted;
  }

  return inplace(that, 0, that[$], that.length-2);
}


int main()
{
  int numberOfEntries = 0;
  int[] population = new int[numberOfEntries];

  //numberOfEntries = to!int(din.readLine());
  //population = splitter(din.readLine().strip(' ')).map!(to!int).array;
  numberOfEntries = 7;
  population = splitter("5 8 1 3 7 9 2".strip(' ')).map!(to!int).array;

  int[] sorted = quicksort(population);

  print(sorted);

  return 0;
}

