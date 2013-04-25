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
        if (!election.isComplete(delivered)) {
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
        if (!election.isComplete(votes)) {
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
        if (!election.hasSufficientVoters(received)) {
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
        if (!election.hasMajority(voted)) {
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
    bool isComplete(uint);
    bool hasSufficientVoters(uint);
    bool hasMajority(uint);
}

class AllOrNothingElection : Election {
    private {
        uint _voters = 3;
        uint _voted = 3;
        uint _majority = 3;
    }
    @property uint voters() const { return _voters; }
    @property uint voted() const { return _voted; }
    @property uint majority() const { return _majority; }
    bool isComplete(uint voters) const { return (voters >= _voters); }
    bool hasSufficientVoters(uint voters) const { return (voters >= _voted); }
    bool hasMajority(uint voted) const { return (voted >= _majority); }


    private {
        bool _won;
        bool _lost;
    }
    @property bool won() const { return _won; }
    @property bool lost() const { return _lost; }

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
