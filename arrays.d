#!/usr/bin/rdmd

import std.stdio, std.algorithm;


int main()
{
  int[] energy;

  energy ~= 1;
  writeln(energy.length);

  foreach (e; energy) writeln(e);

  return 0;
}
