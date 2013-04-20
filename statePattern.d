#!/usr/bin/env rdmd

import std.stdio;


class MessageExchangeState {
    MessageExchangeState messagesSent() {
        return new Invalid();
    }
    MessageExchangeState voteReceived() {
        return new Invalid();
    }
    MessageExchangeState countReceivedVotes() {
        return new Invalid();
    }
    MessageExchangeState countStateVotes() {
        return new Invalid();
    }
    MessageExchangeState timeout() {
        return new Invalid();
    }
    void print() {}
}

class Invalid : MessageExchangeState {
    void print() {
        writeln("invalid");
    }
}


class ReadyToSendStateChange : MessageExchangeState {
    MessageExchangeState messagesSent() {
        return new WaitForVotes();
    }
    MessageExchangeState timeout() {
        return new Invalid();
    }
    void print() {
        writeln("ready");
    }
}

class WaitForVotes : MessageExchangeState {
    private uint voters = 3;
    private uint votes = 0;
    MessageExchangeState voteReceived() {
        ++votes;
        if (votes < voters) {
            return this;
        } else {
            return new ElectionClosed();
        }
    }
    MessageExchangeState timeout() {
        return new ElectionClosed();
    }
    void print() {
        printf("vote %d\n", votes);
    }
}

class ElectionClosed : MessageExchangeState {
    MessageExchangeState countReceivedVotes() {
        return new ElectionCompleted();
    }
    MessageExchangeState timeout() {
        return new ReadyToSendStateChange();
    }
    void print() {
        writeln("election closed");
    }
}

class ElectionCompleted : MessageExchangeState {
    MessageExchangeState countStateVotes() {
        return new ReadyToSendStateChange();
    }
    MessageExchangeState timeout() {
        return new ReadyToSendStateChange();
    }
    void print() {
        writeln("election completed");
    }
}


class Election {
    private MessageExchangeState currentState;
    this() {
        currentState = new ReadyToSendStateChange();
        currentState.print();
    }

    void messagesSent() {
        currentState = currentState.messagesSent();
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



void main() {
    Election phase = new Election();
    phase.messagesSent();
    phase.voteReceived();
    phase.voteReceived();
    phase.voteReceived();
    phase.countReceivedVotes();
    phase.countStateVotes();
}

