/*
*****NOTES*****

For special unicode caracters:
In ANTLR 3, you can use the ANTLRInputStream constructor that takes an ancoding as a parameter:
ANTLRInputStream (InputStream input, String encoding) throws IOException


TODO: the following set of rules are mutually left-recursive: name, prefix, function_call, selected_name, indexed_name, slice_name, attribute_name

 */

grammar fhdl;

@headers{
 package eu.mindspark.fhdl;
}

//WS : [ \t\r\n]+ -> skip ;
NEWLINE:'\r'? '\n' -> skip ;     // return newlines to parser (is end-statement signal)
WS  :   [ \t]+ -> skip ;         // toss out whitespace

AMPERSAND: '&'; // An ampersand (or epershand; "
fragment FRAG_SQUOTE: '\'';
SQUOTE: FRAG_SQUOTE;
fragment DQUOTE: '"';
LPAREN: '(';
RPAREN: ')';
STAR:   '*';
PLUS:   '+';
COMMA:  ',';
MINUS:  '-';
DOT:    '.';
SLASH:  '/';
COLON:  ':';
SEMICOLON: ';';
LT:     '<';
EQ:     '=';
GT:     '>';
PIPE:   '|';
LSB:    '['; //LSB for left square bracket. We an find a better name
RSB:    ']'; //RSB for right square bracket. We an find a better name

HASHSIGN: '#';
BACKSLASH:'\\';

// two chars delimiters:
// => ** := /= >= <= <>
ARROW:  '=>';
EXPO:   '**';
VARASGN: ':=';
NEQ:    '/=';
GTEQ:   '>=';
LTEQ:   '<=';
BOX:    '<>'; //box? diamond!

fragment UNDERLINE: '_';


// reserved keywords

ABS: 'abs';
ACCESS: 'access';
AFTER: 'after';
ALIAS: 'alias';
ALL: 'all';
AND: 'and';
ARCHITECTURE: 'architecture';
ARRAY: 'array';
ASSERT: 'assert';
ATTRIBUTE: 'attribute';
BEGIN: 'begin';
BLOCK: 'block';
BODY: 'body';
BUFFER: 'buffer';
BUS: 'bus';
CASE: 'case';
COMPONENT: 'component';
CONFIGURATION: 'configuration';
CONSTANT: 'constant';
DISCONNECT: 'disconnect';
DOWNTO: 'downto';
ELSE: 'else';
ELSIF: 'elsif';
END: 'end';
ENTITY: 'entity';
EXIT: 'exit';
FILE: 'file';
FOR: 'for';
FUNCTION: 'function';
GENERATE: 'generate';
GENERIC: 'generic';
GROUP: 'group';
GUARDED: 'guarded';
IF: 'if';
IMPURE: 'impure';
IN: 'in';
INERTIAL: 'inertial';
INOUT: 'inout';
IS: 'is';
LABEL_KW: 'label';
LIBRARY: 'library';
LINKAGE: 'linkage';
LITERAL: 'literal';
LOOP: 'loop';
MAP: 'map';
MOD: 'mod';
NAND: 'nand';
NEW: 'new';
NEXT: 'next';
NOR: 'nor';
NOT: 'not';
NULL: 'null';
OF: 'of';
ON: 'on';
OPEN: 'open';
OR: 'or';
OTHERS: 'others';
OUT: 'out';
PACKAGE: 'package';
PORT: 'port';
POSTPONED: 'postponed';
PROCEDURE: 'procedure';
PROCESS: 'process';
PURE: 'pure';
RANGE_KW: 'range';
RECORD: 'record';
REGISTER: 'register';
REJECT: 'reject';
REM: 'rem';
REPORT: 'report';
RETURN: 'return';
ROL: 'rol';
ROR: 'ror';
SELECT: 'select';
SEVERITY: 'severity';
SHARED: 'shared';
SIGNAL: 'signal';
SLA: 'sla';
SLL: 'sll';
SRA: 'sra';
SRL: 'srl';
SUBTYPE: 'subtype';
THEN: 'then';
TO: 'to';
TRANSPORT: 'transport';
TYPE: 'type';
UNAFFECTED: 'unaffected';
UNITS: 'units';
UNTIL: 'until';
USE: 'use';
VARIABLE: 'variable';
WAIT: 'wait';
WHEN: 'when';
WHILE: 'while';
WITH: 'with';
XNOR: 'xnor';
XOR: 'xor';


fragment LC_LETTER  : [a-z];
fragment UC_LETTER  : [A-Z];
fragment DIGIT      : [0-9];

fragment UPPER_CASE_LETTER: UC_LETTER;
fragment LOWER_CASE_LETTER: LC_LETTER;

//Other special characters ! $ % @ ? \ ^ ` { } ~ Á ¢ £ Û  ́ || ¤ ¬ © » Ç Â - ̈ ø ¡ ± 2 3 « μ ¦ ¥ ü 1 1⁄4 È 1/4 1/2 3/4 À  ́  ̧ - (soft hyphen)
//TODO: other characters were not understood by antlrworks, so they are set 
// aside on another text file waiting for their correct UTF-8 encoding 
OTHER_SPECIAL_CHARACTER
  : [!$%@?\^`{}~¢£́ ¤¬©»-̈ø¡±²³«μ¦¥ ü ́ ̧ -]
  ;

UPPERCASE_LETTER
  : UC_LETTER //| [ËçåÌ€•®éƒæè] << utf8 '\u011'
  //| 'í'|'ê'|'ë'|'ì'|'D'|„|'ñ'|'î'|'ï'|'Í'|'̄'|'ô'|'ò'|'ó'|†|'Y'
  ;

ABSTRACT_LITERAL //PO
  : DECIMAL_LITERAL
  | BASED_LITERAL
  ;

//base
//  : INTEGER
//  ; 

fragment BASED_INTEGER // LO
  : EXTENDED_DIGIT ( UNDERLINE? EXTENDED_DIGIT )*
  ;

fragment BASED_LITERAL //LO
  : /*base*/ INTEGER HASHSIGN BASED_INTEGER ( . BASED_INTEGER )? HASHSIGN EXPONENT?
  ;

fragment BASIC_GRAPHIC_CHARACTER
  : UPPER_CASE_LETTER 
  | DIGIT 
  // | SPECIAL_CHARACTER 
  ;

//TODO Tab is ASCII '\011'
//TODO Format effectors are the ISO (and ASCII) characters called horizontal tabulation, vertical tabulation, carriage return, line feed, and form feed.
fragment FORMAT_EFFECTOR
  : [\t] 
  ;

//basic_character
//  : BASIC_GRAPHIC_CHARACTER | FORMAT_EFFECTOR
//  ;

fragment BASIC_IDENTIFIER
  : LETTER ( UNDERLINE? LETTER_OR_DIGIT )*
  ;

BIT_STRING_LITERAL
  : /*base_specifier*/ [BOX] DQUOTE BIT_VALUE? DQUOTE
  ;

/*base_specifier
  : 'B'
  | 'O'
  | 'X'
  ;*/

fragment BIT_VALUE //LO
  : EXTENDED_DIGIT ( UNDERLINE? EXTENDED_DIGIT )*
  ;

//PO
CHARACTER_LITERAL
  : FRAG_SQUOTE GRAPHIC_CHARACTER FRAG_SQUOTE
  ;

fragment DECIMAL_LITERAL //LO
  : INTEGER ( DOT INTEGER )? EXPONENT?
  ;

fragment EXPONENT //LO
  : 'E' PLUS? INTEGER
  | 'E' MINUS INTEGER
  ;

fragment EXTENDED_DIGIT //LO
  : DIGIT
  | LETTER
  ;

fragment EXTENDED_IDENTIFIER
  : BACKSLASH GRAPHIC_CHARACTER+ BACKSLASH
  ;

fragment GRAPHIC_CHARACTER
  : BASIC_GRAPHIC_CHARACTER
  | LOWER_CASE_LETTER
  | OTHER_SPECIAL_CHARACTER
  ;

IDENTIFIER
  : ( BASIC_IDENTIFIER | EXTENDED_IDENTIFIER )+
  ;

fragment INTEGER
  : DIGIT INTEGER_UNDERLINE_DIGIT*
  ;

fragment INTEGER_UNDERLINE_DIGIT //added for INTEGER
  : UNDERLINE? DIGIT
  ;

LETTER
  : UPPER_CASE_LETTER
  | LOWER_CASE_LETTER
  ;

LETTER_OR_DIGIT
  : LETTER
  | DIGIT
  ;

STRING_LITERAL 
  : DQUOTE GRAPHIC_CHARACTER* DQUOTE
  ;


//d) The space characters
//SPACE1 NBSP 
// Format effectors are the ISO (and ASCII) characters called horizontal tabulation, vertical tabulation, carriage
//return, line feed, and form feed.
// The visual representation of the space is the absence of a graphic symbol. It may be interpreted as a graphic character, a control character, or both.
// The visual representation of the nonbreaking space is the absence of a graphic symbol. It is used when a line break is to be prevented in the text as presented.

//abcdefghijklmnopqrstuvwxyz§ˆ‡‰‹ŠŒ3⁄4••Ž•‘“’”•¶ – ̃—TM«›š¿•œžŸyp Ø


// single characters delimiters:
// & ' ( ) * + , - . / : ; < = > |[]
//Special characters
//" # & ' () * + , - . / : ; < = > [ ] _ |

// TODO: needed for BASIC_GRAPHIC_CHARACTER
//SPECIAL_CHARACTER
//  : 
//  ;


/*
p174 -> keywords as names !!! twisted to implement

If a backslash is to be used as one of the graphic characters of an extended literal, it must be doubled. All
characters of an extended identifier are significant (a doubled backslash counting as one character). Extended
identifiers differing only in the use of corresponding uppercase and lowercase letters are distinct. Moreover,
every extended identifier is distinct from any basic identifier.
Examples:
\BUS\
\bus\
-- Two different identifiers, neither of which is
-- the reserved word bus.
175
\a\\b\
VHDL
-- An identifier containing three characters.
\VHDL\
\vhdl\
-- Three distinct identifiers.

*/


/* LRM IEEE Std 1076-1993 1.1 */
entity_declaration
  : ENTITY IDENTIFIER IS
      entity_header
      entity_declarative_part
    ( BEGIN entity_statement_part )?
      END ENTITY? /*entity_*/simple_name? SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 1.1.1 */
entity_header
  : /*formal_*/generic_clause?
    /*formal_*/port_clause?
  ;

generic_clause
  : GENERIC LPAREN generic_list RPAREN SEMICOLON
  ;

port_clause
  : PORT LPAREN port_list RPAREN SEMICOLON
  ;

generic_list
  : /*generic_*/interface_list
  ;

port_list
  : /*port_*/interface_list
  ;


/* LRM IEEE Std 1076-1993 1.1.2 */
entity_declarative_part
  : entity_declarative_item*
  ;

entity_declarative_item
  : subprogram_declaration
  | subprogram_body
  | type_declaration
  | subtype_declaration
  | constant_declaration
  | signal_declaration
  | /*shared_*/variable_declaration
  | file_declaration
  | alias_declaration
  | attribute_declaration
  | attribute_specification
  | disconnection_specification
  | use_clause
  | group_template_declaration
  | group_declaration
  ;


/* LRM IEEE Std 1076-1993 1.1.3 */
entity_statement_part
  : entity_statement*
  ;

entity_statement
  : concurrent_assertion_statement
  | /*passive_*/concurrent_procedure_call_statement
  | /*passive_*/process_statement
  ;


/* LRM IEEE Std 1076-1993 1.2 */
architecture_body
  : ARCHITECTURE IDENTIFIER OF /*entity_*/name IS
      architecture_declarative_part
    BEGIN
      architecture_statement_part
    END ARCHITECTURE? /*architecture_*/simple_name? SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 1.2.1 */
architecture_declarative_part
  : block_declarative_item*
  ;

block_declarative_item
  : subprogram_declaration
  | subprogram_body
  | type_declaration
  | subtype_declaration
  | constant_declaration
  | signal_declaration
  | /*shared_*/variable_declaration
  | file_declaration
  | alias_declaration
  | component_declaration
  | attribute_declaration
  | attribute_specification
  | configuration_specification
  | disconnection_specification
  | use_clause
  | group_template_declaration
  | group_declaration
  ;


/* LRM IEEE Std 1076-1993 1.2.2 */
architecture_statement_part
  : concurrent_statement*
  ;


/* LRM IEEE Std 1076-1993 1.3 */
configuration_declaration
  : CONFIGURATION IDENTIFIER OF /*entity_*/name IS
      configuration_declarative_part
      block_configuration
    END CONFIGURATION? /*configuration_*/simple_name? SEMICOLON
  ;

configuration_declarative_part
  : configuration_declarative_item*
  ;

configuration_declarative_item
  : use_clause
  | attribute_specification
  | group_declaration
  ;


/* LRM IEEE Std 1076-1993 1.3.1 */
block_configuration
  : FOR block_specification
      use_clause*
      configuration_item*
    END FOR SEMICOLON
  ;

block_specification
  : /*architecture_*/name
  | /*block_statement_*/label
  | /*generate_statement_*/label ( LPAREN index_specification RPAREN )?
  ;

index_specification
  : discrete_range
  | /*static_*/expression
  ;

configuration_item
  : block_configuration
  | component_configuration
  ;


/* LRM IEEE Std 1076-1993 1.3.2 */
component_configuration
  : FOR component_specification
     ( binding_indication SEMICOLON )?
     block_configuration?
    END FOR SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 2.1 */
subprogram_declaration
  : subprogram_specification SEMICOLON
  ;

subprogram_specification
  : PROCEDURE designator ( LPAREN formal_parameter_list RPAREN )?
  | ( PURE | IMPURE )? FUNCTION designator ( LPAREN formal_parameter_list RPAREN )?
    RETURN type_mark
  ;

designator
  : IDENTIFIER
  | operator_symbol
  ;

operator_symbol
  : STRING_LITERAL
  ;


/* LRM IEEE Std 1076-1993 2.1.1 */
formal_parameter_list
  : /*parameter_*/interface_list
  ;


/* LRM IEEE Std 1076-1993 2.2 */
subprogram_body
  : subprogram_specification IS
      subprogram_declarative_part
    BEGIN
      subprogram_statement_part
    END subprogram_kind? designator? SEMICOLON
  ;

subprogram_declarative_part
  : subprogram_declarative_item*
  ;

subprogram_declarative_item
  : subprogram_declaration
  | subprogram_body
  | type_declaration
  | subtype_declaration
  | constant_declaration
  | variable_declaration
  | file_declaration
  | alias_declaration
  | attribute_declaration
  | attribute_specification
  | use_clause
  | group_template_declaration
  | group_declaration
  ;

subprogram_statement_part
  : sequential_statement*
  ;

subprogram_kind
  : PROCEDURE
  | FUNCTION
  ;


/* LRM IEEE Std 1076-1993 2.3.2 */
signature
  : ( ( type_mark ( COMMA type_mark )* )? ( RETURN type_mark )? )?
  ;


/* LRM IEEE Std 1076-1993 2.5 */
package_declaration
  : PACKAGE IDENTIFIER IS
      package_declarative_part
    END PACKAGE? /*package_*/simple_name? SEMICOLON
  ;

package_declarative_part
  : package_declarative_item*
  ;

package_declarative_item
  : subprogram_declaration
  | type_declaration
  | subtype_declaration
  | constant_declaration
  | signal_declaration
  | /*shared_*/variable_declaration
  | file_declaration
  | alias_declaration
  | component_declaration
  | attribute_declaration
  | attribute_specification
  | disconnection_specification
  | use_clause
  | group_template_declaration
  | group_declaration
  ;


/* LRM IEEE Std 1076-1993 2.6 */
package_body
  : PACKAGE BODY /*package_*/simple_name IS
      package_body_declarative_part
    END ( PACKAGE BODY )? /*package_*/simple_name? SEMICOLON
  ;

package_body_declarative_part
  : package_body_declarative_item*
  ;

package_body_declarative_item
  : subprogram_declaration
  | subprogram_body
  | type_declaration
  | subtype_declaration
  | constant_declaration
  | /*shared_*/variable_declaration
  | file_declaration
  | alias_declaration
  | use_clause
  | group_template_declaration
  | group_declaration
  ;


/* LRM IEEE Std 1076-1993 3.1 */
scalar_type_definition
  : enumeration_type_definition
  | integer_type_definition
  | floating_type_definition
  | physical_type_definition
  ;

range_constraint
  : RANGE_KW range
  ;

range
  : /*range_*/attribute_name
  | simple_expression direction simple_expression
  ;

direction
  : TO
  | DOWNTO
  ;


/* LRM IEEE Std 1076-1993 3.1.1 */
enumeration_type_definition
  : LPAREN enumeration_literal ( COMMA enumeration_literal )* RPAREN
  ;

enumeration_literal
  : IDENTIFIER
  | CHARACTER_LITERAL
  ;


/* LRM IEEE Std 1076-1993 3.1.2 */
integer_type_definition
  : range_constraint
  ;


/* LRM IEEE Std 1076-1993 3.1.3 */
physical_type_definition
  : range_constraint
      UNITS
        base_unit_declaration
        secondary_unit_declaration*
      END UNITS ( /*physical_type_*/simple_name )?
  ;

base_unit_declaration
  : IDENTIFIER SEMICOLON // Weird: semicolon might be removed
  ;

secondary_unit_declaration
  : IDENTIFIER EQ physical_literal SEMICOLON
  ;

physical_literal
  : ABSTRACT_LITERAL? /*unit_*/name
  ;


/* LRM IEEE Std 1076-1993 3.1.4 */
floating_type_definition
  : range_constraint
  ;


/* LRM IEEE Std 1076-1993 3.2 */
composite_type_definition
  : array_type_definition
  | record_type_definition
  ;


/* LRM IEEE Std 1076-1993 3.2.1 */
array_type_definition
  : unconstrained_array_definition
  | constrained_array_definition
  ;

unconstrained_array_definition
  : ARRAY LPAREN index_subtype_definition ( COMMA index_subtype_definition )* RPAREN
    OF /*element_*/subtype_indication
  ;

constrained_array_definition
  : ARRAY index_constraint OF /*element_*/subtype_indication
  ;

index_subtype_definition
  : type_mark RANGE_KW BOX
  ;

index_constraint
  : LPAREN discrete_range ( COMMA discrete_range )* RPAREN
  ;

discrete_range
  : /*discrete_*/subtype_indication
  | range
  ;


/* LRM IEEE Std 1076-1993 3.2.2 */
record_type_definition
  : RECORD
      element_declaration
      element_declaration*
    END RECORD /*record_type_*/simple_name?
  ;

element_declaration
  : identifier_list COLON element_subtype_definition SEMICOLON
  ;

identifier_list
  : IDENTIFIER ( COMMA IDENTIFIER )*
  ;

element_subtype_definition
  : subtype_indication
  ;


/* LRM IEEE Std 1076-1993 3.3 */
access_type_definition
  : ACCESS subtype_indication
  ;


/* LRM IEEE Std 1076-1993 3.3.1 */
incomplete_type_declaration
  : TYPE IDENTIFIER SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 3.4 */
file_type_definition
  : FILE OF type_mark
  ;


/* LRM IEEE Std 1076-1993 4 */
declaration
  : type_declaration
  | subtype_declaration
  | object_declaration
  | interface_declaration
  | alias_declaration
  | attribute_declaration
  | component_declaration
  | group_template_declaration
  | group_declaration
  | entity_declaration
  | configuration_declaration
  | subprogram_declaration
  | package_declaration
  ;


/* LRM IEEE Std 1076-1993 4.1 */
type_declaration
  : full_type_declaration
  | incomplete_type_declaration
  ;

full_type_declaration
  : TYPE IDENTIFIER IS type_definition SEMICOLON
  ;

type_definition
  : scalar_type_definition
  | composite_type_definition
  | access_type_definition
  | file_type_definition
  ;


/* LRM IEEE Std 1076-1993 4.2 */
subtype_declaration
  : SUBTYPE IDENTIFIER IS subtype_indication SEMICOLON
  ;

subtype_indication
  : /*resolution_function_*/name? type_mark constraint?
  ;

type_mark
  : /*type_*/name
/*
  | /*subtype_/*name
*/
  ;

constraint
  : range_constraint
  | index_constraint
  ;


/* LRM IEEE Std 1076-1993 4.3.1 */
object_declaration
  : constant_declaration
  | signal_declaration
  | variable_declaration
  | file_declaration
  ;

constant_declaration
  : CONSTANT identifier_list COLON subtype_indication ( VARASGN expression )? SEMICOLON
  ;

signal_declaration
  : SIGNAL identifier_list COLON subtype_indication signal_kind? ( VARASGN expression )? SEMICOLON
  ;

signal_kind
  : REGISTER
  | BUS
  ;

variable_declaration
  : SHARED? VARIABLE identifier_list COLON subtype_indication ( VARASGN expression )? SEMICOLON
  ;

file_declaration
  : FILE identifier_list COLON subtype_indication file_open_information? SEMICOLON
  ;

file_logical_name
  : /*string_*/expression
  ;

file_open_information
  : ( OPEN /*file_open_kind_*/expression )? IS file_logical_name
  ;


/* LRM IEEE Std 1076-1993 4.3.2 */
interface_declaration
  : interface_constant_declaration
  | interface_signal_declaration
  | interface_variable_declaration
  | interface_file_declaration
  ;

interface_constant_declaration
  : CONSTANT? identifier_list COLON IN? subtype_indication ( VARASGN /*static_*/expression )?
  ;

interface_signal_declaration
  : SIGNAL? identifier_list COLON modee? subtype_indication BUS? ( VARASGN /*static_*/expression )?
  ;

interface_variable_declaration
  : VARIABLE? identifier_list COLON modee? subtype_indication ( VARASGN /*static_*/expression )?
  ;

interface_file_declaration
  : FILE identifier_list COLON subtype_indication
  ;

modee // mode caused antlrworks to misunderstand 
  : IN
  | OUT
  | INOUT
  | BUFFER
  | LINKAGE
  ;

/* LRM IEEE Std 1076-1993 4.3.2.1 */
interface_list
  : interface_element ( SEMICOLON interface_element )*
  ;

interface_element
  : interface_declaration
  ;


/* LRM IEEE Std 1076-1993 4.3.2.2 */
association_list
  : association_element ( COMMA association_element )*
  ;

association_element
  : ( formal_part ARROW )? actual_part
  ;

formal_part
  : formal_designator
  | /*function_*/name LPAREN formal_designator RPAREN
  | type_mark LPAREN formal_designator RPAREN
  ;

formal_designator
  : /*generic_*/name
  //| /*port_*/name
  //| /*parameter_*/name
  ;

actual_part
  : actual_designator
  | /*function_*/name LPAREN actual_designator RPAREN
  | type_mark LPAREN actual_designator RPAREN
  ;

actual_designator
  : expression
  | /*signal_*/name
//  | /*variable_*/name
//  | /*file_*/name
  | OPEN
  ;


/* LRM IEEE Std 1076-1993 4.3.3 */
alias_declaration
  : ALIAS alias_designator ( COLON subtype_indication )? IS name signature? SEMICOLON
  ;

alias_designator
  : IDENTIFIER
  | CHARACTER_LITERAL
  | operator_symbol
  ;


/* LRM IEEE Std 1076-1993 4.4 */
attribute_declaration
  : ATTRIBUTE IDENTIFIER COLON type_mark SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 4.5 */
component_declaration
  : COMPONENT IDENTIFIER IS?
      /*local_*/generic_clause?
      /*local_*/port_clause?
    END COMPONENT /*component_*/simple_name? SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 4.6 */
group_template_declaration
  : GROUP IDENTIFIER IS LPAREN entity_class_entry_list RPAREN SEMICOLON
  ;

entity_class_entry_list
  : entity_class_entry ( COMMA entity_class_entry )*
  ;

entity_class_entry
  : entity_class BOX?
  ;


/* LRM IEEE Std 1076-1993 4.7 */
group_declaration
  : GROUP IDENTIFIER COLON /*group_template_*/name LPAREN group_constituent_list RPAREN SEMICOLON
  ;

group_constituent_list
  : group_constituent ( COMMA group_constituent )*
  ;

group_constituent
  : name
  | CHARACTER_LITERAL
  ;


/* LRM IEEE Std 1076-1993 5.1 */
attribute_specification
  : ATTRIBUTE attribute_designator OF entity_specification IS expression SEMICOLON
  ;

entity_specification
  : entity_name_list COLON entity_class
  ;

entity_class
  : ENTITY
  | PROCEDURE
  | TYPE
  | SIGNAL
  | LABEL_KW
  | GROUP
  | ARCHITECTURE
  | FUNCTION
  | SUBTYPE
  | VARIABLE
  | LITERAL
  | FILE
  | CONFIGURATION
  | PACKAGE
  | CONSTANT
  | COMPONENT
  | UNITS
  ;

entity_name_list
  : entity_designator ( COMMA entity_designator )*
  | OTHERS
  | ALL
  ;

entity_designator
  : entity_tag signature?
  ;

entity_tag
  : simple_name
  | CHARACTER_LITERAL
  | operator_symbol
  ;


/* LRM IEEE Std 1076-1993 5.2 */
configuration_specification
  : FOR component_specification binding_indication SEMICOLON
  ;

component_specification
  : instantiation_list COLON /*component_*/name
  ;

instantiation_list
  : /*instantiation_*/label ( COMMA /*instantiation_*/label )*
  | OTHERS
  | ALL
  ;


/* LRM IEEE Std 1076-1993 5.2.1 */
binding_indication
  : ( USE entity_aspect )?
    generic_map_aspect?
    port_map_aspect?
  ;

entity_aspect
  : ENTITY /*entity_*/name ( LPAREN /*architecture_*/IDENTIFIER RPAREN )?
  | CONFIGURATION /*configuration_*/name
  | OPEN
  ;

generic_map_aspect
  : GENERIC MAP LPAREN /*generic_*/association_list RPAREN
  ;

port_map_aspect
  : PORT MAP LPAREN /*port_*/association_list RPAREN
  ;


/* LRM IEEE Std 1076-1993 5.3 */
disconnection_specification
  : DISCONNECT guarded_signal_specification AFTER /*time_*/expression SEMICOLON
  ;

guarded_signal_specification
  : /*guarded_*/signal_list COLON type_mark
  ;

signal_list
  : /*signal_*/name ( COMMA /*signal_*/name )*
  | OTHERS
  | ALL
  ;


/* LRM IEEE Std 1076-1993 6.1 */
name
  : simple_name
  | operator_symbol
  | name (LPAREN actual_parameter_part RPAREN )?            // name or function_call (prefix)
        ( DOT suffix                                        // selected_name
        | LPAREN expression ( COMMA expression )* RPAREN    // indexed_name
        | LPAREN discrete_range RPAREN                      // slice_name
        | ( signature )? SQUOTE attribute_designator ( LPAREN expression RPAREN )?  // attribute_name
        )
  ;

/* inlined into selected_name, indexed_name, slice_name, attribute_name */
prefix
  : name
  | function_call
  ;

/* LRM IEEE Std 1076-1993 6.2 */
simple_name
  : IDENTIFIER
  ;

/* LRM IEEE Std 1076-1993 6.3 */
/* inlined into name */
selected_name
  : prefix DOT suffix
  ;

suffix
  : simple_name
  | CHARACTER_LITERAL
  | operator_symbol
  | ALL
  ;

/* LRM IEEE Std 1076-1993 6.4 */
/* inlined into name */
//indexed_name
//  : prefix LPAREN expression ( COMMA expression )* RPAREN
//  ;

/* LRM IEEE Std 1076-1993 6.5 */
/* inlined into name */
//slice_name
//  : prefix LPAREN discrete_range RPAREN
//  ;

/* LRM IEEE Std 1076-1993 6.6 */
/* inlined into name */
attribute_name
  : prefix ( signature )? SQUOTE attribute_designator ( LPAREN expression RPAREN )?
  ;

attribute_designator
  : /*attribute_*/simple_name
  ;


/* LRM IEEE Std 1076-1993 7.1 */
expression
  : relation ( AND relation )*
  | relation ( OR relation )*
  | relation ( XOR relation )*
  | relation ( NAND relation )?
  | relation ( NOR relation )?
  | relation ( XNOR relation )*
  ;

relation
  : shift_expression ( relational_operator shift_expression )?
  ;

shift_expression
  : simple_expression ( shift_operator simple_expression )?
  ;

simple_expression
  : sign? term ( adding_operator term )*
  ;

term
  : factor ( multiplying_operator factor )*
  ;

factor
  : primary ( EXPO primary )?
  | ABS primary
  | NOT primary
  ;

primary
  : name
  | literal
  | aggregate
  | function_call
  | qualified_expression
  | type_conversion
  | allocator
  | LPAREN expression RPAREN
  ;


/* LRM IEEE Std 1076-1993 7.2 */
// logical_operator rule omitted: already embedded into expression rule

relational_operator
  : EQ
  | NEQ
  | LT
  | LTEQ
  | GT
  | GTEQ
  ;

shift_operator
  : SLL
  | SRL
  | SLA
  | SRA
  | ROL
  | ROR
  ;

adding_operator
  : PLUS
  | MINUS
  | AMPERSAND
  ;

sign
  : PLUS
  | MINUS
  ;

multiplying_operator
  : STAR
  | SLASH
  | MOD
  | REM
  ;

// miscellaneous_operator rule omitted: already embedded into factor rule


/* LRM IEEE Std 1076-1993 7.3 */
literal
  : numeric_literal
  | enumeration_literal
  | STRING_LITERAL
  | BIT_STRING_LITERAL
  | NULL
  ;

numeric_literal
  : ABSTRACT_LITERAL
  | physical_literal
  ;


/* LRM IEEE Std 1076-1993 7.3.2 */
aggregate
  : LPAREN element_association ( COMMA element_association )* RPAREN
  ;

element_association
  : ( choices ARROW )? expression
  ;

choices
  : choice (PIPE choice )*
  ;

choice
  : simple_expression
  | discrete_range
  | /*element_*/simple_name
  | OTHERS
  ;

/* LRM IEEE Std 1076-1993 7.3.3 */
/* inlined into rule "name" */
function_call
  : /*function_*/name ( LPAREN actual_parameter_part RPAREN )?
  ;

actual_parameter_part
  : /*parameter_*/association_list
  ;


/* LRM IEEE Std 1076-1993 7.3.4 */
qualified_expression
  : type_mark SQUOTE LPAREN expression RPAREN
  | type_mark SQUOTE aggregate
  ;


/* LRM IEEE Std 1076-1993 7.3.5 */
type_conversion
  : type_mark LPAREN expression RPAREN
  ;


/* LRM IEEE Std 1076-1993 7.3.6 */
allocator
  : NEW subtype_indication
  | NEW qualified_expression
  ;


/* LRM IEEE Std 1076-1993 8 */
sequence_of_statements
  : sequential_statement*
  ;

sequential_statement
  : wait_statement
  | assertion_statement
  | report_statement
  | signal_assignment_statement
  | variable_assignment_statement
  | procedure_call_statement
  | if_statement
  | case_statement
  | loop_statement
  | next_statement
  | exit_statement
  | return_statement
  | null_statement
  ;


/* LRM IEEE Std 1076-1993 8.1 */
wait_statement
  : ( label COLON )? WAIT sensitivity_clause? condition_clause? timeout_clause? SEMICOLON
  ;

sensitivity_clause
  : ON sensitivity_list
  ;

sensitivity_list
  : /*signal_*/name ( COMMA /*signal_*/name )*
  ;

condition_clause
  : UNTIL condition
  ;

condition
  : /*boolean_*/expression
  ;

timeout_clause
  : FOR /*time_*/expression
  ;


/* LRM IEEE Std 1076-1993 8.2 */
assertion_statement
  : ( label COLON )? assertion SEMICOLON
  ;

assertion
  : ASSERT condition
    ( REPORT expression )?
    ( SEVERITY expression )?
  ;


/* LRM IEEE Std 1076-1993 8.3 */
report_statement
  : ( label COLON )?
      REPORT expression
      ( SEVERITY expression )? SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 8.4 */
signal_assignment_statement
  : ( label COLON )? target LTEQ delay_mechanism? waveform SEMICOLON
  ;

delay_mechanism
  : TRANSPORT
  | ( REJECT /*time_*/expression )? INERTIAL
  ;

target
  : name
  | aggregate
  ;

waveform
  : waveform_element ( COMMA waveform_element )*
  | UNAFFECTED
  ;


/* LRM IEEE Std 1076-1993 8.4.1 */
waveform_element
  : /*value_*/expression ( AFTER /*time_*/expression )?
  | NULL ( AFTER /*time_*/expression )?
  ;


/* LRM IEEE Std 1076-1993 8.5 */
variable_assignment_statement
  : ( label COLON )? target VARASGN expression SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 8.6 */
procedure_call_statement
  : ( label COLON )? procedure_call SEMICOLON
  ;

procedure_call
  : /*procedure_*/name ( LPAREN actual_parameter_part RPAREN )?
  ;


/* LRM IEEE Std 1076-1993 8.7 */
if_statement
  : ( /*if_*/label COLON )?
    IF condition THEN
      sequence_of_statements
      ( ELSIF condition THEN
          sequence_of_statements )*
      ( ELSE
          sequence_of_statements )?
      END IF /*if_*/label? SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 8.8 */
case_statement
  : ( /*case_*/label COLON )?
    CASE expression IS
      case_statement_alternative
      case_statement_alternative*
    END CASE /*case_*/label? SEMICOLON
  ;

case_statement_alternative
  : WHEN choices ARROW
    sequence_of_statements
  ;


/* LRM IEEE Std 1076-1993 8.9 */
loop_statement
  : ( /*loop_*/label COLON )?
    iteration_scheme? LOOP
      sequence_of_statements
    END LOOP /*loop_*/label? SEMICOLON
  ;

iteration_scheme
  : WHILE condition
  | FOR /*loop_*/parameter_specification
  ;

parameter_specification
  : IDENTIFIER IN discrete_range
  ;


/* LRM IEEE Std 1076-1993 8.10 */
next_statement
  : ( label COLON )? NEXT /*loop_*/label? ( WHEN condition )? SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 8.11 */
exit_statement
  : ( label COLON )? EXIT /*loop_*/label? ( WHEN condition )? SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 8.12 */
return_statement
  : ( label COLON )? RETURN expression? SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 8.13 */
null_statement
  : ( label COLON )? NULL SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 9 */
concurrent_statement
  : block_statement
  | process_statement
  | concurrent_procedure_call_statement
  | concurrent_assertion_statement
  | concurrent_signal_assignment_statement
  | component_instantiation_statement
  | generate_statement
  ;


/* LRM IEEE Std 1076-1993 9.1 */
block_statement
  : /*block_*/label COLON BLOCK ( LPAREN /*guard_*/expression RPAREN )? IS?
        block_header
        block_declarative_part
      BEGIN
        block_statement_part
      END BLOCK /*block_*/label? SEMICOLON
  ;

block_header
  : ( generic_clause
    ( generic_map_aspect SEMICOLON )? )?
    ( port_clause
    ( port_map_aspect SEMICOLON )? )?
  ;

block_declarative_part
  : block_declarative_item*
  ;

block_statement_part
  : concurrent_statement*
  ;


/* LRM IEEE Std 1076-1993 9.2 */
process_statement
  : ( /*process_*/label COLON )?
      POSTPONED? PROCESS ( LPAREN sensitivity_list RPAREN )? IS?
        process_declarative_part
      BEGIN
        process_statement_part
      END POSTPONED? PROCESS /*process_*/label? SEMICOLON
  ;

process_declarative_part
  : process_declarative_item*
  ;

process_declarative_item
  : subprogram_declaration
  | subprogram_body
  | type_declaration
  | subtype_declaration
  | constant_declaration
  | variable_declaration
  | file_declaration
  | alias_declaration
  | attribute_declaration
  | attribute_specification
  | use_clause
  | group_template_declaration
  | group_declaration
  ;

process_statement_part
  : sequential_statement*
  ;


/* LRM IEEE Std 1076-1993 9.3 */
concurrent_procedure_call_statement
  : ( label COLON )? POSTPONED? procedure_call SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 9.4 */
concurrent_assertion_statement
  : ( label COLON )? POSTPONED? assertion SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 9.5 */
concurrent_signal_assignment_statement
  : ( label COLON )? POSTPONED? conditional_signal_assignment
  | ( label COLON )? POSTPONED? selected_signal_assignment
  ;

optionz //just as mode, it seems it gets angry with antlrworks2
  : GUARDED? delay_mechanism?
  ;


/* LRM IEEE Std 1076-1993 9.5.1 */
conditional_signal_assignment
  : target LTEQ optionz conditional_waveforms SEMICOLON
  ;

conditional_waveforms
  : ( waveform WHEN condition ELSE )* waveform ( WHEN condition )?
  ;

/* LRM IEEE Std 1076-1993 9.5.2 */
selected_signal_assignment
  : WITH expression SELECT target LTEQ optionz selected_waveforms SEMICOLON
  ;

selected_waveforms
  : ( waveform WHEN choices COMMA )* waveform WHEN choices
  ;


/* LRM IEEE Std 1076-1993 9.6 */
component_instantiation_statement
  : /*instantiation_*/label COLON
      instantiated_unit
        generic_map_aspect?
        port_map_aspect? SEMICOLON
  ;

instantiated_unit
  : COMPONENT? /*component_*/name
  | ENTITY /*entity_*/name ( LPAREN /*architecture_*/IDENTIFIER RPAREN )?
  | CONFIGURATION /*configuration_*/name
  ;


/* LRM IEEE Std 1076-1993 9.6 */
generate_statement
  : /*generate_*/label COLON
      generation_scheme GENERATE
        ( block_declarative_item* BEGIN )?
        concurrent_statement*
    END GENERATE /*generate_*/label? SEMICOLON
  ;

generation_scheme
  : FOR /*generate_*/parameter_specification
  | IF condition
  ;

label
  : IDENTIFIER
  ;


/* LRM IEEE Std 1076-1993 10.4 */
use_clause
  : USE selected_name ( COMMA selected_name )* SEMICOLON
  ;


/* LRM IEEE Std 1076-1993 11.1 */
design_file /* GRAMMAR ENTRY RULE */
  : design_unit design_unit*
  ;

design_unit
  : context_clause library_unit
  ;

library_unit
  : primary_unit
  | secondary_unit
  ;

primary_unit
  : entity_declaration
  | configuration_declaration
  | package_declaration
  ;

secondary_unit
  : architecture_body
  | package_body
  ;


/* LRM IEEE Std 1076-1993 11.2 */
library_clause
  : LIBRARY logical_name_list SEMICOLON
  ;

logical_name_list
  : logical_name ( COMMA logical_name )*
  ;

logical_name
  : IDENTIFIER
  ;


/* LRM IEEE Std 1076-1993 11.3 */
context_clause
  : context_item*
  ;

context_item
  : library_clause
  | use_clause
  ;

