#!/usr/bin/env rdmd

import std.stdio;
import statePattern;


class Single(S,E) {
    private E election;
    @property uint voters() const { return election.voters; }
    @property uint voted() const { return election.voted; }
    @property uint majority() const { return election.majority; }
    @property bool won() const { return election.won; }
    bool isComplete(uint voters) const { return (election.isComplete(voters)); }
    bool hasSufficientVoters(uint voters) const { return (election.hasSufficientVoters(voters)); }
    bool hasMajority(uint voted) const { return (election.hasMajority(voted)); }

    private S currentState;
    this() {
        currentState = new ReadyToSendStateChange(this);
        currentState.print();
    }

    void proposeState() {
        currentState = currentState.proposeState();
        currentState.print();
    }
    void voteForStateReceived() {
        currentState = currentState.voteForStateReceived();
        currentState.print();
    }
    void countReceivedVotes() {
        currentState = currentState.countReceivedVotes();
        currentState.print();
    }
    void countVotesForState() {
        currentState = currentState.countVotesForState();
        currentState.print();
    }
    void timeout() {
        currentState = currentState.timeout();
        currentState.print();
    }
}


