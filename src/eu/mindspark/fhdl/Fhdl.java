package eu.mindspark.fhdl;

import java.io.IOException;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.*;
import eu.mindspark.fhdl.*;

public class Fhdl {

	public Fhdl() {}

	public static void main(String[] args) throws IOException {
		for (String arg : args) {
			System.out.println("Analyzing "+arg);
			fhdlLexer lexer = new fhdlLexer(new ANTLRFileStream(arg));
			CommonTokenStream tokens = new CommonTokenStream(lexer);
			fhdlParser p = new fhdlParser(tokens);
			p.addParseListener(new NameCheckListener());
			System.gc(); // Cleanup
		}
	}
}
