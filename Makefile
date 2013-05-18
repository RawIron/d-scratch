
patternMatch:	patternMatch.d
	dmd -unittest patternMatch.d

statePattern:	statePattern.d
	dmd -unittest statePattern.d

twoPhase:	twoPhaseCommit.d
	dmd -unittest twoPhaseCommit.d

basics:	basics.d
	dmd -w -wi -unittest basics.d

clean:
	rm -f *.o
	rm -f statePattern basics patternMatch
	rm -f *.d.deps
