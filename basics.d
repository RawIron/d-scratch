#!/usr/bin/env rdmd

import std.stdio, std.string, std.algorithm;

void doSomething(in string line) {
    void write(string aWord) {
        writeln(aWord);
    }

    ulong[string] dict;
    foreach (word; splitter(strip(line))) {
        write(word);
        dict[word] = dict.length;
    }
}

void main() {
    immutable message = "this is text for a test";
    doSomething(message);
}
