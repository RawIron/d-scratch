#!/usr/bin/env rdmd

import std.stdio;


class MessageExchangeState {
    MessageExchangeState messageSent() {
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

class MessagesSentFailed : MessageExchangeState {
    void print() {
        writeln("sent failed");
    }
}

class ElectionFailed : MessageExchangeState {
    void print() {
        writeln("election failed");
    }
}

class ElectionLost : MessageExchangeState {
    void print() {
        writeln("election lost");
    }
}

class ElectionWon : MessageExchangeState {
    void print() {
        writeln("election won");
    }
}


class ReadyToSendStateChange : MessageExchangeState {
    private uint voters = 3;
    private uint delivered = 3;
    MessageExchangeState messageSent() {
        ++ delivered;
        if (delivered < voters) {
            return this;
        } else {
            return new WaitForVotes();
        }
    }
    MessageExchangeState timeout() {
        return new MessagesSentFailed();
    }
    void print() {
        writeln("message sent");
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
    private uint received = 3;
    private uint required = 3;
    MessageExchangeState countReceivedVotes() {
        if (received < required) {
            return new ElectionFailed();
        } else {
            return new ElectionCompleted();
        }
    }
    void print() {
        writeln("election closed");
    }
}

class ElectionCompleted : MessageExchangeState {
    private uint voted = 3;
    private uint majority = 3;
    MessageExchangeState countStateVotes() {
        if (voted < majority) {
            return new ElectionLost();
        }
        return new ElectionWon();
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
    Election phase = new Election();
    phase.messageSent();
    phase.voteReceived();
    phase.voteReceived();
    phase.timeout();
    phase.countReceivedVotes();
    phase.countStateVotes();
}

unittest {
    Election phase = new Election();
    phase.messageSent();
    phase.voteReceived();
    phase.voteReceived();
    phase.voteReceived();
    phase.countReceivedVotes();
    phase.countStateVotes();
}


void main() {}

