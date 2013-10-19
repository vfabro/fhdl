package eu.mindspark.fhdl;

import java.io.IOException;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.*;

import eu.mindspark.fhdl.*;

public class Fhdl {

	public Fhdl() {}
	public static AstNode astNetlist = new AstNode(AstNode.AstNodeType.AST_NETLIST);
	
	public static void main(String[] args) throws IOException {
		for (String arg : args) {
			System.out.println("Analyzing "+arg);
			fhdlLexer lexer = new fhdlLexer(new ANTLRFileStream(arg));
			CommonTokenStream tokens = new CommonTokenStream(lexer);
			fhdlParser p = new fhdlParser(tokens);
			p.addParseListener(new NameCheckListener());
			ParseTree tree = p.design_file();
			AstGenVisitor astVisitor = new AstGenVisitor();
			astVisitor.visit(tree);
			System.gc(); // Cleanup
		}
		System.out.println(astNetlist.toStringTreeOneLine());
	}
}
