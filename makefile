CP=/usr/share/java/antlr-4.2.2-complete.jar
grammar:
	rm -rf bin
	mkdir bin
	rm -f src/*.tokens
	rm -f src/*.java
	antlr4 src/dubscript.g
	javac -cp $(CP) -d bin src/*.java

START=program
SCRIPT=test.dub
run:
	cd bin && grun dubscript $(START) -gui ../$(SCRIPT)
