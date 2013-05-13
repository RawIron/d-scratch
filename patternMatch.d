
import std.regex;
import std.streams;

import std.algorithm : chain, map, copy;
import std.stdio;


void matchEngine(stream quotes, in Regex[] patterns, stream matches) {
}

Regex[] createPattern() {
}

string[] createPattern() {
    string[] patterns;
    patterns.add(r"^BEGIN");
    patterns.add(r"^END");
}


void streamProcessing() {
    ["Anders", "David", "James", "Jeff", "Joe", "Erik"]
        .map!(str => chain("Hello! ", str, "\n"))
        .copy(stdout.lockingTextWriter());
}


void main() {
    stream quotes = new Stream();
    stream matches = new Stream();
    Regex[] p = createPattern();

    matchEngine(quotes, patterns, matches);

    matchEngine.quotes.patterns.matches;

    matchEngine.receive(quotes).take(patterns).deliver(matches);
    matchEngine.take(patterns);
    matchEngine.receive(quotes).deliver(matches);
}
