
import std.regex;
import std.streams;


void matchEngine(stream quotes, in Regex[] patterns, stream matches) {
}

Regex[] createPattern() {
}

string[] createPattern() {
    string[] patterns;
    patterns.add(r"^BEGIN");
    patterns.add(r"^END");
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
