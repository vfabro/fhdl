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

import org.antlr.v4.runtime.misc.NotNull;

import eu.mindspark.fhdl.*;

class AstGenVisitor extends fhdlBaseVisitor <AstNode> {
	public AstNode visitEntity_declaration(@NotNull fhdlParser.Entity_declarationContext ctx) {
		AstNode entityNode = new AstNode(AstNode.AstNodeType.AST_ENTITY, "ENT_"+ctx.IDENTIFIER().getText());
		visit (ctx.entity_header());
		Fhdl.astNetlist.addChild (entityNode);
		return entityNode;
	}
	
	public AstNode visitArchitecture_body(@NotNull fhdlParser.Architecture_bodyContext ctx) {
		String archName = "ARCH_" + ctx.name().getText()+ "_" +ctx.IDENTIFIER().getText();
		AstNode archNode = new AstNode(AstNode.AstNodeType.AST_ARCHITECTURE, archName);
		Fhdl.astNetlist.addChild (archNode);
		return archNode;
	}
	
	public AstNode visitInterface_list(@NotNull fhdlParser.Interface_listContext ctx) {
		System.out.println("InterfaceList");
		return visitChildren(ctx);
	}

	public AstNode visitInterface_declaration(@NotNull fhdlParser.Interface_declarationContext ctx) {
		System.out.println("Interface element");
		return visitChildren(ctx);
	}
	
}
