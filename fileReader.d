#!/usr/bin/env rdmd

import std.stdio;
import std.file;
import std.string;


string fileReaderUsingReadText(in string fileName) {
    string content = readText(fileName);
    return content;
}

uint iterateBySplitClosure(in string[] delegate() generator) {
    uint importCounter = 0;
    foreach (string line; generator()) {
        if (line.startsWith("import")) {
            ++importCounter;
        }
    }
    return importCounter;
}

string[] delegate() closureBySplit(string content) {
    return delegate string[]() { return splitLines(content); };
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

/*
 * does not compile ..
lines delegate() closureByLines(File content) {
    return delegate lines() { return lines(content); };
}
*/



void main() {
    string fileName = "fileReader.d";
    uint numberOfImports = 0;
    string content;

    content = fileReaderUsingReadText(fileName);
    string[] delegate() f = closureBySplit(content);
    numberOfImports = iterateBySplitClosure(f);
    writeln(numberOfImports);

    numberOfImports = iterateByLinesStruct(File(fileName, "r"));
    writeln(numberOfImports);

}

