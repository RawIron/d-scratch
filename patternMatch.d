
import std.regex;
import std.stream;


class MatchEngine {
    public {
        MatchEngine receive() { return this; }
        MatchEngine take() { return this; }
    }
}

unittest {
    MatchEngine me = new MatchEngine();
    me.receive().take();
}

void matchEngine(Stream quotes, in Regex!char[] patterns, Stream matches) {
}


Regex!char[] compilePatterns(string[] regexpressions) {
    Regex!char[] compiledPatterns = new Regex!char[2];
    foreach (i, regexpression; regexpressions) {
        compiledPatterns[i] = regex(regexpression);
    }
    return compiledPatterns;
}

unittest {
    Regex!char[] regexpression = compilePatterns([r"^BEGIN", r"^END",]);
    RegexMatch!(string,ThompsonMatcher) found = match("BEGIN OF", regexpression[0]);
    assert("BEGIN" == found.hit);
    found = match("BGEIN OF", regexpression[0]);
    assert(!found);
}

string[] createPatterns() {
    string[] patterns = [r"^BEGIN", r"^END", ];
    return patterns;
}

unittest {
    string[] patterns = createPatterns();
    assert(patterns[0] == r"^BEGIN");
}


void main() {
    Stream quotes = new MemoryStream();
    Stream matches = new MemoryStream();

    /*
    matchEngine(quotes, patterns, matches);

    matchEngine.quotes.patterns.matches;

    matchEngine.receive(quotes).take(patterns).deliver(matches);
    matchEngine.take(patterns);
    matchEngine.receive(quotes).deliver(matches);
    */
}
