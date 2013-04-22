
import statePattern;


unittest {
    Election prepareToCommit = new AllOrNothingElection();
    prepareToCommit.messageSend();

    if (prepareToCommit.won()) {
        Election commit = new AllOrNothingElection();
        commit.messageSend();
        if (commit.lost()) {
            Election brokenCommit = new AllOrNothingElection();
            brokenCommit.messageSend();
        }
    } else if (prepareToCommit.lost()) {
        Election abort = new AllOrNothingElection();
        abort.messageSend();
        if (abort.lost()) {
            Election brokenAbort = new AllOrNothingElection();
            brokenAbort.messageSend();
        }
    }
}
