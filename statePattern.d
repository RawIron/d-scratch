#!/usr/bin/env rdmd

import std.stdio;


abstract class MessageExchangeState {
    private Election election;
    MessageExchangeState messageSent() {
        return new Invalid(election);
    }
    MessageExchangeState voteReceived() {
        return new Invalid(election);
    }
    MessageExchangeState countReceivedVotes() {
        return new Invalid(election);
    }
    MessageExchangeState countStateVotes() {
        return new Invalid(election);
    }
    MessageExchangeState timeout() {
        return new Invalid(election);
    }
    abstract void print() const;
}


class Invalid : MessageExchangeState {
    private Election election;
    this(Election e) {
        election = e;
    }
    override void print() const {
        writeln("invalid");
    }
}

class MessagesSentFailed : MessageExchangeState {
    private Election election;
    this(Election e) {
        election = e;
    }
    override void print() const {
        writeln("sent failed");
    }
}

class ElectionFailed : MessageExchangeState {
    private Election election;
    this(Election e) {
        election = e;
    }
    override void print() const {
        writeln("election failed");
    }
}

class ElectionLost : MessageExchangeState {
    private Election election;
    this(Election e) {
        election = e;
    }
    override void print() const {
        writeln("election lost");
    }
}

class ElectionWon : MessageExchangeState {
    private Election election;
    this(Election e) {
        election = e;
    }
    override void print() const {
        writeln("election won");
    }
}


class ReadyToSendStateChange : MessageExchangeState {
    private Election election;
    this(Election e) {
        election = e;
    }
    private uint delivered = 0;
    private MessageExchangeState evaluate() {
        if (delivered < election.voters()) {
            return this;
        } else {
            return new WaitForVotes(election);
        }
    }
    override MessageExchangeState messageSent() {
        ++ delivered;
        return evaluate();
    }
    override MessageExchangeState timeout() {
        return new MessagesSentFailed(election);
    }
    override void print() const {
        writeln("message sent");
    }
}

class WaitForVotes : MessageExchangeState {
    private Election election;
    this(Election e) {
        election = e;
    }
    private uint votes = 0;
    override MessageExchangeState voteReceived() {
        ++votes;
        if (votes < election.voters()) {
            return this;
        } else {
            return new ElectionClosed(election);
        }
    }
    override MessageExchangeState timeout() {
        return new ElectionClosed(election);
    }
    override void print() const {
        printf("vote %d\n", votes);
    }
}

class ElectionClosed : MessageExchangeState {
    private Election election;
    this(Election e) {
        election = e;
    }
    private uint received = 0;
    override MessageExchangeState countReceivedVotes() {
        ++received;
        if (received < election.voted()) {
            return this;
        } else {
            return new ElectionCompleted(election);
        }
    }
    override void print() const {
        writeln("election closed");
    }
}

class ElectionCompleted : MessageExchangeState {
    private Election election;
    this(Election e) {
        election = e;
    }
    private uint voted = 0;
    override MessageExchangeState countStateVotes() {
        ++voted;
        if (voted < election.majority()) {
            return this;
        }
        return new ElectionWon(election);
    }
    override void print() const {
        writeln("election completed");
    }
}


interface Election {
    uint voters();
    uint voted();
    uint majority();
}

class AllOrNothingElection : Election {
    private uint _voters = 3;
    private uint _voted = 3;
    private uint _majority = 3;
    uint voters() { return _voters; }
    uint voted() { return _voted; }
    uint majority() { return _majority; }

    private bool _won;
    private bool _lost;
    bool won() { return _won; }
    bool lost() { return _lost; }

    private MessageExchangeState currentState;
    this() {
        currentState = new ReadyToSendStateChange(this);
        currentState.print();
    }

    void messageSent() {
        currentState = currentState.messageSent();
        currentState.print();
    }
    void voteReceived() {
        currentState = currentState.voteReceived();
        currentState.print();
    }
    void countReceivedVotes() {
        currentState = currentState.countReceivedVotes();
        currentState.print();
    }
    void countStateVotes() {
        currentState = currentState.countStateVotes();
        currentState.print();
    }
    void timeout() {
        currentState = currentState.timeout();
        currentState.print();
    }
}

unittest {
    scope phase = new AllOrNothingElection();
    phase.messageSent();
    phase.messageSent();
    phase.messageSent();
    phase.voteReceived();
    phase.voteReceived();
    phase.voteReceived();
    phase.countReceivedVotes();
    phase.countReceivedVotes();
    phase.countReceivedVotes();
    phase.countStateVotes();
    phase.countStateVotes();
    phase.countStateVotes();
}

unittest {
    scope phase = new AllOrNothingElection();
    phase.messageSent();
    phase.voteReceived();
    phase.voteReceived();
    phase.timeout();
    phase.countReceivedVotes();
    phase.countStateVotes();
}


void main() {}

