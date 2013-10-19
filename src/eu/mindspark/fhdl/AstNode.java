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
import java.util.List;

import eu.mindspark.fhdl.Fhdl;

public class AstNode {
	protected AstNodeType nodeType;
	protected String nodeName = "";
	
	List<AstNode> children;
	
	static public enum AstNodeType {
		AST_NULLNODE, AST_NETLIST, AST_ENTITY, AST_ARCHITECTURE
	};
	
	public AstNode (AstNodeType thisNodeType) {
		nodeType = thisNodeType;
	}
	
	public AstNode (AstNodeType thisNodeType, String name) {
		nodeType = thisNodeType;
		if (name != null)
			nodeName = name;
	}
	
	public void addChild (AstNode node) {
		if (children == null) children = new ArrayList<AstNode>();
		children.add(node);
	}
	
	public boolean isNull () {
		return nodeType == AstNodeType.AST_NULLNODE;
	}
	
	public String toString () {
		if (nodeName != "") 
			return nodeType.toString() + " " + nodeName;
		else
			return nodeType.toString();
	}
	
	public String toStringTree () {
		if (children == null || children.size() == 0) {
			return "(" + toString() + ")";
		}
		StringBuilder buf = new StringBuilder();
		if (! isNull()) {
			buf.append("(");
			buf.append(this.toString());
			buf.append(" ");
		}
		for (AstNode child : children) {
			buf.append(child.toStringTree() + " ");
		}
		if (! isNull()) {
			buf.append(")");
		}
		return buf.toString();
	}
	
	public String toStringTreeOneLine () {
		return this.toStringTreeOneLine(0);
	}
	
	public String toStringTreeOneLine (Integer level) {
		if (children == null || children.size() == 0) {
			String spaces = "";
			for (int i = 0; i < level; i++)
				spaces = spaces + "  ";
			return spaces + toString() + "\n";
		}
		StringBuilder buf = new StringBuilder();
		if (! isNull()) {
			String spaces = "";
			for (int i = 0; i < level; i++)
				spaces = spaces + "  ";
			buf.append(spaces + this.toString()+"\n");
		}
		for (AstNode child : children) {
			buf.append(child.toStringTreeOneLine(level+1));
		}
		return buf.toString();
	}	
	
}