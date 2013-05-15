#!/usr/bin/env rdmd

import std.regex;
import std.stream;


void matchEngine(Stream quotes, in Regex!char[] patterns, Stream matches) {
}

void compilePattern() {
    regex(r"^BEGIN");
}

string[] createPattern() {
    string[] patterns;
    patterns[patterns.length] = r"^BEGIN";
    patterns[patterns.length] = r"^END";
    return patterns;
}


void main() {
    Stream quotes = new MemoryStream();
    Stream matches = new MemoryStream();
    compilePattern();

    /*
    matchEngine(quotes, patterns, matches);

    matchEngine.quotes.patterns.matches;

    matchEngine.receive(quotes).take(patterns).deliver(matches);
    matchEngine.take(patterns);
    matchEngine.receive(quotes).deliver(matches);
    */
}
