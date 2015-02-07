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

unittest // length works on slices
{
  int[10] energy;

  assert(energy[3..6].length == 3);
}

unittest // crossed indexes in slice throws
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

unittest  // $ equals length
{
  int[10] energy;

  energy[9] = 3;
  assert(energy[$-1] == 3);
}

unittest
{
  int[] energy = new int[4];
  int[] part;

  assert(energy.length == 4);
  part = energy[1..3];

  energy[2] = 4;
  assert(part[1] == 4);
}

unittest  // dynamic array is passed by reference
{
  void addTo(int[] vec) {
    vec[2] += 1;
  }

  int[] energy = new int[4];
  addTo(energy);

  assert(energy[2] == 1);
  assert(energy[3] == 0);
}


void main() {}
