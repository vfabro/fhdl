package eu.mindspark.fhdl;

import java.io.IOException;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;

public class Fhdl {

	public Fhdl() {}

	public static void main(String[] args) throws IOException {
		fhdlLexer lexer = new fhdlLexer(new ANTLRFileStream(args[0]));
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		fhdlParser p = new fhdlParser(tokens);
		p.setBuildParseTree(true);
		p.addParseListener(new SemanticFhdlListener());
		ParserRuleContext t = p.design_file();
	}
}
