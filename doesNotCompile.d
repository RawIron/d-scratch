#!/usr/bin/env rdmd

import std.stdio, std.string, std.algorithm;


unittest {
    class Parent { public static string method() { return "parent"; } }
    class Child : Parent { public override static string method() { return "child"; } }
}


unittest {
    class GenericKlass(T) {
        private T decorated;
        public this(T decorated) {
            this.decorated = decorated;
        }
        public string echo() { return decorated.echo(); }
    }
    class CanEcho {
        public string echo() { return "can echo"; }
    }

    (GenericKlass!CanEcho)[] echos = new (GenericKlass!CanEcho)[2];
    
    foreach(k; echos) {
        k.echo();
    }
}

