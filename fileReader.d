#!/usr/bin/env rdmd

import std.stdio;
import std.file;
import std.string;


string fileReaderUsingReadText() {
    string fileName = "fileReader.d";
    string content = readText(fileName);
    writeln(content);
    return content;
}

int iterateBySplitLines(in string content) {
    string[] lines = splitLines(content);
    int countI = 0;
    foreach (string line; lines) {
        if (line.startsWith("i")) {
            ++countI;
        }
    }
    return countI;
}


void main() {
    auto content = fileReaderUsingReadText();
    iterateBySplitLines(content);
}

