#!/usr/bin/env rdmd

import std.stdio;
import std.file;


void main() {
    string fileName = "fileReader.d";
    string content = readText(fileName);
    writeln(content);
}
