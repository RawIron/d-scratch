#!/usr/bin/env rdmd

import std.stdio, std.string, std.algorithm;


unittest {
    int topic() {
        return 25;
    }

    void test_returnsSum25() {
        assert(topic() == 25);
    }

    test_returnsSum25();
}

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
