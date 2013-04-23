
statePattern:	statePattern.d
	dmd -unittest statePattern.d

twoPhase:	twoPhaseCommit.d
	dmd -unittest twoPhaseCommit.d

basics:	basics.d
	dmd -unittest basics.d

clean:
	rm -f *.o
	rm -f statePattern basics
