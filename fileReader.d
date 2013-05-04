#!/usr/bin/env rdmd

import std.stdio;
import std.file;
import std.string;


string fileReaderUsingReadText(in string fileName) {
    string content = readText(fileName);
    return content;
}

uint iterateBySplitLines(in string content) {
    uint importCounter = 0;
    foreach (string line; splitLines(content)) {
        if (line.startsWith("import")) {
            ++importCounter;
        }
    }
    return importCounter;
}


uint iterateByLinesStruct(File content) {
    uint importCounter = 0;
    foreach (string line; lines(content)) {
        if (line.startsWith("import")) {
            ++importCounter;
        }
    }
    return importCounter;
}


void main() {
    string fileName = "fileReader.d";
    uint numberOfImports = 0;

    string content = fileReaderUsingReadText(fileName);
    numberOfImports = iterateBySplitLines(content);
    writeln(numberOfImports);

    numberOfImports = iterateByLinesStruct(File(fileName, "r"));
    writeln(numberOfImports);
}

