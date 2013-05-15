#!/usr/bin/env rdmd

import std.regex;
import std.stream;


class MatchEngine {
    public {
        MatchEngine receive() { return this; }
        MatchEngine take() { return this; }
    }
}

void matchEngine(Stream quotes, in Regex!char[] patterns, Stream matches) {
}


void compilePattern() {
    regex(r"^BEGIN");
}

unittest {
}

string[] createPattern() {
    string[] patterns;
    patterns[patterns.length] = r"^BEGIN";
    patterns[patterns.length] = r"^END";
    return patterns;
}

unittest {
    string[] patterns = createPattern();
    assert(patterns[0] == r"^BEGIN");
}


void main() {
    Stream quotes = new MemoryStream();
    Stream matches = new MemoryStream();
    compilePattern();

    MatchEngine me = new MatchEngine();
    me.receive().take();

    /*
    matchEngine(quotes, patterns, matches);

    matchEngine.quotes.patterns.matches;

    matchEngine.receive(quotes).take(patterns).deliver(matches);
    matchEngine.take(patterns);
    matchEngine.receive(quotes).deliver(matches);
    */
}
