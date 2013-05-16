#!/usr/bin/env rdmd


import std.concurrency, std.stdio;

class Wallet {}


interface ControlEvent {
    bool isStopped();
    void shutdown();
}

interface WalletEvent {
    void execute();
}


class WalletWithdraw : WalletEvent {
    void execute() {
    }
}


void worker() {
    while (true) {
        auto event = receiveOnly!(Tid, WalletEvent)();
        writeln("done");
        event[0].send(thisTid);
    }
}


void main() {
    WalletEvent[] jobs = [new WalletWithdraw(), new WalletWithdraw(), ];
    immutable WalletEvent job;

    auto tid = spawn(&worker);
    foreach (job; jobs) {
        writeln("send");
        tid.send(thisTid, job);
        receiveOnly!Tid();
    }
}

