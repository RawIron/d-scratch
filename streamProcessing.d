#!/usr/bin/env rdmd

import std.algorithm : chain, map, copy;
import std.stdio;


void streamProcessing() {
    ["Anders", "David", "James", "Jeff", "Joe", "Erik"]
        .map!(str => chain("Hello! ", str, "\n"))
        .copy(stdout.lockingTextWriter());
}


void main() {
    streamProcessing();
}

