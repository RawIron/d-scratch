#!/usr/bin/rdmd

import std.stdio, std.algorithm;


int main()
{
  int[] energy;

  energy ~= 1;
  foreach (e; energy) writeln(e);

  return 0;
}
