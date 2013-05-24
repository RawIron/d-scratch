#!/usr/bin/env rdmd

import std.algorithm : chain, map, copy, Result;
import std.stdio : write, writeln;


void printGreetingsWithLambda() {
    string[] names = ["Anders", "David", "James", "Jeff", "Joe", "Erik"];
    auto f = function string(string a) { return ("Hello! " ~ a); };
    foreach (name; names) {
        writeln(f(name));
    }
}

Result streamProcessing(string[] names) {
    return map!(function string(string a) { return ("Hello!" ~ a ~ "\n"); })(names);
}


void main() {
    string[] names = ["Anders", "David", "James", "Jeff", "Joe", "Erik"];
    Result greetings;

    printGreetingsWithLambda();
    greetings = streamProcessing(names);
    foreach (greeting; greetings) {
        write(greeting);
    }
    //copy(stdout.lockingTextWriter));
}

