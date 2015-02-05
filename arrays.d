#!/usr/bin/env rdmd

import std.stdio, std.algorithm;

unittest
{
  int[] energy;
  energy ~= 5;

  assert(energy.length == 1);
  assert(energy[0] == 5);
}

unittest
{
  int[10] energy;

  assert(energy[3..6].length == 3);
}


void main() {}
