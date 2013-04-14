#!/usr/bin/env rdmd

import std.stdio;

void doSomething(immutable int times) {
    immutable message = "hello";
    foreach (iter; 0..times) {
        writeln(message);
    }
}

void main() {
    doSomething(5);
}
