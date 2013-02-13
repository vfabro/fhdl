============================
========== FHDL ============
============================
- A free VHDL antlr parser -
----------------------------

1) install
you need to add antlr

to start, source env.sh to get variables

source env.sh
antlr4 -package eu.mindspark.fhdl src/eu/mindspark/fhdl/fhdl.g4
export CLASSPATH="./src/:/usr/local/lib/antlr-4.0-complete.jar:$CLASSPATH"
javac src/eu/mindspark/fhdl/*.java


2) run:

# the classpath includes the src folder for now, will do a build folder when needed
grun eu.mindspark.fhdl.fhdl r0 
#type something then enter, ctrl-d


