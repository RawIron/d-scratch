#!/usr/bin/env rdmd

import std.stdio;
import std.file;
import std.string;


void main() {
    string fileName = "fileReader.d";
    string content = readText(fileName);
    writeln(content);

    string[] lines = splitLines(content);
    foreach (string line; lines) {
        if (line.startsWith("i")) {
            writeln("y");
        }
    }
}
