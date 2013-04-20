
statePattern:	statePattern.d
	dmd -unittest statePattern.d

clean:
	rm -f *.o
	rm -f statePattern basics
