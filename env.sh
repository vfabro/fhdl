export CLASSPATH=".:`pwd`/lib/antlr/antlr-4.0-complete.jar:$CLASSPATH"
alias antlr4='java -jar `pwd`/lib/antlr/antlr-4.0-complete.jar'
alias grun='java org.antlr.v4.runtime.misc.TestRig'

alias fhdlb='antlr4 -package eu.mindspark.fhdl src/eu/mindspark/fhdl/fhdl.g4 && javac src/eu/mindspark/fhdl/*.java'
alias fhdlc='cd src; grun eu.mindspark.fhdl.fhdl design_file'
alias fhdltest='fhdlc ../test/testcases/fcall.vhd -trace'

