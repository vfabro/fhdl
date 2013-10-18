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

import org.antlr.v4.runtime.misc.NotNull;

import eu.mindspark.fhdl.fhdlBaseListener;
import eu.mindspark.fhdl.fhdlParser;
import eu.mindspark.fhdl.fhdlParser.Configuration_declarationContext;

public class NameCheckListener extends fhdlBaseListener {
	boolean debugMode = false;
	
	public void error(String errorString) {
		System.out.println("[ERROR] " + errorString);
	}
	
	public void debug (String dbgString) {
		if (debugMode) {
			System.out.println("[DEBUG] " + dbgString);
		}
	}
	
	/* Check that the name at the beginning of the entity is the
	 * same as the one at the end (non-Javadoc)
	 * @see eu.mindspark.fhdl.fhdlBaseListener#exitEntity_declaration(eu.mindspark.fhdl.fhdlParser.Entity_declarationContext)
	 */
	public void exitEntity_declaration(@NotNull fhdlParser.Entity_declarationContext ctx) {
		debug ("Exit Entity declaration");
		if (ctx.simple_name() != null) {
			String entityName = ctx.IDENTIFIER().getText();
			String entityEndName = ctx.simple_name().getText();
			if (! entityName.equalsIgnoreCase(entityEndName)) {
				error ("Entity end name "+entityEndName + " does not match entity name "+entityName);
			}
		}
	}
	
	/* Check architecture name match */
	public void exitArchitecture_body(@NotNull fhdlParser.Architecture_bodyContext ctx) {
		debug ("Exit Architecture body");
		if (ctx.simple_name() != null) {
			String archName = ctx.IDENTIFIER().getText();
			String archEndName = ctx.simple_name().getText();
			if (! archName.equalsIgnoreCase(archEndName)) {
				error ("Architecture end name "+archEndName + " does not match architecture name "+archName);
			}
		}
	}
	
	/* Check configuration name match */
	public void exitConfiguration_declaration(@NotNull fhdlParser.Configuration_declarationContext ctx) {
		debug ("Exit Configuration declaration");
		if (ctx.simple_name() != null) {
			String configName = ctx.IDENTIFIER().getText();
			String configEndName = ctx.simple_name().getText();
			if (! configName.equalsIgnoreCase(configEndName)) {
				error ("Configuration end name "+configEndName + " does not match configuration name "+configName);
			}
		}
	}
	
	/* Check subprogram name match */
	public void exitSubprogram_body(@NotNull fhdlParser.Subprogram_bodyContext ctx) {
		debug ("Exit Subprogram body");
		if (ctx.designator() != null) {
			String subprogName = ctx.subprogram_specification().designator().getText();
			String subprogEndName = ctx.designator().getText();
			if (! subprogName.equalsIgnoreCase(subprogEndName)) {
				error ("Subprogram end name " + subprogEndName + " does not match subprogram name " + subprogName);
			}
		}
	}

	/* Check Package declaration */
	public void exitPackage_declaration(@NotNull fhdlParser.Package_declarationContext ctx) {
		debug ("Exit Package declaration");
		if (ctx.simple_name() != null) {
			String packDeclName = ctx.simple_name().getText();
			String packDeclEndName = ctx.IDENTIFIER().getText();
			if (! packDeclName.equalsIgnoreCase(packDeclEndName)) {
				error ("Package declaration end name " + packDeclEndName + " does not match package declaration " + packDeclName);
			}
		}
	}
	
	/* Check Package body */
	public void exitPackage_body(@NotNull fhdlParser.Package_bodyContext ctx) {
		debug ("Exit Package body");
		if (ctx.simple_name(1) != null) {
			String packBodyName = ctx.simple_name(0).getText();
			String packBodyEndName = ctx.simple_name(1).getText();
			if (! packBodyName.equalsIgnoreCase(packBodyEndName)) {
				error ("Package body end name " + packBodyEndName + " does not match package body " + packBodyName);
			}
		}
	}
	
	/* Check Component declaration */
	public void exitComponent_declaration(@NotNull fhdlParser.Component_declarationContext ctx) {
		debug ("Exit Component declaration");
		if (ctx.simple_name() != null) {
			String compName = ctx.simple_name().getText();
			String compEndName = ctx.IDENTIFIER().getText();
			if (! compName.equalsIgnoreCase(compEndName)) {
				error ("Component declaration end name " + compEndName + " does not match component declaration " + compName);
			}
		}
	}
	
	/* Check if statement */
	public void exitIf_statement(@NotNull fhdlParser.If_statementContext ctx) {
		debug ("Exit If statement");
		if (ctx.label(1) != null) { // Check if end label is present
			String ifEndName = ctx.label(1).getText();
			if (ctx.label(0) != null) {
				String ifName = ctx.label(0).getText();
				if (! ifName.equalsIgnoreCase(ifEndName)) {
					error ("If end label " + ifEndName + " does not match beginning label " + ifName);
				}	
			} else {
				error ("If end label " + ifEndName + " present but without beginning label");
			}
		}
	}
	
	/* Check case statement */
	public void exitCase_statement(@NotNull fhdlParser.Case_statementContext ctx) {
		debug ("Exit Case statement");
		if (ctx.label(1) != null) { // Check case end label is present
			String caseEndName = ctx.label(1).getText();
			if (ctx.label(0) != null) {
				String caseName = ctx.label(0).getText();
				if (! caseName.equalsIgnoreCase(caseEndName)) {
					error ("Case end label " + caseEndName + " does not match beginning label " + caseName);
				}	
			} else {
				error ("Case end label " + caseEndName + " present but without beginning label");
			}
		}
	}

	/* Check block statement */
	public void exitBlock_statement(@NotNull fhdlParser.Block_statementContext ctx) {
		debug ("Exit Block statement");
		if (ctx.label(1) != null) { // Check block end label is present
			String blockEndName = ctx.label(1).getText();
			if (ctx.label(0) != null) {
				String blockName = ctx.label(0).getText();
				if (! blockName.equalsIgnoreCase(blockEndName)) {
					error ("Block end label " + blockEndName + " does not match beginning label " + blockName);
				}	
			} else {
				error ("Block end label " + blockEndName + " present but without beginning label");
			}
		}
	}

	/* Check process statement */
	public void exitProcess_statement(@NotNull fhdlParser.Process_statementContext ctx) {
		debug ("Exit Process statement");
		if (ctx.label(1) != null) { // Check process end label is present
			String processEndName = ctx.label(1).getText();
			if (ctx.label(0) != null) {
				String processName = ctx.label(0).getText();
				if (! processName.equalsIgnoreCase(processEndName)) {
					error ("Process end label " + processEndName + " does not match beginning label " + processName);
				}	
			} else {
				error ("Process end label " + processEndName + " present but without beginning label");
			}
		}
	}

	/* Check generate statement */
	public void exitGenerate_statement(@NotNull fhdlParser.Generate_statementContext ctx) {
		debug ("Exit Generate statement");
		if (ctx.label(1) != null) { // Check generate end label is present
			String generateEndName = ctx.label(1).getText();
			if (ctx.label(0) != null) {
				String generateName = ctx.label(0).getText();
				if (! generateName.equalsIgnoreCase(generateEndName)) {
					error ("Generate end label " + generateEndName + " does not match beginning label " + generateName);
				}	
			} else {
				error ("Generate end label " + generateEndName + " present but without beginning label");
			}
		}
	}
	
}