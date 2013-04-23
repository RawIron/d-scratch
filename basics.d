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
    c.increase(4);
    assert(c.printConst()==8);
}

void main() { }

