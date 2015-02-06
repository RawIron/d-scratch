#!/usr/bin/env rdmd

import std.stdio, std.algorithm;
import core.exception;


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

unittest
{
  int[10] energy;
  int[] empty;

  try {
    assert(energy[1..0] == empty);
    assert(false);
  }
  catch (RangeError e)
    assert(true);
}

unittest
{
  int[10] energy;

  energy[9] = 3;
  assert(energy[$-1] == 3);
}


void main() {}
