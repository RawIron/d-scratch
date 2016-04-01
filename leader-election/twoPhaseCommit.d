
import statePattern;


unittest {
    uint voters = 5;
    auto prepareToCommit = new AllOrNothingElection();

    foreach (i; 0..voters) {
        prepareToCommit.messageSent();
    }

    if (prepareToCommit.won()) {
        auto commit = new AllOrNothingElection();
        commit.messageSent();
        if (commit.lost()) {
            auto brokenCommit = new AllOrNothingElection();
            brokenCommit.messageSent();
        }
    } else if (prepareToCommit.lost()) {
        auto abort = new AllOrNothingElection();
        abort.messageSent();
        if (abort.lost()) {
            auto brokenAbort = new AllOrNothingElection();
            brokenAbort.messageSent();
        }
    }
}

void main() {}
