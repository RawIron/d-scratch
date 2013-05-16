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


unittest {
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
    immutable message = "this is text for a test";
    doSomething(message);
}


unittest {
    class Constness {
        int value = 4;
        int printImmutable() immutable { return value; }
        int printConst() const { return value; }
        void increaseBy(const int increment) { 
            value += increment;
        }
    }

    auto c = new Constness();
    // c.printImmutable();
    assert(c.printConst()==4);
    c.increaseBy(4);
    assert(c.printConst()==8);
}


unittest {
    struct Settings {
        bool flag = false;
        string log = "";
    }

    Settings config;
    assert(config.flag == false);
    assert(config.log == "");
}

unittest {
    string aString = "compare to something else";
    string anotherString = "compare to something else";

    assert(aString is anotherString);
    assert(aString == anotherString);
}


unittest {
    immutable CHUNK_SIZE = 64;
    uint[] series = new uint[CHUNK_SIZE];
    assert(series.length == CHUNK_SIZE);
    series[0] = 5;
    assert(series.length == CHUNK_SIZE);
}

unittest {
    /**
    // does not compile
    class Parent { public static string method() { return "parent"; } }
    class Child : Parent { public override static string method() { return "child"; } }
    */
}


unittest {
    class StoryTeller {
        private string story = "is sparta";
        this(string prolog) {
            story = prolog ~ story;
        }
        public abstract string tell();
    }
    class MovieStory : StoryTeller {
        this(string prolog) {
            super(prolog);
        }
        override public string tell() {
            return story;
        }
    }
    MovieStory story = new MovieStory("this ");
    assert(story.tell() == "this is sparta");
}

unittest {
    string[] s = new string[2];
    s ~= "whereIsIt";
    assert(s.length == 3);
    assert(s[0] is null);
    assert(s[2] == "whereIsIt");
}

/*
unittest {
    class GenericKlass(T) {
        private T decorated;
        public this(T decorated) {
            this.decorated = decorated;
        }
        public string echo() { return decorated.echo(); }
    }
    class CanEcho {
        public string echo() { return "can echo"; }
    }

    (GenericKlass!CanEcho)[] echos = new (GenericKlass!CanEcho)[2];
    
    foreach(k; echos) {
        k.echo();
    }
}
*/

void main() {}

