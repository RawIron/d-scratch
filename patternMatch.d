
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


(Regex!char)[] compilePatterns(string[] regexpressions) {
    (Regex!char)[] compiledPatterns = new (Regex!char)[1];
    compiledPatterns[0] = regex(regexpressions[0]);
    return compiledPatterns;
}

unittest {
    (Regex!char)[] regexpression = compilePatterns([r"^BEGIN",]);
    assert(match("BEGIN", regexpression[0]));
}

string[] createPatterns() {
    string[] patterns = new string[2];
    patterns[0] = r"^BEGIN";
    patterns[1] = r"^END";
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
