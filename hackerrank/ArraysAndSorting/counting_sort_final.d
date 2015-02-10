#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.cstream, std.algorithm;
import std.array;


void printSentence(in wordStats[][] that, const int ignore)
{
  foreach (counter; that) {
    foreach (wordStat; counter) {
      if (wordStat.pos < ignore) {
        write("- ");
      } else {
        write(wordStat.word, " ");
      }
    }
  }
  writeln;
}


wordStats[][] count(in wordStats[] that)
{
  wordStats[][100] counts;

  foreach (i; that) {
    counts[i.count] ~= i;
  }

  return counts.array;
}

struct wordStats
{
  int count;
  int pos;
  string word;
}


int main()
{
  int numberOfEntries = 1;
  wordStats[] population = new wordStats[numberOfEntries];

  //numberOfEntries = to!int(din.readLine());
  foreach (i; 0..numberOfEntries) {
    string[] line = splitter("3 ab".strip(' ')).array;
    wordStats e = {line[0].to!int, i, line[1]};
    population[i] = e;
    //population[i] = splitter(din.readLine().strip(' ')).array[0].to!int;
  }

  //population = splitter(din.readLine().strip(' ')).map!(to!int).array;
  //population = splitter("3 5 3 2 8".strip(' ')).map!(to!int).array;

  wordStats[][] counts = count(population);

  printSentence(counts, numberOfEntries / 2);

  return 0;
}

