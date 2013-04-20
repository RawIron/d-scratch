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


class Election() {
    private MessageExchangeState state;
    this() {
        state = new ReadyToSendStateChange();
    }

    void messagesSent() {
        state = state.messageSent();
    }
    void voteReceived() {
        state = state.voteReceived();
    }
    void countReceivedVotes() {
        state = state.countReceivedVotes();
    }
    void countStateVotes() {
        state = state.countStateVotes();
    }
    void timeout() {
        state = state.timeout();
    }
}


void main() {
}
