/*
 * To change this template, choose Tools | Templates
 * AND OPEN the template IN the editor.
 */

grammar fhdl;

/*
r0
    : r1 (QM | DOT)?;

r1
    : HI SPACE PLANET
    | HI HI PLANET
    ;

HI: 'hello';
PLANET: 'world';
SPACE: ' ';
QM: '!';
DOT: '.';
INT : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ; 
*/

WS : [ \t\r\n]+ -> skip ; 

// single characters delimiters:
// & ' ( ) * + , - . / : ; < = > |[]
CONCAT: '&';
SQUOTE: '\'';
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

// two chars delimiters:
// => ** := /= >= <= <>
ARROW:  '=>';
EXPO:   '**';
VARASGN: ':=';
NEQ:    '/=';
GTEQ:   '>=';
LTEQ:   '<=';
BOX:    '<>'; //box? diamond!

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
RANGE: 'range';
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



/*
TODO:

replace [ ] WITH LSB and RSB
replace ( ) WITH LPAREN and RPAREN
replace { } WITH ()? or ?

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

abstract_literal 
  : decimal_literal
  | based_literal
  ;

access_type_definition 
  : ACCESS subtype_indication
  ;

actual_designator
  : expression
  | signal_name
  | variable_name
  | file_name
  | OPEN
  ;

actual_parameter_part
  : parameter_association_list
  ;

actual_part
  : actual_designator
  | function_name LPAREN actual_designator RPAREN
  | type_mark LPAREN actual_designator RPAREN
  ;

adding_operator
  : PLUS
  | MINUS
  | CONCAT
  ;


aggregate
  : LPAREN element_association ( COMMA element_association )* RPAREN
  ;


alias_declaration 
  : ALIAS alias_designator ( COLON subtype_indication )? IS name signature? SEMICOLON
  ;

alias_designator 
  : identifier 
  | character_literal 
  | operator_symbol
  ;


allocator 
  : NEW subtype_indication
  | NEW qualified_expression
  ;

architecture_body 
  : ARCHITECTURE identifier OF entity_name IS
    architecture_declarative_part
    BEGIN architecture_statement_part 
    END ARCHITECTURE? /*architecture_*/simple_name? SEMICOLON
  ;


architecture_declarative_part :
block_declarative_item*
;


architecture_statement_part :
concurrent_statement*
;


array_type_definition :
unconstrained_array_definition | constrained_array_definition
;


assertion :
ASSERT condition
( REPORT expression )?
( SEVERITY expression )?
;


assertion_statement : ( label COLON )? assertion SEMICOLON
;


association_element :
( formal_part ARROW )? actual_part
;


association_list :
association_element ( COMMA association_element )*
;


attribute_declaration :
ATTRIBUTE identifier COLON type_mark SEMICOLON
;


attribute_designator : attribute_simple_name
;


attribute_name :
prefix ( signature )? ' attribute_designator ( LPAREN expression RPAREN )?
;


attribute_specification :
ATTRIBUTE attribute_designator OF entity_specification IS expression SEMICOLON
;


base : integer
;


base_specifier : B | O | X
;


base_unit_declaration : identifier SEMICOLON
;


based_integer : extended_digit ( underline? extended_digit )*
;


based_literal : base # based_integer ( . based_integer )? # exponent?
;


basic_character :
basic_graphic_character | format_effector
;


basic_graphic_character :
upper_case_letter | digit | special_character| space_character
;


basic_identifier : letter ( underline? letter_or_digit )*

binding_indication :
( USE entity_aspect )?
( generic_map_aspect )?
( port_map_aspect )?
;

bit_string_literal : base_specifier " bit_value? "
;


bit_value : extended_digit ( underline? extended_digit )*
;


block_configuration :
FOR block_specification
use_clause*
configuration_item*
END FOR SEMICOLON
;


block_declarative_item :
subprogram_declaration
| subprogram_body
| type_declaration
| subtype_declaration
| constant_declaration
| signal_declaration
| shared_variable_declaration
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


block_declarative_part :
block_declarative_item*
;


block_header : 
( generic_clause
( generic_map_aspect SEMICOLON )? )?
( port_clause
( port_map_aspect SEMICOLON )? )?
;


block_specification :
architecture_name
| /*block_statement_*/label
| /*generate_statement_*/label ( LPAREN index_specification RPAREN )?
;


block_statement :
/*block_*/label COLON
BLOCK ( LPAREN guard_expression RPAREN )? IS?
block_header
block_declarative_part
BEGIN
block_statement_part
END BLOCK /*block_*/label? SEMICOLON
;


block_statement_part :
concurrent_statement*
;


case_statement :
( /*case_*/label COLON )?
CASE expression IS
case_statement_alternative
case_statement_alternative*
END CASE /*case_*/label? SEMICOLON
;


case_statement_alternative :
WHEN choices ARROW
sequence_of_statements
;


character_literal : ' graphic_character '
;


choice :
simple_expression
| discrete_range
| element_simple_name
| OTHERS
;


choices : choice ( | choice )*
;


component_configuration :
FOR component_specification
( binding_indication SEMICOLON )?
block_configuration?
END FOR SEMICOLON
;


component_declaration :
COMPONENT identifier IS?
local_generic_clause?
local_port_clause?
END COMPONENT component_simple_name? SEMICOLON
;


component_instantiation_statement :
/*instantiation_*/label COLON
instantiated_unit
generic_map_aspect?
port_map_aspect? SEMICOLON
;


component_specification :
instantiation_list COLON component_name
;


composite_type_definition :
array_type_definition
| record_type_definition
;


concurrent_assertion_statement :
( label COLON )? POSTPONED? assertion SEMICOLON
;


concurrent_procedure_call_statement :
( label COLON )? POSTPONED? procedure_call SEMICOLON
;


concurrent_signal_assignment_statement :
( label COLON )? POSTPONED? conditional_signal_assignment
| ( label COLON )? POSTPONED? selected_signal_assignment
;


concurrent_statement :
block_statement
| process_statement
| concurrent_procedure_call_statement
| concurrent_assertion_statement
| concurrent_signal_assignment_statement
| component_instantiation_statement
| generate_statement
;


condition : boolean_expression
;


condition_clause : UNTIL condition
;


conditional_signal_assignment :
target LTEQ options conditional_waveforms SEMICOLON
;


conditional_waveforms :
( waveform WHEN condition ELSE )*
waveform ( WHEN condition )?
;


configuration_declaration :
CONFIGURATION identifier OF entity_name IS
configuration_declarative_part
block_configuration
END CONFIGURATION? configuration_simple_name? SEMICOLON
;


configuration_declarative_item :
use_clause
| attribute_specification
| group_declaration
;


configuration_declarative_part :
configuration_declarative_item*
;


configuration_item :
block_configuration
| component_configuration
;

configuration_specification :
FOR component_specification binding_indication SEMICOLON
;

constant_declaration :
CONSTANT identifier_list COLON subtype_indication ( VARASGN expression )? SEMICOLON
;

constrained_array_definition :
ARRAY index_constraint OF element_subtype_indication
;


constraint :
range_constraint
| index_constraint
context_clause : context_item*
;


context_item :
library_clause
| use_clause
;


decimal_literal : integer ( . integer )? exponent?
;

declaration :
type_declaration
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


delay_mechanism :
TRANSPORT
| ( REJECT time_expression )? INERTIAL
;


design_file : design_unit design_unit*
;


design_unit : context_clause library_unit
;


designator : identifier | operator_symbol
;


direction : TO | DOWNTO
;


disconnection_specification :
DISCONNECT guarded_signal_specification AFTER time_expression SEMICOLON
;


discrete_range : discrete_subtype_indication | RANGE
;


element_association :
( choices ARROW )? expression
;


element_declaration :
identifier_list COLON element_subtype_definition SEMICOLON
;


element_subtype_definition : subtype_indication
;


entity_aspect :
ENTITY entity_name ( LPAREN architecture_identifier RPAREN )?
| CONFIGURATION configuration_name
| OPEN
;


entity_class :
ENTITY
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


entity_class_entry : entity_class LTGT?
;


entity_class_entry_list :
entity_class_entry ( COMMA entity_class_entry )*
;


entity_declaration :
ENTITY identifier IS
entity_header
entity_declarative_part
( BEGIN
entity_statement_part )?
END ENTITY? entity_simple_name? SEMICOLON
;


entity_declarative_item :
subprogram_declaration
| subprogram_body
| type_declaration
| subtype_declaration
| constant_declaration
| signal_declaration
| shared_variable_declaration
| file_declaration
| alias_declaration
| attribute_declaration
| attribute_specification
| disconnection_specification
| use_clause
| group_template_declaration
| group_declaration
;


entity_declarative_part :
entity_declarative_item*
;


entity_designator : entity_tag signature?
;


entity_header : 
formal_generic_clause?
formal_port_clause?
entity_name_list :
entity_designator ( COMMA entity_designator )*
| OTHERS
| ALL
;


entity_specification :
entity_name_list COLON entity_class
;


entity_statement :
concurrent_assertion_statement
| passive_concurrent_procedure_call_statement
| passive_process_statement
;


entity_statement_part :
entity_statement*
;


entity_tag : simple_name | character_literal | operator_symbol
;


enumeration_literal : identifier | character_literal
;


enumeration_type_definition :
LPAREN enumeration_literal ( COMMA enumeration_literal )* RPAREN
;


exit_statement :
( label COLON )? EXIT /*loop_*/label? ( WHEN condition )? SEMICOLON
;


exponent : E PLUS? integer | E MINUS integer
;


expression :
relation ( AND relation )*
| relation ( OR relation )*
| relation ( XOR relation )*
| relation ( NAND relation )?
| relation ( NOR relation )?
| relation ( XNOR relation )*
;


extended_digit : digit | letter
;


extended_identifier : \ graphic_character graphic_character* \
;


factor :
primary ( EXPO primary )?
| ABS primary
| NOT primary
;


file_declaration :
FILE identifier_list COLON subtype_indication file_open_information? SEMICOLON
;


file_logical_name : string_expression
;


file_open_information :
( OPEN file_open_kind_expression )? IS file_logical_name
;


file_type_definition :
FILE OF type_mark
;


floating_type_definition : range_constraint
;


formal_designator :
generic_name
| port_name
| parameter_name
;


formal_parameter_list : parameter_interface_list
;


formal_part :
formal_designator
| function_name LPAREN formal_designator RPAREN
| type_mark LPAREN formal_designator RPAREN
;


full_type_declaration :
TYPE identifier IS type_definition SEMICOLON
;


function_call :
function_name ( LPAREN actual_parameter_part RPAREN )?
;


generate_statement :
/*generate_*/label COLON
generation_scheme GENERATE
( block_declarative_item*
BEGIN )?
concurrent_statement*
END GENERATE /*generate_*/label? SEMICOLON
;


generation_scheme :
FOR generate_parameter_specification
| IF condition
;


generic_clause :
GENERIC LPAREN generic_list RPAREN SEMICOLON
;


generic_list : generic_interface_list
;


generic_map_aspect :
GENERIC MAP LPAREN generic_association_list RPAREN
;


graphic_character :
basic_graphic_character | lower_case_letter | other_special_character
;


group_constituent : name | character_literal
;


group_constituent_list : group_constituent ( COMMA group_constituent )*
;


group_declaration :
GROUP identifier COLON group_template_name LPAREN group_constituent_list RPAREN SEMICOLON
;


group_template_declaration :
GROUP identifier IS LPAREN entity_class_entry_list RPAREN SEMICOLON
;


guarded_signal_specification :
guarded_signal_list COLON type_mark
;


identifier : basic_identifier | extended_identifier
;


identifier_list : identifier ( COMMA identifier )*
;


if_statement :
( /*if_*/label COLON )?
IF condition THEN
sequence_of_statements
( ELSIF condition THEN
sequence_of_statements )*
( ELSE
sequence_of_statements )?
END IF /*if_*/label? SEMICOLON
;


incomplete_type_declaration : TYPE identifier SEMICOLON
;


index_constraint : LPAREN discrete_range ( COMMA discrete_range )* RPAREN
;


index_specification :
discrete_range
| static_expression
;


index_subtype_definition : type_mark RANGE LTGT
;


indexed_name : prefix LPAREN expression ( COMMA expression )* RPAREN
;


instantiated_unit :
COMPONENT? component_name
| ENTITY entity_name ( LPAREN architecture_identifier RPAREN )?
| CONFIGURATION configuration_name
;


instantiation_list :
/*instantiation_*/label ( COMMA /*instantiation_*/label )*
| OTHERS
| ALL
;


integer : digit ( underline? digit )*
;


integer_type_definition : range_constraint
;


interface_constant_declaration :
CONSTANT? identifier_list COLON IN? subtype_indication ( VARASGN static_expression )?
;


interface_declaration :
interface_constant_declaration
| interface_signal_declaration
| interface_variable_declaration
| interface_file_declaration
;


interface_element : interface_declaration
;


interface_file_declaration :
FILE identifier_list COLON subtype_indication
;


interface_list :
interface_element ( SEMICOLON interface_element )*
;


interface_signal_declaration :
SIGNAL? identifier_list COLON mode? subtype_indication BUS? ( VARASGN static_expression )?
;


interface_variable_declaration :
VARIABLE? identifier_list COLON mode? subtype_indication ( VARASGN static_expression )?
;


iteration_scheme :
WHILE condition
| FOR loop_parameter_specification
;


label : identifier
;


letter : upper_case_letter | lower_case_letter
;


letter_or_digit : letter | digit
;


library_clause : LIBRARY logical_name_list SEMICOLON
;


library_unit :
primary_unit
| secondary_unit
;


LITERAL :
numeric_literal
| enumeration_literal
| string_literal
| bit_string_literal
| NULL
;


logical_name : identifier
;


logical_name_list : logical_name ( COMMA logical_name )*
;


logical_operator : AND | OR | NAND | NOR | XOR | XNOR
;


loop_statement :
( /*loop_*/label COLON )?
( iteration_scheme )? LOOP
sequence_of_statements
END LOOP /*loop_*/label? SEMICOLON
;


miscellaneous_operator : EXPO | ABS | NOT
;


mode : IN | OUT | INOUT | BUFFER | LINKAGE
;


multiplying_operator : * | / | MOD | REM
;


name :
simple_name
| operator_symbol
| selected_name
| indexed_name
| slice_name
| attribute_name
;


next_statement :
( label COLON )? NEXT /*loop_*/label? ( WHEN condition )? SEMICOLON
;


null_statement : ( label COLON )? NULL SEMICOLON
;


numeric_literal :
abstract_literal
| physical_literal
;


object_declaration :
constant_declaration
| signal_declaration
| variable_declaration
| file_declaration
;


operator_symbol : string_literal
;


options : GUARDED? delay_mechanism?
;


package_body :
PACKAGE BODY package_simple_name IS
package_body_declarative_part
END ( PACKAGE BODY )? package_simple_name? SEMICOLON
;


package_body_declarative_item :
subprogram_declaration
| subprogram_body
| type_declaration
| subtype_declaration
| constant_declaration
| shared_variable_declaration
| file_declaration
| alias_declaration
| use_clause
| group_template_declaration
| group_declaration
;


package_body_declarative_part :
package_body_declarative_item*
;


package_declaration :
PACKAGE identifier IS
package_declarative_part
END PACKAGE? package_simple_name? SEMICOLON
;


package_declarative_item :
subprogram_declaration
| type_declaration
| subtype_declaration
| constant_declaration
| signal_declaration
| shared_variable_declaration
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


package_declarative_part :
package_declarative_item*
;


parameter_specification :
identifier IN discrete_range
;


physical_literal : abstract_literal? unit_name
;


physical_type_definition :
range_constraint
UNITS
base_unit_declaration
secondary_unit_declaration*
END UNITS ( physical_type_simple_name )?
;


port_clause :
PORT LPAREN port_list RPAREN SEMICOLON
;


port_list : port_interface_list
;


port_map_aspect :
PORT MAP LPAREN port_association_list RPAREN
;


prefix :
name
| function_call
;


primary :
name
| LITERAL
| aggregate
| function_call
| qualified_expression
| type_conversion
| allocator
| LPAREN expression RPAREN
;


primary_unit :
entity_declaration
| configuration_declaration
| package_declaration
;


procedure_call : procedure_name ( LPAREN actual_parameter_part RPAREN )?
;


procedure_call_statement : ( label COLON )? procedure_call SEMICOLON
;


process_declarative_item :
subprogram_declaration
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


process_declarative_part :
process_declarative_item*
;


process_statement :
( /*process_*/label COLON )?
POSTPONED? PROCESS ( LPAREN sensitivity_list RPAREN )? IS?
process_declarative_part
BEGIN
process_statement_part
END POSTPONED? PROCESS /*process_*/label? SEMICOLON
;


process_statement_part :
sequential_statement*
;


qualified_expression :
type_mark ' LPAREN expression RPAREN
| type_mark ' aggregate
;


RANGE :
range_attribute_name
| simple_expression direction simple_expression
;


range_constraint : RANGE RANGE
;


record_type_definition :
RECORD
element_declaration
element_declaration*
END RECORD ( record_type_simple_name );
;


relation :
shift_expression ( relational_operator shift_expression )?
;


relational_operator : EQ | NEQ | LT | LTEQ | GT | GTEQ
;


report_statement :
( label COLON )?
REPORT expression
( SEVERITY expression )? SEMICOLON
;


return_statement :
( label COLON )? RETURN expression? SEMICOLON
;


scalar_type_definition :
enumeration_type_definition | integer_type_definition
| floating_type_definition
| physical_type_definition
;


secondary_unit :
architecture_body
| package_body
;


secondary_unit_declaration : identifier EQ physical_literal SEMICOLON
;


selected_name : prefix . suffix
;


selected_signal_assignment :
WITH expression SELECT
target LTEQ options selected_waveforms SEMICOLON
;


selected_waveforms :
( waveform WHEN choices COMMA )*
waveform WHEN choices
;


sensitivity_clause : ON sensitivity_list
;


sensitivity_list : signal_name ( COMMA signal_name )*
;


sequence_of_statements :
sequential_statement*
;


sequential_statement :
wait_statement
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


shift_expression :
simple_expression ( shift_operator simple_expression )?;
;


shift_operator : SLL | SRL | SLA | SRA | ROL | ROR
;


sign : PLUS | MINUS
;


signal_assignment_statement :
( label COLON )? target LTEQ delay_mechanism? waveform SEMICOLON
;


signal_declaration :
SIGNAL identifier_list COLON subtype_indication signal_kind? ( VARASGN expression )? SEMICOLON
;


signal_kind : REGISTER | BUS
;


signal_list :
signal_name ( COMMA signal_name )*
| OTHERS
| ALL
;


signature : ( ( type_mark ( COMMA type_mark )* )? ( RETURN type_mark )? )?
;


simple_expression :
sign? term ( adding_operator term )*
;


simple_name : identifier
;


slice_name : prefix LPAREN discrete_range RPAREN
;


string_literal : " graphic_character* "
;


subprogram_body :
subprogram_specification IS
subprogram_declarative_part
BEGIN
subprogram_statement_part
END subprogram_kind? designator? SEMICOLON
;


subprogram_declaration :
subprogram_specification SEMICOLON
;


subprogram_declarative_item :
subprogram_declaration
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


subprogram_declarative_part :
subprogram_declarative_item*
;


subprogram_kind : PROCEDURE | FUNCTION
;


subprogram_specification :
PROCEDURE designator ( LPAREN formal_parameter_list RPAREN )?
| ( PURE | IMPURE )? FUNCTION designator ( LPAREN formal_parameter_list RPAREN )?
RETURN type_mark
;


subprogram_statement_part :
sequential_statement*
;


subtype_declaration :
SUBTYPE identifier IS subtype_indication SEMICOLON
;


subtype_indication :
resolution_function_name? type_mark constraint?
;


suffix :
simple_name
| character_literal
| operator_symbol
| ALL
;


target :
name
| aggregate
;


term :
factor ( multiplying_operator factor )*
;


timeout_clause : FOR time_expression
;


type_conversion : type_mark LPAREN expression RPAREN
;


type_declaration :
full_type_declaration
| incomplete_type_declaration
;


type_definition :
scalar_type_definition
| composite_type_definition
| access_type_definition
| file_type_definition
;


type_mark :
type_name
| subtype_name
;


unconstrained_array_definition :
ARRAY LPAREN index_subtype_definition ( COMMA index_subtype_definition )* RPAREN
OF element_subtype_indication
;


use_clause :
USE selected_name ( COMMA selected_name )* SEMICOLON
;


variable_assignment_statement :
( label COLON )? target VARASGN expression SEMICOLON
variable_declaration :
SHARED? VARIABLE identifier_list COLON subtype_indication ( VARASGN expression )? SEMICOLON
;


wait_statement :
( label COLON )? WAIT sensitivity_clause? condition_clause? timeout_clause? SEMICOLON
;


waveform :
waveform_element ( COMMA waveform_element )*
| UNAFFECTED
;


waveform_element :
value_expression ( AFTER time_expression )?
| NULL ( AFTER time_expression )?
;

