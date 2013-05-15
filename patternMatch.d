#!/usr/bin/env rdmd

import std.regex;
import std.stream;

import std.algorithm : chain, map, copy;
import std.stdio;
import std.container;


void matchEngine(Stream quotes, in Regex!char[] patterns, Stream matches) {
}

Regex!(char)[] compilePattern() {
    Regex!(char)[] regexes;
    regexes[regexes.length] = regex(r"^BEGIN");
    return regexes;
}

string[] createPattern() {
    string[] patterns;
    patterns[patterns.length] = r"^BEGIN";
    patterns[patterns.length] = r"^END";
    return patterns;
}


/*
void streamProcessing() {
    ["Anders", "David", "James", "Jeff", "Joe", "Erik"]
        // .map!(str => chain("Hello! ", str, "\n"))
        .map!(chain("Hello! ", a, "\n"))
        .copy(stdout.lockingTextWriter());
}
*/


void main() {
    Stream quotes = new MemoryStream!(string[])();
    Stream matches = new MemoryStream!(string[])();
    Regex!(char)[] p = compilePattern();

    /*
    matchEngine(quotes, patterns, matches);

    matchEngine.quotes.patterns.matches;

    matchEngine.receive(quotes).take(patterns).deliver(matches);
    matchEngine.take(patterns);
    matchEngine.receive(quotes).deliver(matches);
    */
}
