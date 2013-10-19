/*  FHDL Antlr 4 Grammar for VHDL IEEE Std 1076-1993 parsing
    Copyright (C) 2013 Stanislas Rusinsky, Sebastien Van Cauwenberghe

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

package eu.mindspark.fhdl;

import java.util.ArrayList;
import java.util.Stack;

import org.antlr.v4.runtime.misc.NotNull;

import eu.mindspark.fhdl.*;
import eu.mindspark.fhdl.AstNode.AstNodeType;

class AstGenVisitor extends fhdlBaseVisitor <AstNode> {
	
	Stack<AstNode> upperNode = new Stack<AstNode>();
	
	public AstNode visitEntity_declaration(@NotNull fhdlParser.Entity_declarationContext ctx) {
		AstNode entityNode = new AstNode(AstNode.AstNodeType.AST_ENTITY, "ENT_"+ctx.IDENTIFIER().getText());
		visit (ctx.entity_header());
		Fhdl.astNetlist.addChild (entityNode);
		return entityNode;
	}
	
	public AstNode visitArchitecture_body(@NotNull fhdlParser.Architecture_bodyContext ctx) {
		String archName = "ARCH_" + ctx.name().getText()+ "_" +ctx.IDENTIFIER().getText();
		AstNode archNode = new AstNode(AstNode.AstNodeType.AST_ARCHITECTURE, archName);
		upperNode.push(archNode);
		visit (ctx.architecture_declarative_part());
		visit (ctx.architecture_statement_part());
		upperNode.pop();
		Fhdl.astNetlist.addChild (archNode);
		return archNode;
	}
	
	public AstNode visitProcess_statement(fhdlParser.Process_statementContext ctx) {
		AstNode processNode = null;
		processNode = new AstNode (AstNode.AstNodeType.AST_PROCESS, ctx.label(0));
		upperNode.push(processNode);
		visit (ctx.process_declarative_part());
		visit (ctx.process_statement_part());
		upperNode.pop();
		upperNode.peek().addChild(processNode);
		return processNode;
	}
	
	public AstNode visitWait_statement(fhdlParser.Wait_statementContext ctx) {
		AstNode waitNode = new AstNode(AstNode.AstNodeType.AST_WAIT, ctx.label());
		upperNode.peek().addChild(waitNode);
		return waitNode;
	}
	
	public AstNode visitSignal_assignment_statement(fhdlParser.Signal_assignment_statementContext ctx) {
		AstNode sigAssign = new AstNode (AstNode.AstNodeType.AST_SIGNAL_ASSIGN, ctx.label());
		upperNode.peek().addChild(sigAssign);
		return sigAssign;
	}
		
	public AstNode visitVariable_assignment_statement(fhdlParser.Variable_assignment_statementContext ctx) {
		AstNode varAssign = new AstNode (AstNode.AstNodeType.AST_VAR_ASSIGN, ctx.label());
		upperNode.peek().addChild(varAssign);
		return varAssign;
	}
	
	public AstNode visitIf_statement(fhdlParser.If_statementContext ctx) {
		AstNode ifNode = new AstNode (AstNode.AstNodeType.AST_IF, ctx.label(0));
		upperNode.peek().addChild(ifNode);
		return ifNode;
	}
	
	public AstNode visitCase_statement(fhdlParser.Case_statementContext ctx) {
		AstNode caseNode = new AstNode (AstNode.AstNodeType.AST_CASE, ctx.label(0));
		upperNode.peek().addChild(caseNode);
		return caseNode;
	}
	
	public AstNode visitLoop_statement(fhdlParser.Loop_statementContext ctx) {
		AstNode loopNode = new AstNode (AstNode.AstNodeType.AST_LOOP, ctx.label(0));
		upperNode.peek().addChild(loopNode);
		return loopNode;
	}
	
	public AstNode visitNext_statement(fhdlParser.Next_statementContext ctx) {
		AstNode nextNode = new AstNode (AstNode.AstNodeType.AST_NEXT, ctx.label(0));
		return nextNode;
	}
	
	public AstNode visitExit_statement(fhdlParser.Exit_statementContext ctx) {
		AstNode exitNode = new AstNode (AstNode.AstNodeType.AST_EXIT, ctx.label(0));
		return exitNode;
	}
	
	public AstNode visitReturn_statement(fhdlParser.Return_statementContext ctx) {
		AstNode returnNode = new AstNode (AstNode.AstNodeType.AST_RETURN, ctx.label());
		return returnNode;
	}
	
	public AstNode visitNull_statement(fhdlParser.Null_statementContext ctx) {
		AstNode nullNode = new AstNode (AstNode.AstNodeType.AST_NULL);
		return nullNode;
	}
	
	/*
	public AstNode visitInterface_list(@NotNull fhdlParser.Interface_listContext ctx) {
		System.out.println("InterfaceList");
		return visitChildren(ctx);
	}

	public AstNode visitInterface_declaration(@NotNull fhdlParser.Interface_declarationContext ctx) {
		System.out.println("Interface element");
		return visitChildren(ctx);
	}
	*/
	
}
