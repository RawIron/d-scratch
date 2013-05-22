#!/usr/bin/env rdmd

import std.algorithm : chain, map, copy;
import std.stdio;


void printGreetingsWithLambda() {
    string[] names = ["Anders", "David", "James", "Jeff", "Joe", "Erik"];
    auto f = function string(string a) { return ("Hello! " ~ a); };
    foreach (name; names) {
        writeln(f(name));
    }
}

void streamProcessing() {
    string[] names = ["Anders", "David", "James", "Jeff", "Joe", "Erik"];
    auto greetings = map!(function string(string a) { return ("Hello!" ~ a ~ "\n"); })(chain(names));
    foreach (greeting; greetings) {
        write(greeting);
    }
    //copy(stdout.lockingTextWriter));
}


void main() {
    printGreetingsWithLambda();
    streamProcessing();
}

