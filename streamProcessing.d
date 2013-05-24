#!/usr/bin/env rdmd

import std.algorithm : chain, map, copy;
import std.stdio : write, writeln;
import std.range;


void
printGreetingsWithLambda(Range)(in Range names) 
    if (isInputRange!Range)
{
    string function(string) f = function string(string a) { return ("Hello! " ~ a); };
    foreach (name; names) {
        writeln(f(name));
    }
}

/*
Result streamProcessing(in Range names) {
    return map!(function string(string a) { return ("Hello!" ~ a ~ "\n"); })(names);
}
*/


void main() {
    string[] names = ["Anders", "David", "James", "Jeff", "Joe", "Erik"];
    string[] greetings;

    printGreetingsWithLambda(names);
    //greetings = streamProcessing(names);
    foreach (greeting; greetings) {
        write(greeting);
    }
    //copy(stdout.lockingTextWriter));
}

