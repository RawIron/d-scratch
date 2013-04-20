#!/usr/bin/env rdmd


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
}

class Invalid : MessageExchangeState {}


class ReadyToSendStateChange : MessageExchangeState {
    MessageExchangeState messagesSent() {
        return new WaitForVotes();
    }
    MessageExchangeState timeout() {
        return new Invalid();
    }
}

class WaitForVotes : MessageExchangeState {
    MessageExchangeState voteReceived() {
        return new ElectionClosed();
    }
    MessageExchangeState timeout() {
        return new ElectionClosed();
    }
}

class ElectionClosed : MessageExchangeState {
    MessageExchangeState countStateVotes() {
        return new ElectionCompleted();
    }
    MessageExchangeState timeout() {
        return new ReadyToSendStateChange();
    }
}

class ElectionCompleted : MessageExchangeState {
    MessageExchangeState announceResult() {
        return new ReadyToSendStateChange();
    }
    MessageExchangeState timeout() {
        return new ReadyToSendStateChange();
    }
}


class Election {
    private MessageExchangeState cstate;
    this() {
        cstate = new ReadyToSendStateChange();
    }

    void messagesSent() {
        cstate = cstate.messagesSent();
    }
    void voteReceived() {
        cstate = cstate.voteReceived();
    }
    void countReceivedVotes() {
        cstate = cstate.countReceivedVotes();
    }
    void countStateVotes() {
        cstate = cstate.countStateVotes();
    }
    void timeout() {
        cstate = cstate.timeout();
    }
}


void main() {
    Election phase = new Election();
    phase.messagesSent();
}

