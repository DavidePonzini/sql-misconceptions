%==========================================================================
% Project:	sqllint - A semantic checker for SQL queries
% Version:	0.3
% Module:	sqllint.pl
% Purpose:	Complete Prolog Source Code
% Last Change:	27.04.2005
% Language:	Prolog (tested under SWI Prolog)
% Authors:	Stefan Brass
% Email:	brass@acm.org
% Address:	Universitaet Halle, Inst.f.Informatik, 06099 Halle, Germany
% Copyright:	(c) 2004, 2005 by Stefan Brass
% Thanks to:	Christian Goldberg, who developed some of the error tests.
%           	Elvis Samson, who wrote an earlier version of this program.
% Copying:	Permitted under the GNU Public License
% Warrenties:	Absolutely no warrenties, the program might contain bugs!
%==========================================================================

% Current restrictions:
% --------------------
% - No GROUP BY, HAVING, UNION, ORDER BY, INTO
% - Only EXISTS subqueries (no IN, >= ALL, etc.)
% - All atomic formulas are comparisons
%	(Term Op Term, Op in =, <>, <, <=, >, >=)
%	No LIKE
% 	No IS NULL, IS NOT NULL
% - Only string and integer constants, no other numeric constants.
%	Column Types only CHAR, CHAR(N), VARCHAR(N), NUMERIC(N).
%	NUMBER and VARCHAR2 are accepted as synonyms for NUMERIC, VARCHAR.
% - Only PAD SPACE semantics for string comparisons.
% - No CHECK constraints
% - The program assumes that Prolog integer values are large enough
%	for all numeric constants.
% - We assume that the constraints are consistent.
% - Currently the constraints are not used in the consistency check.
% - Only Errors 1 and 8 use a consistency check, other error types are
%   treated with simpler non-exact algorithms.
% - The current prototype contains only checks for
%   Errors 1, 2, 3, 4, 5, 8, 26, 34, 39.

% In foreign key declarations, the compatibility of the data types is
% not checked.

%==========================================================================
% Main Program:
%==========================================================================

run :-
	nl,
	clean_db,
	current_input(InStream),
	command_loop(InStream, yes, no).

%==========================================================================
% Dynamic Database for Schema Data:
%==========================================================================

%--------------------------------------------------------------------------
% Dynamic Predicates:
%--------------------------------------------------------------------------

% relation(RelName, PKCols).

:- dynamic relation/2.

% column(RelName, ColName, Type, NotNull).

:- dynamic column/4.

% key(RelName, ColList, Type).

:- dynamic key/3.

% foreign_key(RelName, ColList, RefRel).

:- dynamic foreign_key/3.

% option(Option, Value).

:- dynamic option/2.

%--------------------------------------------------------------------------
% store_rel: Store relation name in dynamic database.
%--------------------------------------------------------------------------

% store_rel(+RelName, +PK):

store_rel(RelName, PK) :-
	assert(relation(RelName, PK)).

%--------------------------------------------------------------------------
% store_cols: Store column definitions in dynamic database.
%--------------------------------------------------------------------------

% store_cols(+RelName, +ColList):

store_cols(_, []).

store_cols(RelName, [col(ColName,Type,NotNull)|MoreCols]) :-
	assert(column(RelName, ColName, Type, NotNull)),
	store_cols(RelName, MoreCols).

%--------------------------------------------------------------------------
% store_constraints: Store constraint definitions in dynamic database.
%--------------------------------------------------------------------------

% store_constraints(+RelName, +ConstrList):

store_constraints(_, []).

store_constraints(RelName, [pkey(Cols)|MoreConstraints]) :-
	assert(key(RelName, Cols, primary)),
	store_constraints(RelName, MoreConstraints).

store_constraints(RelName, [key(Cols)|MoreConstraints]) :-
	assert(key(RelName, Cols, alternate)),
	store_constraints(RelName, MoreConstraints).

store_constraints(RelName, [skey(Cols)|MoreConstraints]) :-
	assert(key(RelName, Cols, soft)),
	store_constraints(RelName, MoreConstraints).

store_constraints(RelName, [ref(Cols,RefRel)|MoreConstraints]) :-
	assert(foreign_key(RelName, Cols, RefRel)),
	store_constraints(RelName, MoreConstraints).

%--------------------------------------------------------------------------
% clean_db: Remove all schema entries from the dynamic database.
%--------------------------------------------------------------------------

clean_db :-
	relation(RelName, PK),
	retract(relation(RelName,PK)),
	fail.

clean_db :-
	column(RelName, ColName, Type, NotNull),
	retract(column(RelName,ColName,Type,NotNull)),
	fail.

clean_db :-
	key(RelName, ColList, KeyType),
	retract(key(RelName,ColList,KeyType)),
	fail.

clean_db :-
	foreign_key(RelName, ColList, KeyType),
	retract(foreign_key(RelName,ColList,KeyType)),
	fail.

clean_db :-
	option(Option, Value),
	retract(option(Option,Value)),
	fail.

clean_db :-
	assert(option(echo_query,no)),
	assert(option(show_model,no)),
	assert(option(show_cons_check,no)).

%--------------------------------------------------------------------------
% set_option: Set an option.
%--------------------------------------------------------------------------

% set_option(+Option, +Value):

% Remove previous setting (if exists) (it should normally exist):
set_option(Option, _) :-
	option(Option, Value),
	retract(option(Option,Value)),
	fail.

% Store new setting:
set_option(Option, NewValue) :-
	assert(option(Option,NewValue)).

%--------------------------------------------------------------------------
% print_schema: Print all facts in the dynamic database.
%--------------------------------------------------------------------------

print_schema :-
	relation(_, _),
	!,
	print_nonempty_db.

print_schema :-
	writeln('Currently no relation is declared.').

% print_nonempty_db:

print_nonempty_db :-
	relation(RelName, PK),
	write('Relation: '),
	write(RelName),
	nl,
	print_columns(RelName),
	print_primary_key(PK),
	print_alternate_keys(RelName),
	print_soft_keys(RelName),
	print_foreign_keys(RelName),
	nl,
	fail.

print_nonempty_db.

% print_columns(+RelName):

print_columns(RelName) :-
	column(RelName, ColName, Type, NotNull),
	write('    Column:  '),
	write(ColName),
	write('\t '),
	write(Type),
	write(' '),
	print_not_null(NotNull),
	nl,
	fail.

print_columns(_).

% print_not_null(NotNull):

print_not_null(not_null) :-
	write('not null').

print_not_null(null) :-
	write('null').

% print_primary_key(+PK):

print_primary_key([]).

print_primary_key([Attr|MoreAttrs]) :-
	write('    Primary Key: '),
	write([Attr|MoreAttrs]),
	nl.

% print_alternate_keys(+Rel):

print_alternate_keys(Rel) :-
	key(Rel, Cols, alternate),
	write('    Alt. Key:    '),
	write(Cols),
	nl,
	fail.

print_alternate_keys(_).

% print_soft_keys(+Rel):

print_soft_keys(Rel) :-
	key(Rel, Cols, soft),
	write('    Soft Key:    '),
	write(Cols),
	nl,
	fail.

print_soft_keys(_).

% print_foreign_keys(+Rel):

print_foreign_keys(Rel) :-
	foreign_key(Rel, Cols, RefRel),
	write('    Foreign Key: '),
	write(Cols),
	write(' --> '),
	write(RefRel),
	nl,
	fail.

print_foreign_keys(_).

%==========================================================================
% Command Loop, Command Execution:
%==========================================================================

%--------------------------------------------------------------------------
% command_loop: The loop over the input commands.
%--------------------------------------------------------------------------

% command_loop(+InStream, +Prompt, +Stop):

command_loop(_, _, yes) :-
	!.

command_loop(InStream, Prompt, no) :-
	print_prompt(Prompt),
	get_char(InStream, CurrChar),
	read_input(InStream, CurrChar, CharList, EOF),
	exec_command(CharList, Prompt, Quit),
	stop(EOF, Quit, Stop),
	!,
	command_loop(InStream, Prompt, Stop).

% stop(+EOF, +Quit, -Stop):
% Disjunction: Stop is yes if one of EOF and Quit is yes.

stop(yes, yes, yes).
stop(yes, no,  yes).
stop(no,  yes, yes).
stop(no,  no,  no).

% print_prompt(+Prompt):

print_prompt(yes) :-
	write('SQLLINT> ').

print_prompt(no).

%--------------------------------------------------------------------------
% exec_command(+CharList, -Quit):
%--------------------------------------------------------------------------

% Execute command, continue command loop.

exec_command([], _, no) :-
	!.

exec_command(['-', '-'|_], _, no) :-
	% A comment, simply ignore rest of line.
	!.

exec_command(['?'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	print_help(yes).

exec_command(['$', 'h'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	print_help(yes).

exec_command(['$', 'v'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	print_version.

exec_command(['$', 'q'|CharList], _, yes) :-
	!,
	must_be_empty(CharList).

exec_command(['$', 'p'|CharList], _, no) :-
	!,
	skip_spaces(CharList, CharList1),
	exec_print(CharList1).

exec_command(['$', 'r'|CharList], _, no) :-
	!,
	skip_spaces(CharList, CharList1),
	get_filename(CharList1, FilenameChars, CharList2),
	must_be_empty(CharList2),
	atom_chars(FilenameAtom, FilenameChars),
	read_file(FilenameAtom).

exec_command(['$', 's'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	print_schema.

exec_command(['$', 'e', '+'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	set_option(echo_query, yes).

exec_command(['$', 'e', '-'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	set_option(echo_query, no).

exec_command(['$', 'e'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	option(echo_query, CurrentSetting),
	yes_no_compl(CurrentSetting, NewSetting),
	set_option(echo_query, NewSetting).

exec_command(['$', 'm', '+'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	set_option(show_model, yes).

exec_command(['$', 'm', '-'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	set_option(show_model, no).

exec_command(['$', 'm'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	option(show_model, CurrentSetting),
	yes_no_compl(CurrentSetting, NewSetting),
	set_option(show_model, NewSetting).

exec_command(['$', 'c', '+'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	set_option(show_cons_check, yes).

exec_command(['$', 'c', '-'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	set_option(show_cons_check, no).

exec_command(['$', 'c'|CharList], _, no) :-
	!,
	must_be_empty(CharList),
	option(show_cons_check, CurrentSetting),
	yes_no_compl(CurrentSetting, NewSetting),
	set_option(show_cons_check, NewSetting).

exec_command([Char|CharList], Prompt, no) :-
	letter(Char, _),
	!,
	process_sql([Char|CharList], Prompt).

exec_command(_, Prompt, no) :-
	writeln('Error: Unknown command'),
	print_help(Prompt).

%--------------------------------------------------------------------------
% skip_spaces: Remove whitespace from beginning of character list.
%--------------------------------------------------------------------------

% skip_spaces(+CharListIn, -CharListOut).

skip_spaces([Char|CharList], CharListOut) :-
	whitespace(Char),
	!,
	skip_spaces(CharList, CharListOut).

skip_spaces(CharList, CharList).

%--------------------------------------------------------------------------
% get_filename: Determine prefix of character list until first whitespace.
%--------------------------------------------------------------------------

% get_filename(+CharList, -Filename, -CharListRest).

get_filename([], [], []) :-
	!.

get_filename([Char|CharList], [], [Char|CharList]) :-
	whitespace(Char),
	!.

get_filename([Char|CharList], [Char|Filename], CharListRest) :-
	get_filename(CharList, Filename, CharListRest).

%--------------------------------------------------------------------------
% must_be_empty: Print warning if character list contains non-spaces (or ;)
%--------------------------------------------------------------------------

% must_be_empty(+CharList).

must_be_empty([]) :-
	!.

must_be_empty(['-','-'|_]) :-
	% A comment after the command, ok (extends to end of line).
	!.

must_be_empty([Char|CharList]) :-
	whitespace(Char),
	!,
	must_be_empty(CharList).

must_be_empty([';'|CharList]) :-
	!,
	must_be_empty(CharList).

must_be_empty(_) :-
	writeln('Warning: Illegal characters after command (ignored).').

%--------------------------------------------------------------------------
% exec_print: Execute Command $p.
%--------------------------------------------------------------------------

% exec_print(+Chars).

exec_print(['\''|Chars]) :-
	!,
	exec_print2(Chars).

exec_print(Chars) :-
	exec_print3(Chars).

% exec_print2(+Chars): Print '-delimited string:

exec_print2([]) :-
	nl,
	writeln('Warning: Closing \' misses in $p command.').

exec_print2(['\''|Rest]) :-
	!,
	nl,
	must_be_empty(Rest).

exec_print2([Char|Rest]) :-
	put_char(Char),
	exec_print2(Rest).

% exec_print3(+Chars): Print string without '-delimiters:

exec_print3([]) :-
	nl.

exec_print3([Char|Rest]) :-
	put_char(Char),
	exec_print3(Rest).

%--------------------------------------------------------------------------
% read_file: Read all SQL statements and commands from a file.
%--------------------------------------------------------------------------

% read_file(+FilenameAtom).

read_file(Filename) :-
	access_file(Filename, read), % Fails if file does not exist
	open(Filename, read, InStream), % Causes an exception in this case.
	read_file2(InStream),
	close(InStream),
	!.

read_file(Filename) :-
	write('Error: Cannot open file "'),
	write(Filename),
	writeln('".').

read_file2(InStream) :-
	command_loop(InStream, no, no).

read_file2(_) :-
	writeln('Error: Read file failed, check file contents.'),
	nl.

%--------------------------------------------------------------------------
% process_sql: Process an SQL query or CREATE TABLE.
%--------------------------------------------------------------------------

% process_sql(+CharList, +Prompt).

process_sql(CharList, Prompt) :-
	print_sql(CharList),
	scan(CharList, TokenList),
	%write('Tokens: '), write(TokenList), nl, % Debugging Output
	!,
	process_sql2(TokenList, Prompt).

process_sql(_) :-
	writeln('Lexical error: Scanner failed for input.').

% process_sql2(+TokenList):

process_sql2([select|TokenList], _) :-
	!,
	process_query([select|TokenList]).

process_sql2([create, table|TokenList], _) :-
	!,
	process_table_decl([create, table|TokenList]).

process_sql2(_, Prompt) :-
	writeln('Error: Unknown SQL command'),
	print_help(Prompt).

%--------------------------------------------------------------------------
% print_sql: Print the current SQL query if option "echo_query" is set.
%--------------------------------------------------------------------------

% print_sql(+CharList):

print_sql(CharList) :-
	option(echo_query, yes),
	!,
	print_charlist(CharList),
	nl.

print_sql(_).

% print_charlist(+CharList):

print_charlist([]) :-
	nl.

print_charlist([Char|CharList]) :-
	put_char(Char),
	print_charlist(CharList).

%--------------------------------------------------------------------------
% process_query: Process SQL query.
%--------------------------------------------------------------------------

% process_query(+TokenList).

process_query(TokenList) :-
	phrase(g_query(query(Select,From,Where,GroupBy,OrderBy)),TokenList),
	!,
	%write('SELECT: '), write(Select), nl, % Debugging Output
	%write('FROM: '), write(From), nl,
	%write('WHERE: '), write(Where), nl,
	%write('GROUP BY: '), write(GroupBy), nl,
	%write('ORDER BY: '), write(OrderBy), nl,
	%nl,
	process_query2(query(Select,From,Where,GroupBy,OrderBy)).

process_query(_) :-
	writeln('Syntax error: Not a valid SELECT query.').

% process_query2(+Query):

process_query2(query(Select,From,Where,_GroupBy,_OrderBy)) :-
	check_from_list(From),
	make_vars_explicit_select(Select, [From], NewSelect),
	%write('NEW SELECT:'), % Debugging Output
	%writeln(NewSelect),
	make_vars_explicit_cond(Where, [From], NewWhere1),
	make_tvars_unique(From, NewWhere1, NewWhere),
	%write('NEW WHERE:'), % Debugging Output
	%writeln(NewWhere),
	%write('Skolem:'), % Debugging Output
	%writeln(Skolem),
	eliminate_not(NewWhere, WhereNoNot),
	dnf(WhereNoNot, DNF),
	%write('DNF:'), % Debugging Output
	%writeln(DNF),
	cnf(WhereNoNot, CNF),
	semantic_check(NewSelect, From, NewWhere, DNF, CNF),
	!.

process_query2(_) :-
	writeln('Processing query failed.').

%--------------------------------------------------------------------------
% semantic_check: Perform check for semantic errors.
%--------------------------------------------------------------------------

semantic_check(Select, From, Where, DNF, CNF) :-
	% Error 39: Difficult Type Conversions.
	%writeln(check_err39(Where)),
	check_err39(Where),

	% Error 1: Inconsistent condition.
	%writeln(check_err1(From, Where)),
	check_err1(From, Where),

	% Error 2: Unnecessary DISTINCT
	%writeln(check_err2(Select, From, CNF)),
	check_err2(Select, From, CNF),

	% Error 3: Constant output column.
	%writeln(check_err3(Select, CNF)),
	check_err3(Select, CNF),

	% Error 4: Duplicate output column.
	%writeln(check_err4(Select, CNF)),
	check_err4(Select, CNF),

	% Error 5: Unused tuple variable.
	%writeln(check_err5(Select, From, Where)),
	check_err5(Select, From, Where),

	% Error 8: Implied, Tautological, or Inconsistent Subconditions.
	%writeln(check_err8(From, DNF)),
	check_err8(From, DNF),

	% Error 26: Missing Join Conditions.
	%writeln(check_err26(From, DNF)),
	check_err26(From, DNF),

	% Error 34: Many Duplicates.
	%writeln(check_err34(Select, From, DNF)),
	check_err34(Select, From, DNF),

	% Ok, no error found:
	writeln('Query has passed semantic checks.'),
	nl.

semantic_check(_, _, _, _, _).

%--------------------------------------------------------------------------
% process_table_decl: Process CREATE TABLE statement.
%--------------------------------------------------------------------------

% process_table_decl(+TokenList).

process_table_decl(TokenList) :-
	phrase(g_create_table(rdecl(Rel,ColList,ConstrList)), TokenList),
	!,
	%write('RELATION NAME: '), write(Rel), nl, % Debugging output
	%write('COL LIST: '), write(ColList), nl,
	%write('CONSTRAINTS: '), write(ConstrList), nl,
	%nl,
	store_schema(Rel, ColList, ConstrList).

process_table_decl(_) :-
	writeln('Syntax error: Not a valid CREATE TABLE statement.').

%--------------------------------------------------------------------------
% print_help: Conditionally print the help text.
%--------------------------------------------------------------------------

print_help(yes) :-
	nl,
	writeln('Please enter one of the following:'),
	writeln('    $q to leave this program (quit).'),
	writeln('    $h to print this help.'),
	write(  '    $v to print version information '),
	writeln('(current restrictions).'),
	writeln('    $r <filename> to read an input file.'),
	writeln('    $p <Text> or $p \'<Text>\' to print <Text>.'),
	writeln('    $s to show the current database schema.'),
	writeln('    $e , $e+, $e- to set the option "echo query".'),
	writeln('    $m , $m+, $m- to set the option "show model".'),
	write(  '    $c , $c+, $c- to set the option "show consistency '),
	writeln('check details".'),
	writeln('    An SQL query to be checked: SELECT ...'),
	writeln('    A table declaration: CREATE TABLE ...'),
	write(  'The SQL statements must be terminated with a semicolon '),
	writeln('\';\'.'),
	nl.

print_help(no).

%--------------------------------------------------------------------------
% print_version: Print version information (current restrictions).
%--------------------------------------------------------------------------

print_version :-
	nl,
	writeln('This is SQLLINT 0.3 from April 27, 2005.'),
	writeln('Version 0.4 is expected around May 30, 2005.'),
	write('Please check '),
	writeln('http://dbs.informatik.uni-halle.de/sqllint/'),
	nl,
	writeln('Current SQL Restrictions:'),
	writeln('-------------------------'),
	writeln('- No GROUP BY, HAVING, UNION, ORDER BY, INTO'),
	writeln('- Only EXISTS subqueries (no IN, >= ALL, etc.)'),
	writeln('- All atomic formulas are comparisons'),
	writeln('  (Term Op Term, Op in =, <>, <, <=, >, >=)'),
	writeln('  No LIKE'),
	writeln('  No IS NULL, IS NOT NULL'),
	write('- Only string and integer constants, '),
	writeln('no other numeric constants.'),
	write('  Column Types only '),
	writeln('CHAR, CHAR(N), VARCHAR(N), NUMERIC(N).'),
	write('  Oracle Synonyms VARCHAR2(N) and NUMBER(N) are '),
	writeln('accepted.'),
	writeln('- Only PAD SPACE semantics for string comparisons.'),
	writeln('- No CHECK constraints'),
	write('- The program assumes that Prolog integer values '),
	writeln('are large enough'),
	writeln('  for all numeric constants.'),
	writeln('- We assume that the constraints are consistent.'),
	writeln('- Constraints are not yet used in consistency tests.'),
	nl,
	write('This version contains checks for the following error '),
	writeln('types:'),
	write('-----------------------------------------------------'),
	writeln('------'),
	writeln(' 1: Inconsistent Conditions'),
	writeln(' 2: Unncessary DISTINCT'),
	writeln(' 3: Constant Output Columns'),
	writeln(' 4: Duplicate Output Columns'),
	writeln(' 5: Unused Tuple Variables'),
	writeln(' 8: Implied, Tautological, or Inconsistent Subconditions'),
	writeln('26: Missing Join Conditions'),
	writeln('34: Many Duplicates'),
	writeln('39: Difficult/Questionable Type Conversions'),
	write('(Currently, only checks for errors 1 and 8 are based on '),
	writeln('a consistency test.)'),
	nl.

%==========================================================================
% Functions for Reading Input Characters:
%==========================================================================

%--------------------------------------------------------------------------
% read_input: Read one command or an SQL statement.
%--------------------------------------------------------------------------

% read_input(+InStream, +CurrChar, -CharList, -EOF):

read_input(_, end_of_file, [], yes) :-
	!.

read_input(InStream, Char, Input, EOF) :-
	whitespace(Char),
	!,
	get_char(InStream, NextChar),
	read_input(InStream, NextChar, Input, EOF).

read_input(InStream, Char, Input, EOF) :-
	letter(Char, _),
	!,
	read_to_semicolon(InStream, Char, Input, EOF).

read_input(InStream, Char, Input, EOF) :-
	read_to_line_end(InStream, Char, Input, EOF).

%--------------------------------------------------------------------------
% read_to_line_end: Return list of input characters until a newline.
%--------------------------------------------------------------------------

% read_to_line_end(+InStream, +CurrChar, -CharList, -EOF):

read_to_line_end(_, end_of_file, [], yes) :-
	!.

read_to_line_end(_, '\n', [], no) :-
	!.

read_to_line_end(InStream, Char, [Char|CharList], EOF) :-
	get_char(InStream, NextChar),
	read_to_line_end(InStream, NextChar, CharList, EOF).

%--------------------------------------------------------------------------
% read_to_semicolon: Return list of input characters until a semicolon.
%--------------------------------------------------------------------------

% Note: An empty line also terminates the SQL command
% (this turned out to be more user-friendly than to stop only on ';').

% read_to_semicolon(+InStream, +CurrChar, -CharList, -EOF):

read_to_semicolon(_, end_of_file, [], yes) :-
	!.

read_to_semicolon(InStream, ';', [], EOF) :-
	get_char(InStream, NextChar),
	check_line_end(InStream, NextChar, EOF),
	!.

read_to_semicolon(InStream, Char, [Char|CharList], EOF) :-
	get_char(InStream, NextChar),
	read_to_semicolon2(InStream, Char, NextChar, CharList, EOF).

% read_to_semicolon2(+InStream, +Char, +NextChar, -CharList, -EOF):

read_to_semicolon2(_, '\n', '\n', [], no).

read_to_semicolon2(InStream, _, NextChar, CharList, EOF) :-
	read_to_semicolon(InStream, NextChar, CharList, EOF).

%--------------------------------------------------------------------------
% check_line_end: Semicolon must be followed by a line end.
%--------------------------------------------------------------------------

% check_line_end(+InStream, +Char, -EOF):

% SWI-Prolg prints a prompt of its own if not all input characters were
% read when something (our prompt) is printed and we then read again.
% Therefore, it looks better when we clean up the line after the ';'.

check_line_end(_, '\n', no) :-
	!.

check_line_end(_, end_of_file, yes) :-
	!.

check_line_end(InStream, Char, EOF) :-
	whitespace(Char),
	!,
	get_char(InStream, NextChar),
	check_line_end(InStream, NextChar, EOF).

check_line_end(InStream, Char, EOF) :-
	write('Warning: Semicolon must be followed by a line end, ');
	writeln('rest of line ignored'),
	nl,
	read_to_line_end(InStream, Char, _, EOF).

%==========================================================================
% Character Classification:
%==========================================================================

%--------------------------------------------------------------------------
% letter(+Char, -Lower): 
%--------------------------------------------------------------------------

letter('a', 'a').
letter('b', 'b').
letter('c', 'c').
letter('d', 'd').
letter('e', 'e').
letter('f', 'f').
letter('g', 'g').
letter('h', 'h').
letter('i', 'i').
letter('j', 'j').
letter('k', 'k').
letter('l', 'l').
letter('m', 'm').
letter('n', 'n').
letter('o', 'o').
letter('p', 'p').
letter('q', 'q').
letter('r', 'r').
letter('s', 's').
letter('t', 't').
letter('u', 'u').
letter('v', 'v').
letter('w', 'w').
letter('x', 'x').
letter('y', 'y').
letter('z', 'z').

letter('A', 'a').
letter('B', 'b').
letter('C', 'c').
letter('D', 'd').
letter('E', 'e').
letter('F', 'f').
letter('G', 'g').
letter('H', 'h').
letter('I', 'i').
letter('J', 'j').
letter('K', 'k').
letter('L', 'l').
letter('M', 'm').
letter('N', 'n').
letter('O', 'o').
letter('P', 'p').
letter('Q', 'q').
letter('R', 'r').
letter('S', 's').
letter('T', 't').
letter('U', 'u').
letter('V', 'v').
letter('W', 'w').
letter('X', 'x').
letter('Y', 'y').
letter('Z', 'z').

%--------------------------------------------------------------------------
% digit(+Digit, -Value): 
%--------------------------------------------------------------------------

digit('0', 0).
digit('1', 1).
digit('2', 2).
digit('3', 3).
digit('4', 4).
digit('5', 5).
digit('6', 6).
digit('7', 7).
digit('8', 8).
digit('9', 9).

%--------------------------------------------------------------------------
% underscore(+Char): 
%--------------------------------------------------------------------------

underscore('_').

%--------------------------------------------------------------------------
% id_char(+Char, -NormalizedChar): 
%--------------------------------------------------------------------------

id_char(Char, Lower) :-
	letter(Char, Lower).

id_char(Char, Char) :-
	digit(Char, _).

id_char(Char, Char) :-
	underscore(Char).

%--------------------------------------------------------------------------
% str_quote(+Char): 
%--------------------------------------------------------------------------

str_quote('\'').

%--------------------------------------------------------------------------
% whitespace(+Char): 
%--------------------------------------------------------------------------

whitespace(' ').
whitespace('\t').
whitespace('\n').
whitespace('\r').

%==========================================================================
% Scanner (Lexical Analysis):
%==========================================================================

%--------------------------------------------------------------------------
% scan: Lexical analysis, read a list of tokens.
%--------------------------------------------------------------------------

% scan(+CharList, -TokenList):

scan([], []) :-
	!.

scan([Char|CharListRest], TokenList) :-
	whitespace(Char),
	!,
	scan(CharListRest, TokenList).

scan(['-','-'|CharList], TokenList) :-
	!,
	skip_comment(CharList, CharListRest),
	scan(CharListRest, TokenList).

scan(CharList, [Token|TokenListRest]) :-
	scan_token(CharList, Token, CharListRest),
	scan(CharListRest, TokenListRest).

%--------------------------------------------------------------------------
% skip_comment: Skip characters until the end of the line.
%--------------------------------------------------------------------------

% skip_comment(+CharList, -CharListRest):

skip_comment([], []) :-
	!.

skip_comment(['\n'|CharListRest], CharListRest) :-
	!.

skip_comment([_|CharList], CharListRest) :-
	skip_comment(CharList, CharListRest).

%--------------------------------------------------------------------------
% scan_token: Switch over different token types.
%--------------------------------------------------------------------------

% scan_token(+CharList, -Token, -CharListRest).

scan_token([CurrChar|CharList], Token, CharListRest) :-
	letter(CurrChar, _),
	!,
	scan_id([CurrChar|CharList], IDChars, CharListRest),
	atom_chars(ID, IDChars),
	keyword_check(ID, Token).

scan_token([CurrChar|CharList], str(String), CharListRest) :-
	str_quote(CurrChar),
	!,
	scan_string(CharList, String, CharListRest).

scan_token([CurrChar|CharList], int(Value), CharListRest) :-
	digit(CurrChar, _),
	!,
	scan_int([CurrChar|CharList], 0, Value, CharListRest).

scan_token(['-'|CharList], int(Value), CharListRest) :-
	!,
	scan_int(CharList, 0, PosValue, CharListRest),
	Value is -PosValue.

scan_token(['('|CharList], lparen, CharList) :-
	!.

scan_token([')'|CharList], rparen, CharList) :-
	!.

scan_token([','|CharList], comma, CharList) :-
	!.

scan_token(['.'|CharList], period, CharList) :-
	!.

scan_token(['*'|CharList], star, CharList) :-
	!.

scan_token(['='|CharList], eq, CharList) :-
	!.

scan_token(['<','='|CharList], le, CharList) :-
	!.

scan_token(['<','>'|CharList], ne, CharList) :-
	!.

scan_token(['<'|CharList], lt, CharList) :-
	!.

scan_token(['>','='|CharList], ge, CharList) :-
	!.

scan_token(['>'|CharList], gt, CharList) :-
	!.

scan_token([CurrChar|CharList], error, CharList) :-
	write('Illegal input character: '),
	write(CurrChar),
	write('.'),
	nl,
	fail.

%--------------------------------------------------------------------------
% scan_id: Read identifier, map uppercase to lowercase.
%--------------------------------------------------------------------------

% scan_id(+CharList, -IDChars, -CharListRest): 

scan_id([CurrChar|CharList], [CurrCharLower|IDChars], CharListRest) :-
	id_char(CurrChar, CurrCharLower),
	!,
	scan_id(CharList, IDChars, CharListRest).

scan_id(CharList, [], CharList).

%--------------------------------------------------------------------------
% keyword_check: Map reserved identifiers (keywords) to special tokens.
%--------------------------------------------------------------------------

% keyword_check(+ID, -Token): 

keyword_check(ID, ID) :-
	keyword(ID),
	!.

keyword_check(ID, id(ID)).

%--------------------------------------------------------------------------
% keyword: List of all reserved words in this small SQL parser.
%--------------------------------------------------------------------------

% keyword(+ID): 

keyword(all).
keyword(and).
keyword(as).
keyword(by).
keyword(char).
keyword(create).
keyword(distinct).
keyword(exists).
keyword(foreign).
keyword(from).
keyword(group).
keyword(key).
keyword(not).
keyword(null).
keyword(numeric).
keyword(number). % Oracle SQL
keyword(or).
keyword(order).
keyword(primary).
keyword(references).
keyword(select).
keyword(soft).   % For soft keys (SQL extension).
keyword(table).
keyword(unique).
keyword(where).
keyword(varchar).
keyword(varchar2). % Oracle SQL

%--------------------------------------------------------------------------
% scan_string: Read string literal '...'.
%--------------------------------------------------------------------------

% scan_string(+CharList, -String, -CharListRest):

% Note: The first quote was already removed in scan_token.

scan_string([CurrChar|CharListRest], [], CharListRest) :-
	str_quote(CurrChar),
	!.

scan_string(['\\', EscapedChar|CharList], [EscapedChar|String],
		CharListRest) :-
	!,
	scan_string(CharList, String, CharListRest).

scan_string([CurrChar|CharList], [CurrChar|String], CharListRest) :-
	scan_string(CharList, String, CharListRest).

%--------------------------------------------------------------------------
% scan_int: Read a non-negative integer (sequence of digits).
%--------------------------------------------------------------------------

% scan_int(+CurrChar, +CurrValue, -Value, -FollowingChar):

scan_int([CurrChar|CharList], CurrValue, Value, CharListRest) :-
	digit(CurrChar, DigitValue),
	!,
	NextValue is CurrValue * 10 + DigitValue,
	scan_int(CharList, NextValue, Value, CharListRest).

scan_int(CharList, Value, Value, CharList).

%==========================================================================
% Grammar For SELECT Queries:
%==========================================================================

%--------------------------------------------------------------------------
% SELECT query:
%--------------------------------------------------------------------------

g_query(query(SelectList,FromList,Condition,GroupByList,OrderByList)) -->
	[select], g_select_spec(SelectList),
	[from], g_from_list(FromList),
	g_opt_where(Condition),
	g_opt_group_by(GroupByList),
	g_opt_order_by(OrderByList).

%--------------------------------------------------------------------------
% SELECT specification:
%--------------------------------------------------------------------------

g_select_spec(distinct(star)) --> [distinct], [star].

g_select_spec(all(star)) --> [all], [star].

g_select_spec(all(star)) --> [star].

g_select_spec(distinct(SelectList)) --> [distinct],
					g_select_list(SelectList).

g_select_spec(all(SelectList)) --> [all], g_select_list(SelectList).

g_select_spec(all(SelectList)) --> g_select_list(SelectList).

%--------------------------------------------------------------------------
% SELECT list:
%--------------------------------------------------------------------------

g_select_list([SelItem|Rest]) --> g_select_item(SelItem),
				  g_select_rest(Rest).

g_select_rest([SelItem|Rest]) --> [comma], g_select_item(SelItem),
				  g_select_rest(Rest).

g_select_rest([]) --> [].

%--------------------------------------------------------------------------
% SELECT item:
%--------------------------------------------------------------------------

g_select_item(Term) --> g_term(Term), g_opt_renaming.

g_opt_renaming --> [as], [id(_)].

g_opt_renaming --> [id(_)].

g_opt_renaming --> [].

%--------------------------------------------------------------------------
% FROM list:
%--------------------------------------------------------------------------

g_from_list([FromItem|Rest]) --> g_from_item(FromItem),
				  g_from_rest(Rest).

g_from_rest([FromItem|Rest]) --> [comma], g_from_item(FromItem),
				  g_from_rest(Rest).

g_from_rest([]) --> [].


%--------------------------------------------------------------------------
% FROM item:
%--------------------------------------------------------------------------

g_from_item(var(Rel,Var)) --> [id(Rel)], [as], [id(Var)].

g_from_item(var(Rel,Var)) --> [id(Rel)], [id(Var)].

g_from_item(var(Rel,Rel)) --> [id(Rel)].

%--------------------------------------------------------------------------
% Optional WHERE clause:
%--------------------------------------------------------------------------

g_opt_where(Condition) --> [where], g_condition(Condition).

g_opt_where(true) --> [].

%--------------------------------------------------------------------------
% Optional GROUP BY clause:
%--------------------------------------------------------------------------

g_opt_group_by(GroupByList) --> [group], [by],
				g_group_by_list(GroupByList).

g_opt_group_by([]) --> [].

%--------------------------------------------------------------------------
% Optional ORDER BY clause:
%--------------------------------------------------------------------------

g_opt_order_by(OrderByList) --> [order], [by],
				g_order_by_list(OrderByList).

g_opt_order_by([]) --> [].

%--------------------------------------------------------------------------
% Condition:
%--------------------------------------------------------------------------

g_condition(or(Cond1,Cond2)) --> g_cond_and(Cond1), [or],
				 g_condition(Cond2).

g_condition(Cond) --> g_cond_and(Cond).

g_cond_and(and(Cond1,Cond2)) --> g_cond_not(Cond1), [and],
				 g_cond_and(Cond2).

g_cond_and(Cond) --> g_cond_not(Cond).

g_cond_not(not(Cond)) --> [not], g_cond_not(Cond).

g_cond_not(Cond) --> g_cond(Cond).

g_cond(Cond) --> [lparen], g_condition(Cond), [rparen].

g_cond(comp(Op,Term1,Term2)) --> g_term(Term1), g_comp(Op), g_term(Term2).

g_cond(exists(SelectList,FromList,Condition)) -->
	[exists], [lparen],
	[select], g_select_spec(SelectList),
	[from], g_from_list(FromList),
	g_opt_where(Condition),
	[rparen].

%--------------------------------------------------------------------------
% Comparison Operators:
%--------------------------------------------------------------------------

g_comp(eq) --> [eq].
g_comp(ne) --> [ne].
g_comp(lt) --> [lt].
g_comp(le) --> [le].
g_comp(gt) --> [gt].
g_comp(ge) --> [ge].

%--------------------------------------------------------------------------
% Terms:
%--------------------------------------------------------------------------

g_term(int(Val)) --> [int(Val)].

g_term(str(Str)) --> [str(Str)].

g_term(qattr(Var,Attr)) --> [id(Var)], [period], [id(Attr)].

g_term(attr(Attr)) --> [id(Attr)].

%==========================================================================
% Grammar For CREATE TABLE statements:
%==========================================================================

%--------------------------------------------------------------------------
% CREATE TABLE statement:
%--------------------------------------------------------------------------

g_create_table(rdecl(Rel,ColList,ConstrList)) -->
	[create], [table], [id(Rel)],
	[lparen], g_decl_list(ColList, ConstrList), [rparen].

%--------------------------------------------------------------------------
% List of Column Declarations and Constraints:
%--------------------------------------------------------------------------

g_decl_list(ColList, ConstrList) -->
	g_decl_item(ColList, ConstrList, ColListRest, ConstrListRest),
	g_decl_rest(ColListRest, ConstrListRest).

g_decl_rest(ColList, ConstrList) -->
	[comma], 
	g_decl_item(ColList, ConstrList, ColListRest, ConstrListRest),
	g_decl_rest(ColListRest, ConstrListRest).

g_decl_rest([], []) -->
	[].

%--------------------------------------------------------------------------
% Item in CREATE TABLE statement:
%--------------------------------------------------------------------------

g_decl_item([Col|ColListRest], ConstrList, ColListRest, ConstrListRest) -->
	g_col_decl(Col, ConstrList, ConstrListRest).

g_decl_item(ColList, [Constr|ConstrListRest], ColList, ConstrListRest) -->
	g_tab_constr(Constr).

%--------------------------------------------------------------------------
% Column Declaration:
%--------------------------------------------------------------------------

g_col_decl(col(ColName,Type,NotNull), ConstrList, ConstrListRest) -->
	[id(ColName)],
	g_data_type(Type),
	g_col_constr_list(ColName, null_unspec, NotNull,
				ConstrList, ConstrListRest).

%--------------------------------------------------------------------------
% Data Types:
%--------------------------------------------------------------------------

g_data_type(char(N)) -->
	[char], [lparen], [int(N)], {N > 0}, [rparen].

g_data_type(char(1)) -->
	[char].

g_data_type(varchar(N)) -->
	[varchar], [lparen], [int(N)], {N > 0}, [rparen].

g_data_type(varchar(N)) -->
	[varchar2], [lparen], [int(N)], {N > 0}, [rparen].

g_data_type(numeric(N,0)) -->
	[numeric], [lparen], [int(N)], {N > 0}, [rparen].

g_data_type(numeric(N,0)) -->
	[number], [lparen], [int(N)], {N > 0}, [rparen].

%--------------------------------------------------------------------------
% Column Constraint List:
%--------------------------------------------------------------------------

g_col_constr_list(Col, null_unspec, NotNullOut, ConstrList, ConstrListRest)
	-->
	[not], [null],
	g_col_constr_list(Col, not_null, NotNullOut,
				ConstrList, ConstrListRest).

g_col_constr_list(Col, null_unspec, NotNullOut, ConstrList, ConstrListRest)
	-->
	[null],
	g_col_constr_list(Col, null, NotNullOut,
				ConstrList, ConstrListRest).

g_col_constr_list(Col, NotNullIn, NotNullOut, [Constr|ConstrList],
		ConstrListRest) -->
	g_col_constr(Col, Constr),
	g_col_constr_list(Col, NotNullIn, NotNullOut,
		ConstrList, ConstrListRest).

g_col_constr_list(_Col, NotNullIn, NotNullOut, ConstrList, ConstrList) -->
	{not_null_default(NotNullIn, NotNullOut)},
	[].

%not_null_default(+NotNullIn, -NotNullOut):

not_null_default(null_unspec, null).
not_null_default(null, null).
not_null_default(not_null, not_null).

%--------------------------------------------------------------------------
% Column Constraints:
%--------------------------------------------------------------------------

g_col_constr(Col, pkey([Col])) -->
	[primary], [key].

g_col_constr(Col, key([Col])) -->
	[unique].

g_col_constr(Col, skey([Col])) -->
	[soft], [key].

g_col_constr(Col, ref([Col],Rel)) -->
	[references], [id(Rel)].

%--------------------------------------------------------------------------
% Table Constraints:
%--------------------------------------------------------------------------

g_tab_constr(pkey(ColList)) -->
	[primary], [key], [lparen], g_col_list(ColList), [rparen].

g_tab_constr(key(ColList)) -->
	[unique], [lparen], g_col_list(ColList), [rparen].

g_tab_constr(skey(ColList)) -->
	[soft], [key], [lparen], g_col_list(ColList), [rparen].

g_tab_constr(ref(ColList,Rel)) -->
	[foreign], [key], [lparen], g_col_list(ColList), [rparen],
	[references], [id(Rel)].

%--------------------------------------------------------------------------
% Column List:
%--------------------------------------------------------------------------

g_col_list([Col|ColListRest]) -->
	[id(Col)], g_col_list_rest(ColListRest).

g_col_list_rest([Col|ColListRest]) -->
	[comma], [id(Col)], g_col_list_rest(ColListRest).

g_col_list_rest([]) -->
	[].

%==========================================================================
% Process Table Declaration:
%==========================================================================

%--------------------------------------------------------------------------
% store_schema: Check CREATE TABLE, store schema data in dynamic database.
%--------------------------------------------------------------------------

% store_schema(+RelName, +ColList, +ConstrList):

store_schema(RelName, ColList, ConstrList) :-
	check_dup_table(RelName),
	check_dup_column(ColList),
	check_constr_cols(ConstrList, ColList),
	find_unique_pkey(ConstrList, PK),
	check_foreign_keys(ConstrList, RelName, PK),
	pk_implies_not_null(ColList, PK, NewColList),
	!,
	store_rel(RelName, PK),
	store_cols(RelName, NewColList),
	store_constraints(RelName, ConstrList).

store_schema(_, _, _) :-
	writeln('CREATE TABLE failed.'),
	nl.

%--------------------------------------------------------------------------
% check_dup_table: Print error message if relation is already defined.
%--------------------------------------------------------------------------

check_dup_table(RelName) :-
	relation(RelName, _),
	!,
	write('Error: Relation '),
	write(RelName),
	writeln(' is already defined.'),
	fail.

check_dup_table(_).

%--------------------------------------------------------------------------
% check_dup_column: Print error message if there is a column name clash.
%--------------------------------------------------------------------------

check_dup_column([]).

check_dup_column([col(ColName,_Type,_NotNull)|MoreCols]) :-
	check_dup_column2(ColName, MoreCols),
	check_dup_column(MoreCols).

check_dup_column2(_, []).

check_dup_column2(ColName, [col(ColName,_,_)|_]) :-
	!,
	write('Column "'),
	write(ColName),
	write('" doubly defined.'),
	nl,
	!,
	fail.

check_dup_column2(ColName, [_|MoreCols]) :-
	check_dup_column2(ColName, MoreCols).

%--------------------------------------------------------------------------
% check_constr_cols: Check whether columns mentioned in constraints exist.
%--------------------------------------------------------------------------

% check_constraints(+ConstrList, +ColList):

check_constr_cols([], _).

check_constr_cols([Constr|ConstrList], ColList) :-
	check_constr_cols2(Constr, ColList),
	check_constr_cols(ConstrList, ColList).

% check_constr_cols2(+Constr, +ColList):

check_constr_cols2(pkey(KeyColList), ColList) :-
	check_key(KeyColList, ColList, 'primary key').

check_constr_cols2(key(KeyColList), ColList) :-
	check_key(KeyColList, ColList, 'unique key').

check_constr_cols2(skey(KeyColList), ColList) :-
	check_key(KeyColList, ColList, 'soft key').

check_constr_cols2(ref(KeyColList, _), ColList) :-
	check_key(KeyColList, ColList, 'foreign key').

% check_key(+KeyColList, +RelColList, +ConstraintName):

check_key([], _, _).

check_key([Col|MoreCols], RelColList, ConstraintName) :-
	check_col_exists(Col, RelColList),
	!,
	check_key(MoreCols, RelColList, ConstraintName).

check_key([Col|_], _, ConstraintName) :-
	write('Column "'),
	write(Col),
	write('" used in '),
	write(ConstraintName),
	write(' is not declared.'),
	nl,
	fail.

% check_col_exists(+Col, +ColList):

check_col_exists(Col, [col(Col,_,_)|_]).

check_col_exists(Col, [_|MoreCols]) :-
	check_col_exists(Col, MoreCols).

%--------------------------------------------------------------------------
% find_unique_pkey: Find unique primary key, or [] if not declared.
%--------------------------------------------------------------------------

% find_unique_pkey(+ConstrList, -PKey):

find_unique_pkey([], []).

find_unique_pkey([pkey(PKey)|ConstrList], PKey) :-
	!,
	check_no_further_pkey(ConstrList).

find_unique_pkey([_|ConstrList], PKey) :-
	find_unique_pkey(ConstrList, PKey).

% check_no_further_pkey(+ConstrList):

check_no_further_pkey([]).

check_no_further_pkey([pkey(_)|_]) :-
	writeln('Error: Relation has more than one primary key.'),
	!,
	fail.

check_no_further_pkey([_|ConstrList]) :-
	check_no_further_pkey(ConstrList).

%--------------------------------------------------------------------------
% check_foreign_keys: Check foreign key: Does referenced relation exist?
%--------------------------------------------------------------------------

% check_foreign_keys(+ConstrList, +ThisRel, +ThisPK):

check_foreign_keys([], _, _).

check_foreign_keys([ref(FKCols,RefRel)|ConstrList], ThisRel, ThisPK) :-
	!,
	check_ref(FKCols, RefRel, ThisRel, ThisPK),
	check_foreign_keys(ConstrList, ThisRel, ThisPK).

check_foreign_keys([_|ConstrList], ThisRel, ThisPK) :-
	check_foreign_keys(ConstrList, ThisRel, ThisPK).

% check_ref(+FKCols, +RefRel, +ThisRel, +ThisPK):

check_ref(FKCols, Rel, Rel, ThisPK) :-
	!,
	match_cols(FKCols, ThisPK).

check_ref(FKCols, Rel, _, _) :-
	relation(Rel, PKCols),
	!,
	match_cols(FKCols, PKCols).

check_ref(_, Rel, _, _) :-
	write('Error: Referenced relation "'),
	write(Rel),
	write('" does not exist.'),
	nl.

% match_cols(+FKCols, +PKCols):

% At the moment, we check only that the number of columns matches.
% Later the compatibility of the data types should be checked, too.

match_cols(FKCols, PKCols) :-
	match_cols2(FKCols, PKCols, FKCols).

match_cols2([], [], _).

match_cols2([_|FKCols], [_|PKCols], AllFKCols) :-
	match_cols2(FKCols, PKCols, AllFKCols).

match_cols2([], [_|_], AllFKCols) :-
	!,
	write('Error: Foreign key '),
	write(AllFKCols),
	write(' has fewer columns than PK of referenced relation'),
	nl,
	fail.

match_cols2([_|_], [], AllFKCols) :-
	!,
	write('Error: Foreign key '),
	write(AllFKCols),
	write(' has more columns than PK of referenced relation'),
	nl,
	fail.

%--------------------------------------------------------------------------
% pk_implies_not_null: Make primary key columns not null.
%--------------------------------------------------------------------------

% pk_implies_not_null(+ColList, +PK, -NewColList):

pk_implies_not_null([],_, []).

pk_implies_not_null([col(ColName,Type,_)|ColList], PK,
			[col(ColName,Type,not_null)|NewColList]) :-
	is_member(ColName, PK),
	!,
	pk_implies_not_null(ColList, PK, NewColList).

pk_implies_not_null([ColSpec|ColList], PK, [ColSpec|NewColList]) :-
	pk_implies_not_null(ColList, PK, NewColList).

%==========================================================================
% Check Existence of Relations and Attributes in SELECT Queries:
%==========================================================================

%--------------------------------------------------------------------------
% check_from_list: Check whether relations exist. Check for name clashes.
%--------------------------------------------------------------------------

% check_from_list(+FromList):

check_from_list([]).

check_from_list([var(Rel,Var)|FromListRest]) :-
	check_rel_exists(Rel),
	check_no_duplicate_var(Var, FromListRest),
	check_from_list(FromListRest).

% check_rel_exists(+Rel):

check_rel_exists(Rel) :-
	relation(Rel, _),
	!.

check_rel_exists(Rel) :-
	write('Error: Relation "'),
	write(Rel),
	write('" is not declared.'),
	nl,
	fail.

% check_no_duplicate_var(+Var, +FromList):

check_no_duplicate_var(_, []).

check_no_duplicate_var(Var, [var(_,Var)|_]) :-
	!,
	write('Error: Duplicate tuple variable "'),
	write(Var),
	write('".'),
	nl,
	fail.

check_no_duplicate_var(Var, [_|FromListRest]) :-
	check_no_duplicate_var(Var, FromListRest).

%--------------------------------------------------------------------------
% make_vars_explicit_select: Check attribute references, insert tuple vars.
%--------------------------------------------------------------------------

% make_vars_explicit_select(+Select, +VarDecl, -NewSelect):

make_vars_explicit_select(all(star), _, all(star)) :-
	!.

make_vars_explicit_select(distinct(star), _, distinct(star)) :-
	!.

make_vars_explicit_select(all(SelList), VarDecl, all(NewSelList)) :-
	make_vars_explicit_sel_list(SelList, VarDecl, NewSelList).

make_vars_explicit_select(distinct(SelList), VarDecl, distinct(NewSelList))
	:-
	make_vars_explicit_sel_list(SelList, VarDecl, NewSelList).

% make_vars_explicit_sel_list(+SelList, +VarDecl, -NewSelList).

make_vars_explicit_sel_list([], _, []).

make_vars_explicit_sel_list([SelItem|SelList], VarDecl,
				[NewSelItem|NewSelList]) :-
	make_vars_explicit_term(SelItem, VarDecl, NewSelItem),
	make_vars_explicit_sel_list(SelList, VarDecl, NewSelList).

%--------------------------------------------------------------------------
% make_vars_explicit_term: Check attribute references, insert tuple vars.
%--------------------------------------------------------------------------

% make_vars_explicit_term(+Term, +VarDecl, -NewTerm):

make_vars_explicit_term(attr(Attr), VarDecl, aref(Rel,Var,Attr)) :-
	check_attr_ref(Attr, VarDecl, Rel, Var).

make_vars_explicit_term(qattr(Var,Attr), VarDecl, aref(Rel,Var,Attr)) :-
	check_var_exists(Var, VarDecl, Rel),
	check_rel_has_attr(Rel, Attr, Var).

make_vars_explicit_term(int(Val), _, int(Val)).

make_vars_explicit_term(str(String), _, str(String)).

%--------------------------------------------------------------------------
% make_vars_explicit_cond: Check attribute references, insert tuple vars.
%--------------------------------------------------------------------------

% make_vars_explicit_cond(+Cond, +VarDecl, -NewCond):

make_vars_explicit_cond(true, _, true).

make_vars_explicit_cond(comp(Op,Term1,Term2), VarDecl,
				comp(Op,NewTerm1,NewTerm2)) :-
	make_vars_explicit_term(Term1, VarDecl, NewTerm1),
	make_vars_explicit_term(Term2, VarDecl, NewTerm2).

make_vars_explicit_cond(not(Cond), VarDecl, not(NewCond)) :-
	make_vars_explicit_cond(Cond, VarDecl, NewCond).

make_vars_explicit_cond(and(Cond1,Cond2), VarDecl, and(NewCond1,NewCond2))
	:-
	make_vars_explicit_cond(Cond1, VarDecl, NewCond1),
	make_vars_explicit_cond(Cond2, VarDecl, NewCond2).

make_vars_explicit_cond(or(Cond1,Cond2), VarDecl, or(NewCond1,NewCond2))
	:-
	make_vars_explicit_cond(Cond1, VarDecl, NewCond1),
	make_vars_explicit_cond(Cond2, VarDecl, NewCond2).

make_vars_explicit_cond(exists(Select,From,Where),
		VarDecl,
		exists(NewSelect,From,NewWhere)) :-
	make_vars_explicit_select(Select, [From|VarDecl], NewSelect),
	make_vars_explicit_cond(Where, [From|VarDecl], NewWhere).

%--------------------------------------------------------------------------
% check_attr_ref: Find unique tuple variable with given attribute.
%--------------------------------------------------------------------------

% check_attr_ref(+Attr, +VarDecl, -Rel, -Var):

check_attr_ref(Attr, [], _, _) :-
	write('Error: No declared tuple variable has an attribute "'),
	write(Attr),
	write('".'),
	nl,
	!,
	fail.

check_attr_ref(Attr, [[var(Rel,Var)|FromRest]|_], Rel, Var) :-
	column(Rel, Attr, _, _),
	!,
	check_no_matching_var(Attr, FromRest).

check_attr_ref(Attr, [[_|FromRest]|VarDeclRest], Rel, Var) :-
	!,
	check_attr_ref(Attr, [FromRest|VarDeclRest], Rel, Var).

check_attr_ref(Attr, [[]|VarDeclRest], Rel, Var) :-
	check_attr_ref(Attr, VarDeclRest, Rel, Var).

% check_no_matching_var(+Attr, +VarDecl):

check_no_matching_var(_, []) :-
	!.

check_no_matching_var(Attr, [var(Rel,_)|_]) :-
	column(Rel, Attr, _, _),
	!,
	write('Error: Attribute reference "'),
	write(Attr),
	write('" is not unique (needs tuple variable).'),
	nl,
	!,
	fail.

check_no_matching_var(Attr, [_|VarDeclRest]) :-
	check_no_matching_var(Attr, VarDeclRest).

%--------------------------------------------------------------------------
% check_var_exists: Check whether a referenced tuple variable is declared.
%--------------------------------------------------------------------------

% check_var_exists(+Var, +VarDecl, -Rel):

check_var_exists(Var, [[var(Rel,Var)|_]|_], Rel) :-
	!.

check_var_exists(Var, [[_|FromRest]|VarDeclRest], Rel) :-
	!,
	check_var_exists(Var, [FromRest|VarDeclRest], Rel).

check_var_exists(Var, [[]|VarDeclRest], Rel) :-
	!,
	check_var_exists(Var, VarDeclRest, Rel).

check_var_exists(Var, [], error) :-
	write('Error: Tuple variable "'),
	write(Var),
	write('" is not declared.'),
	nl,
	!,
	fail.

%--------------------------------------------------------------------------
% check_rel_has_attr: Check whether a given Relation has a given attribute.
%--------------------------------------------------------------------------

% check_rel_has_attr(+Rel, +Attr, -Var):

check_rel_has_attr(Rel, Attr, _) :-
	column(Rel, Attr, _, _),
	!.

check_rel_has_attr(_, Attr, Var) :-
	write('Error: Tuple variable "'),
	write(Var),
	write(' has no attribute '),
	write(Attr),
	nl,
	fail.

%==========================================================================
% Functions for Making Tuple Variable Names Unique
%==========================================================================

% Subqueries can possibly declare tuple variables with the same name
% as variables declared in the outer query or other subqueries.
% However, for Skolemization, all tuple variables must have a unique name.
% Therefore, the following predicates append #1, #2, #3, and so on
% to the variable names if necessary.

%--------------------------------------------------------------------------
% make_tvars_unique: Ensure that every tuple variable has a unique name.
%--------------------------------------------------------------------------

% make_tvars_unique(+From, +Where, -NewWhere):

make_tvars_unique(From, Where, NewWhere) :-
	from_to_varlist(From, VarList),
	make_tvars_unique(Where, [], VarList, _, NewWhere).

% make_tvars_unique(+Where, +Renaming, +VarsIn, -VarsOut, -NewWhere):

make_tvars_unique(true, _, Vars, Vars, true).

make_tvars_unique(comp(Op,Term1,Term2), Renaming, Vars, Vars,
		comp(Op,NewTerm1,NewTerm2)) :-
	apply_renaming_term(Term1, Renaming, NewTerm1),
	apply_renaming_term(Term2, Renaming, NewTerm2).

make_tvars_unique(not(Cond), Renaming, VarsIn, VarsOut, not(NewCond)) :-
	make_tvars_unique(Cond, Renaming, VarsIn, VarsOut, NewCond).

make_tvars_unique(and(Cond1,Cond2), Renaming, VarsIn, VarsOut,
		and(NewCond1,NewCond2)) :-
	make_tvars_unique(Cond1, Renaming, VarsIn, Vars, NewCond1),
	make_tvars_unique(Cond2, Renaming, Vars, VarsOut, NewCond2).

make_tvars_unique(or(Cond1,Cond2), Renaming, VarsIn, VarsOut,
		or(NewCond1,NewCond2)) :-
	make_tvars_unique(Cond1, Renaming, VarsIn, Vars, NewCond1),
	make_tvars_unique(Cond2, Renaming, Vars, VarsOut, NewCond2).

make_tvars_unique(exists(Select,From,Where), Renaming, VarsIn, VarsOut,
		exists(NewSelect,NewFrom,NewWhere)) :-
	determine_renaming(From, VarsIn, Vars, NewFrom, MoreRenamings),
	list_append(Renaming, MoreRenamings, NewRenaming),
	apply_renaming_select(Select, NewRenaming, NewSelect),
	make_tvars_unique(Where, NewRenaming, Vars, VarsOut, NewWhere).

%--------------------------------------------------------------------------
% from_to_varlist: Get list of variables declared in the from clause.
%--------------------------------------------------------------------------

% from_to_varlist(+From, -VarList):

from_to_varlist([], []).

from_to_varlist([var(_,Var)|From], [Var|VarList]) :-
	from_to_varlist(From, VarList).

%--------------------------------------------------------------------------
% apply_renaming_term: Apply a variable renaming to a term.
%--------------------------------------------------------------------------

% apply_renaming_term(+Term, +Renaming, -NewTerm):

apply_renaming_term(int(I), _, int(I)).

apply_renaming_term(str(S), _, str(S)).

apply_renaming_term(aref(Rel,OldVar,Attr), Renaming,
			aref(Rel,NewVar,Attr)) :-
	is_member(replace(OldVar,NewVar), Renaming),
	!.

apply_renaming_term(aref(Rel,Var,Attr), _, aref(Rel,Var,Attr)).

%--------------------------------------------------------------------------
% apply_renaming_select: Apply a variable renaming to the select list.
%--------------------------------------------------------------------------

% apply_renaming_select(+Select, +Renaming, -NewSelect):

apply_renaming_select(all(star), _, all(star)) :-
	!.

apply_renaming_select(distinct(star), _, distinct(star)) :-
	!.

apply_renaming_select(all(TermList), Renaming, all(NewTermList)) :-
	apply_renaming_termlist(TermList, Renaming, NewTermList).

apply_renaming_select(distinct(TermList), Renaming,
		distinct(NewTermList)) :-
	apply_renaming_termlist(TermList, Renaming, NewTermList).

% apply_renaming_termlist(+TermList, +Renaming, -NewTermList):

apply_renaming_termlist([], _, []).

apply_renaming_termlist([Term|TermList], Renaming, [NewTerm|NewTermList]):-
	apply_renaming_term(Term, Renaming, NewTerm),
	apply_renaming_termlist(TermList, Renaming, NewTermList).

%--------------------------------------------------------------------------
% determine_renaming: Determine which variables must be renamed.
%--------------------------------------------------------------------------

% determine_renaming(+From, +VarsIn, -VarsOut, -NewFrom, -Renaming):

determine_renaming([], Vars, Vars, [], []).

determine_renaming([var(Rel,Var)|From], VarsIn, VarsOut,
		[var(Rel,NewVar)|NewFrom],
		[replace(Var,NewVar)|Renaming]) :-
	is_member(Var, VarsIn), % Variable is already used
	!,
	make_new_var(Var, 1, VarsIn, NewVar),
	determine_renaming(From, [NewVar|VarsIn], VarsOut, NewFrom,
		Renaming).

determine_renaming([var(Rel,Var)|From], VarsIn, VarsOut,
		[var(Rel,Var)|NewFrom], Renaming) :-
	determine_renaming(From, [Var|VarsIn], VarsOut, NewFrom, Renaming).

%--------------------------------------------------------------------------
% make_new_var: Rename variable so that it becomes different from existing.
%--------------------------------------------------------------------------

% make_new_var(+Var, +Suffix, +ExistingVars, -NewVar):

make_new_var(Var, VarNo, ExistingVars, NewVar) :-
	name(Var, VarCharList),
	name(VarNo, VarNoChars), % This might be not portable
	name('#', Delimiter),
	list_append(Delimiter, VarNoChars, Suffix),
	list_append(VarCharList, Suffix, NewVarCharList),
	name(NewVar, NewVarCharList),
	\+ is_member(NewVar, ExistingVars),
	!.

make_new_var(Var, VarNo, ExistingVars, NewVar) :-
	NextVarNo is VarNo + 1,
	make_new_var(Var, NextVarNo, ExistingVars, NewVar).


%==========================================================================
% Unparser:
%==========================================================================

%--------------------------------------------------------------------------
% print_term: Print a term.
%--------------------------------------------------------------------------

% print_term(+Term):

print_term(int(I)) :-
	write(I).

print_term(str(S)) :-
	write('\''),
	print_str(S),
	write('\'').

print_term(aref(_,X,A)) :-
	print_var_uelem(X),
	write('.'),
	write(A).

%--------------------------------------------------------------------------
% print_var_uelem: Print a tuple variable or Skolem term.
%--------------------------------------------------------------------------

% print_var_uelem(+VarOrSkolem):

print_var_uelem(uelem(Fun,ArgVals,_)) :-
	!,
	write(Fun),
	print_uelem_argvals(ArgVals).

print_var_uelem(Var) :-
	atomic(Var),
	write(Var).

% print_uelem_argvals(+ArgVals):

print_uelem_argvals([]).

print_uelem_argvals([ArgVal|MoreArgVals]) :-
	write('('),
	print_var_uelem(ArgVal),
	print_uelem_argvals_rest(MoreArgVals),
	write(')').

% print_uelem_argvals_rest(+ArgVals):

print_uelem_argvals_rest([]).

print_uelem_argvals_rest([ArgVal|MoreArgVals]) :-
	write(', '),
	print_var_uelem(ArgVal),
	print_uelem_argvals_rest(MoreArgVals).

%--------------------------------------------------------------------------
% print_str: Print a list of characters.
%--------------------------------------------------------------------------

print_str([]).

print_str([Char|CharList]) :-
	write(Char),
	print_str(CharList).

%--------------------------------------------------------------------------
% print_atomic_formula(+Cond):
%--------------------------------------------------------------------------

% Note: The name is no longer completely correct.
% The argument can also be an EXISTS-condition, or even not_exists(...).
% The argument is atomic only with respect to the logical connectives
% and, or, not.

print_atomic_formula(comp(Op,Term1,Term2)) :-
	print_term(Term1),
	write(' '),
	comp_op(Op, Symbol),
	write(Symbol),
	write(' '),
	print_term(Term2).

print_atomic_formula(exists(S,F,W)) :-
	write('exists '),
	write('('),
	write('select '),
	print_select(S),
	write(' from '),
	print_from(F),
	write(' where '),
	print_cond(W),
	write(')').

print_atomic_formula(not_exists(S,F,W)) :-
	write('not '),
	print_atomic_formula(exists(S,F,W)).

%--------------------------------------------------------------------------
% comp_op(+Op, -Symbol):
%--------------------------------------------------------------------------

comp_op(eq, '=').
comp_op(ne, '<>').
comp_op(lt, '<').
comp_op(le, '<=').
comp_op(gt, '>').
comp_op(ge, '>=').

%--------------------------------------------------------------------------
% print_conj(+Conj):
%--------------------------------------------------------------------------

print_conj([]) :-
	write('true').

print_conj([A]) :-
	print_atomic_formula(A).

print_conj([A,B|Rest]) :-
	print_atomic_formula(A),
	write(' and '),
	print_conj([B|Rest]).

%--------------------------------------------------------------------------
% print_dnf(+DNF):
%--------------------------------------------------------------------------

print_dnf([]) :-
	write('false').

print_dnf([A]) :-
	print_conj(A).

print_dnf([A,B|Rest]) :-
	print_conj(A),
	write(' or '),
	print_dnf([B|Rest]).

%--------------------------------------------------------------------------
% print_cond(+Cond):
%--------------------------------------------------------------------------

% print_cond(+Cond):

print_cond(Cond) :-
	print_cond_or(Cond).

% print_cond_or(+Cond):

print_cond_or(or(Cond1,Cond2)) :-
	!,
	print_cond_or(Cond1),
	write(' or '),
	print_cond_or(Cond2).

print_cond_or(Cond) :-
	print_cond_and(Cond).

% print_cond_and(+Cond):

print_cond_and(and(Cond1,Cond2)) :-
	!,
	print_cond_and(Cond1),
	write(' and '),
	print_cond_and(Cond2).

print_cond_and(Cond) :-
	print_cond_not(Cond).

% print_cond_not(+Cond):

print_cond_not(not(Cond)) :-
	!,
	write('not '),
	print_cond_not(Cond).

print_cond_not(Cond) :-
	print_cond_atomic(Cond).

% print_cond_atomic(+Cond):

print_cond_atomic(comp(Op,Term1,Term2)) :-
	!,
	print_atomic_formula(comp(Op,Term1,Term2)).

print_cond_atomic(true) :-
	!,
	write('true').

print_cond_atomic(false) :-
	!,
	write('false').

print_cond_atomic(exists(S,F,W)) :-
	!,
	print_atomic_formula(exists(S,F,W)).

print_cond_atomic(Cond) :-
	write('('),
	print_cond_or(Cond),
	write(')').

%--------------------------------------------------------------------------
% print_select: Print SELECT clause (without keyword SELECT):
%--------------------------------------------------------------------------

% print_select(+Select):

print_select(all(star)) :-
	!,
	write('*').

print_select(all(TermList)) :-
	print_termlist(TermList).

print_select(distinct(star)) :-
	!,
	write('distinct '),
	write('*').

print_select(distinct(TermList)) :-
	write('distinct '),
	print_termlist(TermList).

%--------------------------------------------------------------------------
% print_termlist: Print list of terms, separated by commas.
%--------------------------------------------------------------------------

% print_termlist(+TermList):

print_termlist([Term]) :-
	print_term(Term).

print_termlist([Term1,Term2|MoreTerms]) :-
	print_term(Term1),
	write(', '),
	print_termlist([Term2|MoreTerms]).

%--------------------------------------------------------------------------
% print_from: Print FROM clause (without keyword FROM):
%--------------------------------------------------------------------------

% print_from(+From):

print_from([var(R,R)|MoreVars]) :-
	!,
	write(R),
	print_from_rest(MoreVars).

print_from([var(R,X)|MoreVars]) :-
	R \= X,
	write(R),
	write(' '),
	write(X),
	print_from_rest(MoreVars).

% print_from_rest(+From):

print_from_rest([]).

print_from_rest([var(R,R)|MoreVars]) :-
	!,
	write(', '),
	write(R),
	print_from_rest(MoreVars).

print_from_rest([var(R,X)|MoreVars]) :-
	R \= X,
	write(', '),
	write(R),
	write(' '),
	write(X),
	print_from_rest(MoreVars).

%==========================================================================
% Logical Transformations (Disjunctive Normal Form etc.):
%==========================================================================

%--------------------------------------------------------------------------
% cond_to_dnf: Eliminate NOT, then compute disjunctive normal form.
%--------------------------------------------------------------------------

cond_to_dnf(Cond, DNF) :-
	eliminate_not(Cond, NewCond),
	dnf(NewCond, DNF).

%--------------------------------------------------------------------------
% eliminate_not: Push not downwards, invert comparison operators.
%--------------------------------------------------------------------------

% eliminate_not(+Cond, -NewCond):

eliminate_not(true, true).

eliminate_not(comp(Op,Term1,Term2), comp(Op,Term1,Term2)).

eliminate_not(exists(Select,From,Where),
	exists(Select,From,Where)).

eliminate_not(and(Cond1,Cond2), and(NewCond1,NewCond2)) :-
	eliminate_not(Cond1, NewCond1),
	eliminate_not(Cond2, NewCond2).

eliminate_not(or(Cond1,Cond2), or(NewCond1,NewCond2)) :-
	eliminate_not(Cond1, NewCond1),
	eliminate_not(Cond2, NewCond2).

eliminate_not(not(Cond), NewCond) :-
	eliminate_not_inv(Cond, NewCond).

% eliminate_not_inv(+Cond, -NewCond):

eliminate_not_inv(comp(Op,Term1,Term2), comp(InvOp,Term1,Term2)) :-
	inv_op(Op, InvOp).

eliminate_not_inv(exists(Select,From,Where),
	not_exists(Select,From,Where)).

eliminate_not_inv(and(Cond1,Cond2), or(NewCond1,NewCond2)) :-
	eliminate_not_inv(Cond1, NewCond1),
	eliminate_not_inv(Cond2, NewCond2).

eliminate_not_inv(or(Cond1,Cond2), and(NewCond1,NewCond2)) :-
	eliminate_not_inv(Cond1, NewCond1),
	eliminate_not_inv(Cond2, NewCond2).

eliminate_not_inv(not(Cond), NewCond) :-
	eliminate_not(Cond, NewCond).

% inv_op(+Op, -InvOp):

inv_op(eq, ne).
inv_op(ne, eq).
inv_op(lt, ge).
inv_op(le, gt).
inv_op(ge, lt).
inv_op(gt, le).

%--------------------------------------------------------------------------
% dnf: Compute disjunctive normal form after not was eliminated.
%--------------------------------------------------------------------------

% dnf(+Cond, +DNF):

dnf(true, [[]]).

dnf(and(Cond1,Cond2), DNF) :-
	dnf(Cond1, DNF1),
	dnf(Cond2, DNF2),
	list_mult(DNF1, DNF2, DNF).

dnf(or(Cond1,Cond2), DNF) :-
	dnf(Cond1, DNF1),
	dnf(Cond2, DNF2),
	list_append(DNF1, DNF2, DNF).

dnf(comp(Op,Term1,Term2), [[comp(Op,Term1,Term2)]]).

dnf(exists(Select,From,Where),
	[[exists(Select,From,Where)]]).

dnf(not_exists(Select,From,Where),
	[[not_exists(Select,From,Where)]]).

%--------------------------------------------------------------------------
% cnf: Compute conjunctive normal form after not was eliminated.
%--------------------------------------------------------------------------

% cnf(+Cond, +CNF):

cnf(true, []).

cnf(or(Cond1,Cond2), CNF) :-
	cnf(Cond1, CNF1),
	cnf(Cond2, CNF2),
	list_mult(CNF1, CNF2, CNF).

cnf(and(Cond1,Cond2), CNF) :-
	cnf(Cond1, CNF1),
	cnf(Cond2, CNF2),
	list_append(CNF1, CNF2, CNF).

cnf(comp(Op,Term1,Term2), [[comp(Op,Term1,Term2)]]).

cnf(exists(Select,From,Where),
	[[exists(Select,From,Where)]]).

cnf(not_exists(Select,From,Where),
	[[not_exists(Select,From,Where)]]).

%--------------------------------------------------------------------------
% cnf_to_conj: Select one-element-disjunctions out of CNF.
%--------------------------------------------------------------------------

% This predicate eliminates disjunctive conditions from the CNF of the
% WHERE-clause, e.g. "A and (B or C) and D" is translated to "A and D".
% The WHERE-clause becomes weaker by this transformation,
% but some algorithms can work only with conjunctions of atomic formulas.
% This predicate also removes EXISTS and NOT EXISTS subqueries.

% cnf_to_conj(+CNF, -Conj):

cnf_to_conj([], []).

cnf_to_conj([[comp(Op,Term1,Term2)]|CNF], [comp(Op,Term1,Term2)|Conj]) :-
	!,
	cnf_to_conj(CNF, Conj).

cnf_to_conj([[exists(_,_,_)]|CNF], Conj) :-
	!,
	cnf_to_conj(CNF, Conj).

cnf_to_conj([[not_exists(_,_,_)]|CNF], Conj) :-
	!,
	cnf_to_conj(CNF, Conj).

cnf_to_conj([[_, _|_]|CNF], Conj) :-
	cnf_to_conj(CNF, Conj).

%--------------------------------------------------------------------------
% dnf_to_cond: Translate DNF back into formula with and, or.
%--------------------------------------------------------------------------

% dnf_to_cond(+DNF, -Cond):

dnf_to_cond([], false).

dnf_to_cond([C], F) :-
	conj_to_cond(C, F).

dnf_to_cond([C1,C2|DNF], or(F,G)) :-
	conj_to_cond(C1, F),
	dnf_to_cond([C2|DNF], G).

%--------------------------------------------------------------------------
% conj_to_cond: Translate list of atomic formulas into formula with and.
%--------------------------------------------------------------------------

% conj_to_cond(+Conj, -Cond):

conj_to_cond([], true).

conj_to_cond([A], ACond) :-
	dnf_atom_to_cond(A, ACond).

conj_to_cond([A,B|Conj], and(ACond,F)) :-
	dnf_atom_to_cond(A, ACond),
	conj_to_cond([B|Conj], F).

%--------------------------------------------------------------------------
% dnf_atom_to_cond: Translate not_exists(S,F,W) to not(exists(S,F,W)).
%--------------------------------------------------------------------------

dnf_atom_to_cond(not_exists(S,F,W), not(exists(S,F,W))) :-
	!.

dnf_atom_to_cond(A, A).

%==========================================================================
% Utility Predicates:
%==========================================================================

%--------------------------------------------------------------------------
% is_member: Check whether an element occurs in a list.
%--------------------------------------------------------------------------

is_member(Elem, [Elem|_]).

is_member(Elem, [_|Rest]) :-
	is_member(Elem, Rest).

%--------------------------------------------------------------------------
% list_append: Concatenate two lists.
%--------------------------------------------------------------------------

% list_append(+List1, +List2, -List12):

list_append([], List2, List2).

list_append([Elem|List1], List2, [Elem|List12]) :-
	list_append(List1, List2, List12).

%--------------------------------------------------------------------------
% list_diff: Compute the Set-Difference of two lists.
%--------------------------------------------------------------------------

% list_diff(+List1, +List2, List12):

list_diff([], _, []).

list_diff([Elem|List1], List2, List12) :-
	is_member(Elem, List2),
	!,
	list_diff(List1, List2, List12).

list_diff([Elem|List1], List2, [Elem|List12]) :-
	% \+ is_member(Elem, List2),
	list_diff(List1, List2, List12).

%--------------------------------------------------------------------------
% list_intersect: Compute the intersection of two lists.
%--------------------------------------------------------------------------

% list_intersect(+List1, +List2, -List12):

list_intersect([], _, []).

list_intersect([Elem|List1], List2, [Elem|List12]) :-
	is_member(Elem, List2),
	!,
	list_intersect(List1, List2, List12).

list_intersect([Elem|List1], List2, List12) :-
	\+ is_member(Elem, List2),
	list_intersect(List1, List2, List12).

%--------------------------------------------------------------------------
% list_add: Add an element to a list if it is not already in it.
%--------------------------------------------------------------------------

% list_add(+Elem, +ListIn, -ListOut):

list_add(Elem, [], [Elem]) :-
	!.

list_add(Elem, [Elem|Rest], [Elem|Rest]) :-
	!.

list_add(Elem, [OtherElem|Rest], [OtherElem|RestWithElem]) :-
	Elem \= OtherElem,
	list_add(Elem, Rest, RestWithElem).

%--------------------------------------------------------------------------
% list_length: List length (number of elements).
%--------------------------------------------------------------------------

% list_length(+List, -Length):

list_length([], 0).

list_length([_|Rest], Length) :-
	list_length(Rest, RestLength),
	Length is RestLength + 1.

%--------------------------------------------------------------------------
% list_prefix: Compute the prefix of a list with a given length.
%--------------------------------------------------------------------------

% list_prefix(+List, +Length, -Prefix):

list_prefix([], _, []).

list_prefix([_|_], 0, []) :-
	!.

list_prefix([Elem|Rest], Length, [Elem|RestPrefix]) :-
	Length >= 1,
	RestLength is Length - 1,
	list_prefix(Rest, RestLength, RestPrefix).

%--------------------------------------------------------------------------
% print_list: Print the list without '[', ']'.
%--------------------------------------------------------------------------

% print_list(+List):

print_list([]).

print_list([Comp]) :-
	write(Comp).

print_list([Comp1, Comp2|Rest]) :-
	write(Comp1),
	write(', '),
	print_list([Comp2|Rest]).

%--------------------------------------------------------------------------
% list_mult(+DNF1, +DNF2, DNF):
%--------------------------------------------------------------------------

% This is used for computing disjunctive and conjunctive normal form.
% The input arguments <DNF1> and <DNF2> are lists of lists.
% The result <DNF> is a list that consists of every list from <DNF1>
% concatenated with every list from <DNF2>.

list_mult([], _, []).

list_mult([Conj|DNF1], DNF2, DNF) :-
	list_concat_every(Conj, DNF2, DNFX),
	list_mult(DNF1, DNF2, DNFY),
	list_append(DNFX, DNFY, DNF).

% list_concat_every(+Conj, +DNF2, -DNF):

list_concat_every(_, [], []).

list_concat_every(Conj1, [Conj2|DNF2], [Conj12|DNF]) :-
	list_append(Conj1, Conj2, Conj12),
	list_concat_every(Conj1, DNF2, DNF).

%--------------------------------------------------------------------------
% yes_no_compl: Compute complement of boolean yes/no value.
%--------------------------------------------------------------------------

% yes_no_compl(+In, +Out):

yes_no_compl(yes, no).
yes_no_compl(no, yes).

%--------------------------------------------------------------------------
% yes_no_disj: Compute disjunction of two boolean yes/no values.
%--------------------------------------------------------------------------

% yes_no_disjunction(+In1, +In2, +Out):

yes_no_disj( no,  no,  no).
yes_no_disj( no, yes, yes).
yes_no_disj(yes,  no, yes).
yes_no_disj(yes, yes, yes).

%--------------------------------------------------------------------------
% yes_no_andnot: Compute "A and not B" of two boolean yes/no values.
%--------------------------------------------------------------------------

% yes_no_andnot(+In1, +In2, +Out):

yes_no_andnot( no,  no,  no).
yes_no_andnot( no, yes,  no).
yes_no_andnot(yes,  no, yes).
yes_no_andnot(yes, yes,  no).

%--------------------------------------------------------------------------
% min: Computes the minimum of two integers.
%--------------------------------------------------------------------------

% min(+N, +M, -Min):

min(N, M, Min) :-
	N =< M,
	!,
	Min = N.

min(_, M, Min) :-
	Min = M.

%--------------------------------------------------------------------------
% max: Computes the maximum of two integers.
%--------------------------------------------------------------------------

% max(+N, +M, -Max):

max(N, M, Max) :-
	N >= M,
	!,
	Max = N.

max(_, M, Max) :-
	Max = M.

%--------------------------------------------------------------------------
% dec_length: Number of digits an integer needs.
%--------------------------------------------------------------------------

% dec_length(+N, -Digits):

dec_length(N, 1) :-
	N < 10,
	N > -10,
	!.

dec_length(N, Length) :-
	M is N / 10,
	dec_length(M, MLength),
	Length is MLength + 1.

%==========================================================================
% Error 1: Inconsistent Condition.
%==========================================================================

% check_err1(+From, +Where):

check_err1(From, Where) :-
	consistent(From, Where, first),
	!.

check_err1(From, Where) :-
	writeln('Warning 1: WHERE-Condition is inconsistent.'),
	% We do the check again, but this time give more information:
	consistent(From, Where, again). % This will fail.

check_err1(_, _) :-
	nl,
	fail.

%==========================================================================
% Error 2: Unnecessary DISTINCT.
%==========================================================================

% check_err2(+Select, +From, +CNF)

% This error can only occur when DISTINCT is specified:
check_err2(all(_), _, _) :-
	!.

check_err2(distinct(_), From, _) :-
	% DISTINCT is always necessary if there is a tuple var without key.
	% This holds even for SELECT DISTINCT *
	\+ err2_every_var_has_key(From),
	!.

check_err2(distinct(star), _, _) :-
	!,
	% err2_every_var_has_key(From),
	check_err2_final([]).
	
check_err2(distinct(SelList), From, CNF) :-
	% err2_every_var_has_key(From),
	sel_attrs(SelList, SelAttrs),
	cnf_to_conj(CNF, Conj),
	const_attrs(Conj, ConstAttrs),
	list_append(SelAttrs, ConstAttrs, UniqueAttrs),
	check_duplicates_iterate(UniqueAttrs, From, Conj,
		[primary, alternate], NewUniqueAttrs),
	non_unique_vars(From, NewUniqueAttrs, NonUniqueVars),
	!,
	check_err2_final(NonUniqueVars).

%--------------------------------------------------------------------------
% check_err2_final: Print error message if list of NonUniqueVars is empty.
%--------------------------------------------------------------------------

% check_err2_final(+NonUniqueVars):

check_err2_final([]) :-
	!,
	writeln('Warning 2: Unnecessary DISTINCT.'),
	write(' =>  This query cannot generate duplicates, even without '),
	writeln('DISTINCT.'),
	writeln('     It you remove DISTINCT, it might run faster.'),
	write('     It is guranteed that the query result will not '),
	writeln('change.'),
	nl,
	fail.

check_err2_final([_|_]).

%--------------------------------------------------------------------------
% err2_every_var_has_key: The relation of every tuple variable has a key.
%--------------------------------------------------------------------------

% err2_every_var_has_key(+From):

err2_every_var_has_key([]).

err2_every_var_has_key([var(Rel,_)|From]) :-
	key(Rel, _, KeyType),
	KeyType \= soft, % i.e. is_member(KeyType, [primary, alternate])
	err2_every_var_has_key(From).

% Note: Error 34 has a predicate check_every_var_has_key which is similar,
%       but prints an error message if a tuple variable has no key.
%       Maybe I should program the key test only once
%       or change the confusingly similar names.

%==========================================================================
% Error 3: Constant Output Column.
%==========================================================================

% check_err3(+Select, +CNF):

check_err3(all(star), _).

check_err3(distinct(star), _).

check_err3(all(TermList), CNF) :-
	constant_attributes(CNF, AttrValList),
	check_err3_select(TermList, AttrValList).

check_err3(distinct(TermList), CNF) :-
	constant_attributes(CNF, AttrValList),
	check_err3_select(TermList, AttrValList).

% check_err3_select(+SelectTermList, +AttrValList):

check_err3_select([], _).

check_err3_select([aref(R,X,A)|_], AttrValList) :-
	is_member(attr_val(aref(R,X,A),Const), AttrValList),
	!,
	writeln('Warning 3: Constant output column.'),
	write(' => '),
	write(R),
	write('.'),
	write(A),
	write(' has the fixed value '),
	print_term(Const),
	nl,
	write('    It seems unnecessary to include it '),
	writeln('in the SELECT list.'),
	nl,
	!,
	fail.

check_err3_select([_|SelectTermList], AttrValList) :-
	check_err3_select(SelectTermList, AttrValList).

%--------------------------------------------------------------------------
% constant_attributes: Return a list of attributes with obvious value.
%--------------------------------------------------------------------------

% constant_attributes(+CNF, +AttrValList) 

constant_attributes(CNF, AttrValList) :-
	equated_to_constant(CNF, InitialAttrValList),
	implied_attr_val(CNF, InitialAttrValList, AttrValList).

%--------------------------------------------------------------------------
% equated_to_constant: Return (A,c) pairs for conditions A=c and c=A.
%--------------------------------------------------------------------------

% equated_to_constant(+CNF, -AttrValList):

equated_to_constant([], []).

equated_to_constant([[comp(eq,aref(Rel,Var,Attr),Const)]|CNF],
			[attr_val(aref(Rel,Var,Attr),Const)|AttrValList]):-
	const(Const),
	!,
	equated_to_constant(CNF, AttrValList).

equated_to_constant([[comp(eq,Const,aref(Rel,Var,Attr))]|CNF],
			[attr_val(aref(Rel,Var,Attr),Const)|AttrValList]):-
	const(Const),
	!,
	equated_to_constant(CNF, AttrValList).

equated_to_constant([_|CNF], AttrValList) :-
	equated_to_constant(CNF, AttrValList).

%--------------------------------------------------------------------------
% const: Check a term whether it is a constant.
%--------------------------------------------------------------------------

% const(+Term):

const(int(_)).

const(str(_)).

%--------------------------------------------------------------------------
% implied_attr_val: Compute the fixpoint of known attr values wrt A=B.
%--------------------------------------------------------------------------

% implied_attr_val(+CNF, +CurrentAttrValList, FinalAttrValList):

implied_attr_val(CNF, CurrentAttrValList, FinalAttrValList) :-
	must_be_equal(CNF, Attr1, Attr2),
	is_member(attr_val(Attr1,Const), CurrentAttrValList),
	\+ is_member(attr_val(Attr2,Const), CurrentAttrValList),
	!,
	implied_attr_val(CNF, [attr_val(Attr2,Const)|CurrentAttrValList],
		FinalAttrValList).

implied_attr_val(_, AttrValList, AttrValList).

% must_be_equal(+CNF,?Attr1,?Attr2):

must_be_equal([[comp(eq,Attr1,Attr2)]|_], Attr1, Attr2).

must_be_equal([[comp(eq,Attr2,Attr1)]|_], Attr1, Attr2).

must_be_equal([_|CNF], Attr1, Attr2) :-
	must_be_equal(CNF, Attr1, Attr2).

%==========================================================================
% Error 4: Duplicate Output Column
%==========================================================================

% check_err4(+Select, +CNF):

% SELECT * does not generate an error:
check_err4(distinct(star), _) :-
	!.

check_err4(all(star), _) :-
	!.

check_err4(distinct(SelList), CNF) :-
	check_err4_double(SelList),
	equal_attrs(CNF, AttrPairs),
	check_err4_pairs(AttrPairs, SelList).

check_err4(all(SelList), CNF) :-
	check_err4_double(SelList),
	equal_attrs(CNF, AttrPairs),
	check_err4_pairs(AttrPairs, SelList).

%--------------------------------------------------------------------------
% check_err4_pairs: Do equal attributes appear in the SELECT list?
%--------------------------------------------------------------------------

% check_err4_pairs(+AttrPairs, +SelList).

check_err4_pairs([], _).

check_err4_pairs([eq(A,B)|MoreEquations], SelList) :-
	check_err4_pair(A, B, SelList),
	check_err4_pairs(MoreEquations, SelList).

% check_err4_pair(+AttrA, +AttrB, +SelList):

check_err4_pair(A, B, SelList) :-
	A \= B,
	is_member(A, SelList),
	is_member(B, SelList),
	!,
	writeln('Warning 4: Duplicate Output Column.'),
	write(' => '),
	write('The following SELECT terms are always equal: '),
	print_term(A),
	write(', '),
	print_term(B),
	write('.'),
	nl,
	nl,
	fail.

% All other cases are ok:
check_err4_pair(_, _, _).

%--------------------------------------------------------------------------
% check_err4_double: Print warnings for double terms in the SELECT list.
%--------------------------------------------------------------------------

% check_err4_double(+SelList).

check_err4_double([]).

check_err4_double([Term|Rest]) :-
	is_member(Term, Rest),
	!,
	writeln('Warning 4: Duplicate Output Column.'),
	write(' => '),
	write('The following terms appears twice in the SELECT list: '),
	print_term(Term),
	write('.'),
	nl,
	nl,
	fail.

check_err4_double([_|Rest]) :-
	check_err4_double(Rest).

%--------------------------------------------------------------------------
% equal_attrs: Determine pairs of attributes that must be equal:
%--------------------------------------------------------------------------

% equal_attrs(+CNF, -ImpliedEquations):

equal_attrs(CNF, ImpliedEquations) :-
	equations(CNF, InitialEquations),
	eq_closure(InitialEquations, ImpliedEquations).

%--------------------------------------------------------------------------
% equations: Select equations between attributes from a CNF condition.
%--------------------------------------------------------------------------

% equations(+CNF, -Equations):

equations([], []).

equations([[comp(eq,aref(R,X,A),aref(S,Y,B))]|CNF],
		[eq(aref(R,X,A),aref(S,Y,B))|Equations]) :-
	!,
	equations(CNF, Equations).

equations([_|CNF], Equations) :-
	equations(CNF, Equations).

%--------------------------------------------------------------------------
% eq_closure: Compute implied equations (commutativity and transitativity).
%--------------------------------------------------------------------------

% eq_closure(+Input, -Output):

eq_closure(Input, Output) :-
	is_member(eq(A,B), Input),
	\+ is_member(eq(B,A), Input),
	!,
	eq_closure([eq(B,A)|Input], Output).

eq_closure(Input, Output) :-
	is_member(eq(A,B), Input),
	is_member(eq(B,C), Input),
	A \= C,
	\+ is_member(eq(A,C), Input),
	!,
	eq_closure([eq(A,C)|Input], Output).

eq_closure(Final, Final).

%==========================================================================
% Error 5: Unused Tuple Variables.
%==========================================================================

% check_err5(+Select, +From, +Where):

check_err5(all(star), _, _) :-
	!.

check_err5(distinct(star), _, _) :-
	!.

check_err5(Select, From, Where) :-
	used_vars_select(Select, [], VarsSelect),
	used_vars_cond(Where, VarsSelect, UsedVars),
	list_diff(From, UsedVars, UnusedVars),
	check_err5(UnusedVars).

% check_err5(+UnusedVars):

check_err5([]).

check_err5([Var|MoreVars]) :-
	writeln('Warning 5: Unused Tuple Variables.'),
	write('    '),
	write('The following variables are declared, but not accessed: '),
	print_from([Var|MoreVars]),
	nl,
	nl,
	fail.
	
% used_vars_select(+Select, +VarsIn, -VarsOut):

used_vars_select(all(TermList),  VarsIn, VarsOut) :-
	used_vars_term_list(TermList, VarsIn, VarsOut).

used_vars_select(distinct(TermList),  VarsIn, VarsOut) :-
	used_vars_term_list(TermList, VarsIn, VarsOut).

% used_vars_term_list(+TermList, +VarsIn, -VarsOut):

used_vars_term_list([], Vars, Vars).

used_vars_term_list([Term|TermList], VarsIn, VarsOut) :-
	used_vars_term(Term, VarsIn, Vars),
	used_vars_term_list(TermList, Vars, VarsOut).

% used_vars_term(+Term, +VarsIn, -VarsOut).

used_vars_term(int(_), Vars, Vars).

used_vars_term(str(_), Vars, Vars).

used_vars_term(aref(R,X,_), Vars, Vars) :-
	is_member(var(R,X), Vars),
	!.

used_vars_term(aref(R,X,_), Vars, [var(R,X)|Vars]).

% used_vars_cond(+Where, +VarsIn, -VarsOut):

used_vars_cond(true, Vars, Vars).

used_vars_cond(comp(_,Term1,Term2), VarsIn, VarsOut) :-
	used_vars_term(Term1, VarsIn, Vars),
	used_vars_term(Term2, Vars, VarsOut).

used_vars_cond(exists(_,_,_), Vars, Vars).
	% Variables that are declared in the main query but used only
	% in the subquery count here as unused.
	% This situation should generate a warning,
	% but we probably should use a different text than simply
	% "unused tuple variable".

used_vars_cond(not_exists(_,_,_), Vars, Vars).
	% Variables that are declared in the main query but used only
	% in the subquery count here as unused.
	% This situation should generate a warning,
	% but we probably should use a different text than simply
	% "unused tuple variable".

used_vars_cond(not(Cond), VarsIn, VarsOut) :-
	used_vars_cond(Cond, VarsIn, VarsOut).

used_vars_cond(and(Cond1,Cond2), VarsIn, VarsOut) :-
	used_vars_cond(Cond1, VarsIn, Vars),
	used_vars_cond(Cond2, Vars, VarsOut).

used_vars_cond(or(Cond1,Cond2), VarsIn, VarsOut) :-
	used_vars_cond(Cond1, VarsIn, Vars),
	used_vars_cond(Cond2, Vars, VarsOut).

%==========================================================================
% Error 8: Implied, Tautological, or Inconsistent Subconditions.
%==========================================================================

% check_err8(+From, +DNF):

check_err8(_, [[]]) :-
	!.

check_err8(From, DNF) :-
	check_err8a(From, DNF),
	check_err8b(From, DNF, [], DNF),
	check_err8c(From, DNF, []).

%--------------------------------------------------------------------------
% check_err8a: Check for tautological WHERE-condition.
%--------------------------------------------------------------------------

% check_err8a(+From, +DNF):

check_err8a(_, [[]]) :-
	!.

check_err8a(From, DNF) :-
	dnf_to_cond(DNF,Cond),
	consistent(From, not(Cond), other),
	!.

check_err8a(_, _) :-
	writeln('Warning 8a: Tautological condition.'),
	write(' => The WHERE condition is not necessary '),
	writeln('(it is always true).'),
	nl,
	fail.

%--------------------------------------------------------------------------
% check_err8b: Check whether part of disjunction can be replaced by false.
%--------------------------------------------------------------------------

% check_err8b(+From, +DNFPart1, +DNFPart2, +OrigDNF):

% This is only the loop over all elements in the disjunction.
check_err8b(_, [], _, _).

check_err8b(From, [Conj|DNF1], DNF2, OrigDNF) :-
	list_append(DNF1, DNF2, Context),
	check_err8b_test(From, Conj, Context, OrigDNF),
	check_err8b(From, DNF1, [Conj|DNF2], OrigDNF).

% check_err8b_test(From, Conj, Context, DNF):

check_err8b_test(_, _, [], _) :-
	% Without disjunctive context,
	% this would be Error 1 (inconsistent condition).
	% Was already tested above.
	!.

check_err8b_test(From, Conj, Context, _) :-
	dnf_to_cond(Context, F),
	conj_to_cond(Conj, G),
	consistent(From, and(G, not(F)), other),
	!.

check_err8b_test(_, Conj, _, DNF) :-
	writeln('Warning 8b: Unnecessary Logical Complication.'),
	writeln(' => The condition'),
	write('        '),
	print_conj(Conj),
	nl,
	writeln('    is unnecessary in the disjunction'),
	write('        '),
	print_dnf(DNF),
	nl,
	nl,
	fail.

%--------------------------------------------------------------------------
% check_err8c: Check whether atomic formula can be replaced by true.
%--------------------------------------------------------------------------

% check_err8c(+From, +DNFPart1, +DNFPart2):

% This is only the loop over all elements in the disjunction.
check_err8c(_, [], _).

check_err8c(From, [Conj|DNF1], DNF2) :-
	list_append(DNF1, DNF2, Context),
	check_err8c_2(From, Conj, [], Conj, Context),
	check_err8c(From, DNF1, [Conj|DNF2]).

% check_err8c_2(+From, +ConjPart1, +ConjPart2, +OrigConj, +DisContext):

check_err8c_2(_, [], _, _, _).

check_err8c_2(From, [Atom|Conj1], Conj2, OrigConj, DisContext) :-
	list_append(Conj1, Conj2, Conj),
	check_err8c_3(From, Atom, Conj, OrigConj, DisContext),
	check_err8c_2(From, Conj1, [Atom|Conj2], OrigConj, DisContext).

% check_err8c_3(+From, +Atom, +Conj, +OrigConj, +DisContext):

check_err8c_3(_, _, [], _, _) :-
	% If conj context is empty (true), this was already tested in 8b.
	!.

check_err8c_3(From, Atom, Conj, OrigConj, []) :-
	!,
	% Simplified version without disjunctive context.
	check_err8c_test1(From, Atom, Conj, OrigConj).

check_err8c_3(From, Atom, Conj, OrigConj, DisContext) :-
	!,
	% General version:
	check_err8c_test2(From, Atom, Conj, OrigConj, DisContext).

% check_err8c_test1(+From, +Atom, +Conj, +OrigConj):

check_err8c_test1(From, Atom, Conj, _) :-
	dnf_atom_to_cond(Atom, A), % not_exists -> not(exists ...)
	conj_to_cond(Conj, F),
	consistent(From, and(not(A),F), other),
	!.

check_err8c_test1(_, Atom, _, OrigConj) :-
	writeln('Warning 8c: Unnecessary Logical Complication.'),
	writeln(' => The condition'),
	write('        '),
	print_atomic_formula(Atom),
	nl,
	writeln('    is unnecessary in the conjunction'),
	write('        '),
	print_conj(OrigConj),
	nl,
	nl,
	fail.

% check_err8c_test2(+From, +Atom, +Conj, +OrigConj, +DisContext):

check_err8c_test2(From, Atom, Conj, _, DisContext) :-
	dnf_atom_to_cond(Atom, A), % not_exists(...) -> not(exists(...))
	dnf_to_cond(DisContext, F),
	conj_to_cond(Conj, G),
	consistent(From, and(not(A),and(G,not(F))), other),
	!.

check_err8c_test2(_, Atom, _, OrigConj, DisContext) :-
	writeln('Warning 8c: Unnecessary Logical Complication.'),
	writeln(' => The condition'),
	write('        '),
	print_atomic_formula(Atom),
	nl,
	writeln('    is unnecessary in the conjunction'),
	write('        '),
	print_conj(OrigConj),
	nl,
	writeln('    given the disjunctive context'),
	write('        '),
	print_dnf(DisContext),
	nl,
	nl,
	fail.

%==========================================================================
% Error 26: Missing Join Conditions.
%==========================================================================

%--------------------------------------------------------------------------
% check_err26: Simple test for missing join conditions.
%--------------------------------------------------------------------------

% check_err26(+From, +DNF):

check_err26(_, []).

check_err26(From, [Conjunction|DNF]) :-
	make_singletons(From, EqClasses),
	check_err26_conj(EqClasses, Conjunction, FinEqClasses),
	check_err26_test(FinEqClasses),
	check_err26(From, DNF).

% check_err26_conj(+EqClasses, +Conjunction, -FinEqClasses):

check_err26_conj(EqClasses, [], EqClasses).

check_err26_conj(EqClasses, [Cond|Conj], FinEqClasses) :-
	check_err26_cond(EqClasses, Cond, NewEqClasses),
	check_err26_conj(NewEqClasses, Conj, FinEqClasses).

% check_err26_cond(+EqClasses, +Cond, -FinEqClasses):

check_err26_cond(EqClasses, comp(eq, aref(_,X,_), aref(_,Y,_)),
			NewEqClasses) :-
	X \= Y,
	!,
	merge_eq_classes(X, Y, EqClasses, NewEqClasses).

check_err26_cond(EqClasses, _, EqClasses).

% check_err26_test(+FinEqClasses):

% There must be only one equivalence class at the end:
check_err26_test([_]) :-
	!.

check_err26_test(EqClasses) :-
	writeln('Warning 26: Missing join conditions.'),
	write('    Connected components: '),
	print_list(EqClasses),
	writeln('.'),
	nl,
	fail.

%--------------------------------------------------------------------------
% make_singletons: Put each variable into its own new equivalence class.
%--------------------------------------------------------------------------

%make_singletons(+FromList, -ListOfSingletonVarLists):

make_singletons([], []).

make_singletons([var(_,Var)|MoreVarDecls], [[Var]|MoreSingletons]) :-
	make_singletons(MoreVarDecls, MoreSingletons).

%--------------------------------------------------------------------------
% merge_eq_classes: Merge equivalence classes of two variables.
%--------------------------------------------------------------------------

% merge_eq_classes(+Var1, +Var2, +CurrentClasses, -NewClasses):

% Case when the two variables are already in the same equivalence class:
merge_eq_classes(Var1, Var2, CurrentClasses, CurrentClasses) :-
	extract_containing_class(Var1, CurrentClasses, Class, _),
	is_member(Var2, Class),
	!.

merge_eq_classes(Var1, Var2, CurrentClasses, [NewClass|Rest2]) :-
	extract_containing_class(Var1, CurrentClasses, Class1, Rest1),
	extract_containing_class(Var2, Rest1, Class2, Rest2),
	list_append(Class1, Class2, NewClass).

%--------------------------------------------------------------------------
% extract_containing_class: Find equivalence class of a given member.
%--------------------------------------------------------------------------

% extract_containing_class(+Var, +ClassList, -Class, -RestList):

extract_containing_class(Var, [Class|MoreClasses], Class, MoreClasses) :-
	is_member(Var, Class),
	!.

extract_containing_class(Var, [OtherClass|MoreClasses], Class,
				[OtherClass|RestList]) :-
	extract_containing_class(Var, MoreClasses, Class, RestList).

%==========================================================================
% Error 34: Many Duplicates:
%==========================================================================

% Note: Only duplicates are found that occur within a single conjunction
% in the DNF. Of course, the disjunctive combination could also cause
% duplicates. No warning is printed in this case.

%--------------------------------------------------------------------------
% check_err34: Simple test for missing DISTINCT or GROUP BY.
%--------------------------------------------------------------------------

% check_err34(+Select, +From, +DNF):

% Of course, this error cannot occur when DISTINCT is specified:
check_err34(distinct(_), _, _) :-
	!.

check_err34(all(star), From, _) :-
	!,
	check_every_var_has_key(From),
	!.

check_err34(all(SelList), From, DNF) :-
	SelList \= star,
	check_every_var_has_key(From),
	check_err34_dnf(SelList, From, DNF),
	!.

%--------------------------------------------------------------------------
% check_every_var_has_key: The relation of every tuple variable needs a key
%--------------------------------------------------------------------------

% check_every_var_has_key(+From):

check_every_var_has_key([]).

check_every_var_has_key([var(Rel,_)|From]) :-
	check_rel_has_key(Rel),
	check_every_var_has_key(From).

% check_rel_has_key(+Rel):

check_rel_has_key(Rel) :-
	key(Rel, _, _),
	!.

check_rel_has_key(Rel) :-
	writeln('Warning 34a: There might be duplicate result tuples'),
	write('    Relation '),
	write(Rel),
	writeln(' has no declared key.'),
	fail.

%--------------------------------------------------------------------------
% check_err34_dnf: Simple test for missing DISTINCT or GROUP BY.
%--------------------------------------------------------------------------

% check_err34_dnf(+SelList, +From, +DNF):

check_err34_dnf(_, _, []).

check_err34_dnf(SelList, From, [Conj|DNF]) :-
	check_err34_conj(SelList, From, Conj),
	check_err34_dnf(SelList, From, DNF).

%--------------------------------------------------------------------------
% check_err34_conj: Simple test for missing DISTINCT or GROUP BY.
%--------------------------------------------------------------------------

% check_err34_conj(+SelList, +From, +Conj):

check_err34_conj(SelList, From, Conj) :-
	sel_attrs(SelList, SelAttrs),
	const_attrs(Conj, ConstAttrs),
	list_append(SelAttrs, ConstAttrs, UniqueAttrs),
	check_duplicates_iterate(UniqueAttrs, From, Conj,
		[primary, alternate, soft], NewUniqueAttrs),
	non_unique_vars(From, NewUniqueAttrs, NonUniqueVars),
	check_err34_final(NonUniqueVars).

%--------------------------------------------------------------------------
% sel_attrs: Initialize UniqueAttrs with attributes from SELECT.
%--------------------------------------------------------------------------

sel_attrs([], []).

sel_attrs([aref(Rel,Var,Attr)|SelList], [aref(Rel,Var,Attr)|UniqueAttrs])
	:-
	!,
	sel_attrs(SelList, UniqueAttrs).

sel_attrs([int(_)|SelList], UniqueAttrs)
	:-
	!,
	sel_attrs(SelList, UniqueAttrs).

sel_attrs([str(_)|SelList], UniqueAttrs)
	:-
	!,
	sel_attrs(SelList, UniqueAttrs).

%--------------------------------------------------------------------------
% const_attrs: Return list of attributes bound to a constant.
%--------------------------------------------------------------------------

const_attrs([], []).

const_attrs([comp(eq,aref(Rel,Var,Attr),int(_))|Conj],
		[aref(Rel,Var,Attr)|Attrs]) :-
	!,
	const_attrs(Conj, Attrs).

const_attrs([comp(eq,aref(Rel,Var,Attr),str(_))|Conj],
		[aref(Rel,Var,Attr)|Attrs]) :-
	!,
	const_attrs(Conj, Attrs).

const_attrs([comp(eq,int(_),aref(Rel,Var,Attr))|Conj],
		[aref(Rel,Var,Attr)|Attrs]) :-
	!,
	const_attrs(Conj, Attrs).

const_attrs([comp(eq,str(_),aref(Rel,Var,Attr))|Conj],
		[aref(Rel,Var,Attr)|Attrs]) :-
	!,
	const_attrs(Conj, Attrs).

const_attrs([_|Conj], Attrs) :-
	const_attrs(Conj, Attrs).

%--------------------------------------------------------------------------
% check_duplicates_iterate: Add unique attributes as long as possible:
%--------------------------------------------------------------------------

% check_duplicates_iterate(+UniqueAttrs, +FromList, +Conj, +KeyTypes,
%				-FinalUAttrs):

check_duplicates_iterate(UniqueAttrs, FromList, Conj, KeyTypes,
			FinalUniqueAttrs) :-
	add_unique_attr(UniqueAttrs, FromList, Conj, KeyTypes,
			NewUniqueAttrs),
	!,
	check_duplicates_iterate(NewUniqueAttrs, FromList, Conj, KeyTypes,
		FinalUniqueAttrs).

% Fixpoint reached:
check_duplicates_iterate(UniqueAttrs, _, _, _, UniqueAttrs).

%--------------------------------------------------------------------------
% add_unique_attr: Add a new uniquely determined attribute to UniqueAttrs.
%--------------------------------------------------------------------------

% add_unique_attr(+UniqueAttrs, +FromList, +Conj, +KeyTypes,
%			-NewUniqueAttrs):

add_unique_attr(UniqueAttr, FromList, _, KeyTypes,
		[aref(Rel,Var,Attr)|UniqueAttr])
	:-
	is_member(var(Rel,Var), FromList),
	key(Rel, KeyCols, KeyType),
	is_member(KeyType, KeyTypes),
	contains_key(Var, KeyCols, UniqueAttr),
	column(Rel, Attr, _, _),
	\+ is_member(aref(Rel,Var,Attr), UniqueAttr).

add_unique_attr(UniqueAttr, _, Conj, _, [aref(S,Y,B)|UniqueAttr]) :-
	is_member(aref(R,X,A), UniqueAttr),
	is_member(comp(eq,aref(R,X,A),aref(S,Y,B)), Conj),
	\+ is_member(aref(S,Y,B), UniqueAttr).

add_unique_attr(UniqueAttr, _, Conj, _, [aref(S,Y,B)|UniqueAttr]) :-
	is_member(aref(R,X,A), UniqueAttr),
	is_member(comp(eq,aref(S,Y,B),aref(R,X,A)), Conj),
	\+ is_member(aref(S,Y,B), UniqueAttr).
	
% contains_key(+Var, +KeyCols, +UniqueAttr):

contains_key(_, [], _).

contains_key(Var, [Col|KeyCols], UniqueAttr) :-
	is_member(aref(_,Var,Col), UniqueAttr),
	contains_key(Var, KeyCols, UniqueAttr).

%--------------------------------------------------------------------------
% non_unique_vars: Tuple vars of which not all attributes have unique value
%--------------------------------------------------------------------------

% non_unique_vars(+From, +UniqueAttrs, -NonUniqueVars):

non_unique_vars([], _, []).

non_unique_vars([var(Rel,Var)|From], UniqueAttrs, [Var|NonUniqueVars]) :-
	column(Rel, Attr, _, _),
	\+ is_member(aref(Rel,Var,Attr), UniqueAttrs),
	!,
	non_unique_vars(From, UniqueAttrs, NonUniqueVars).

non_unique_vars([_|From], UniqueAttrs, NonUniqueVars) :-
	non_unique_vars(From, UniqueAttrs, NonUniqueVars).

%--------------------------------------------------------------------------
% check_err34_final(NonUniqueVars).
%--------------------------------------------------------------------------

% check_err34_final(+NonUniqueVars):

check_err34_final([]).

check_err34_final([Var|Vars]) :-
	writeln('Warning 34b: Query might produce duplicates.'),
	write('    Tuple variables that might have different values '),
	write('for a given result: '),
	print_list([Var|Vars]),
	writeln('.'),
	write('    If duplicates are intended, '),
	write('consider defining a soft key.'),
	nl,
	nl,
	fail.

%==========================================================================
% Error 39: Difficult Type Conversions.
%==========================================================================

%--------------------------------------------------------------------------
% check_err39: Check whether there are comparisons between string and int.
%--------------------------------------------------------------------------

% check_err39(+Where):

check_err39(true).

check_err39(and(F,G)) :-
	check_err39(F),
	check_err39(G).

check_err39(or(F,G)) :-
	check_err39(F),
	check_err39(G).

check_err39(not(F)) :-
	check_err39(F).

check_err39(comp(Op,Term1,Term2)) :-
	check_err39_type(Term1, Type1),
	check_err39_type(Term2, Type2),
	check_err39_types_equal(Type1, Type2, comp(Op,Term1,Term2)).

check_err39(exists(_,_,Where)) :-
	check_err39(Where).

check_err39(not_exists(_,_,Where)) :-
	check_err39(Where).

%--------------------------------------------------------------------------
% check_err39_type: Determine general type of term (int or str).
%--------------------------------------------------------------------------

% check_err39_type(+Term, -Type).

check_err39_type(int(_), int).

check_err39_type(str(_), str).

check_err39_type(aref(Rel,_,Attr), int) :-
	column(Rel, Attr, numeric(_,0), _).

check_err39_type(aref(Rel,_,Attr), str) :-
	column(Rel, Attr, varchar(_), _).

check_err39_type(aref(Rel,_,Attr), str) :-
	column(Rel, Attr, char(_), _).

%--------------------------------------------------------------------------
% check_err39_types_equal: Print warning 39 if types are different.
%--------------------------------------------------------------------------

% check_err39_types_equal(+Type1, +Type2, +Cond).

check_err39_types_equal(Type, Type, _) :-
	!.

check_err39_types_equal(Type1, Type2, Cond) :-
	Type1 \= Type2,
	writeln('Warning 39: Questionable Type Conversion.'),
	write(' =>  Comparison between string and number in '),
	print_atomic_formula(Cond),
	writeln('.'),
	nl,
	fail.

%==========================================================================
% Consistency Check (Main Routine):
%==========================================================================

% consistent(+From, +Where, +Call):

% <Call> determines from where the consistency check is called
% (what is the reason or application of the consistency check):
% - "first": Consistency check for the WHERE condition (error 1).
%            If option "show_model" is set, the model must be printed.
% - "again": The consistency check is done only for printing an explanation
%            why the WHERE condition is inconsistent.
% - "other": E.g. for error 8 (unnecessary logical complications).
%            Output is only done if option "show_cons_check" is set.

consistent(From, Where, Call) :-
	verbose_output(Call, ShowConsCheck, ShowModelSearch, ShowModel),
	print_cons_check(ShowConsCheck, From, Where),
	optionally_skolemize(From, Where, ShowConsCheck, FlatForm),
	print_model_search(ShowConsCheck),
	eliminate_not(FlatForm, FlatFormNoNot),
	dnf(FlatFormNoNot, FlatFormDNF),
	consistent_dnf(FlatFormDNF, ShowModelSearch, ShowModel).
	%print_nl(ShowConsCheck).

% Consistency check failed:
consistent(_, _, Call) :-
	Call \= again, % The user knows already that it is inconsistent
	option(show_cons_check, ShowConsCheck),
	print_inconsistent(ShowConsCheck),
	fail.

%--------------------------------------------------------------------------
% verbose_output: What elements of verbose output should be printed?
%--------------------------------------------------------------------------

% verbose_output(+Call, -ShowConsCheck, -ShowModelSearch, -ShowModel)

verbose_output(first, yes, yes, yes) :-
	option(show_cons_check, yes).

verbose_output(first, no, no, yes) :-
	option(show_cons_check, no),
	option(show_model, yes).

verbose_output(first, no, no, no) :-
	option(show_cons_check, no),
	option(show_model, no).

verbose_output(again, no, yes, no).

verbose_output(other, yes, yes, yes) :-
	option(show_cons_check, yes).

verbose_output(other, no, no, no) :-
	option(show_cons_check, no).

%--------------------------------------------------------------------------
% optionally_skolemize: Skolemize a formula if it contains subqueries.
%--------------------------------------------------------------------------

% optionally_skolemize(+From, +Where, +Verbose, -FlatForm):

optionally_skolemize(From, Where, Verbose, FlatForm) :-
	contains_subqueries(Where),
	!,
	skolemize(From, Where, Verbose, FlatForm).

optionally_skolemize(_, Where, _, Where).

%--------------------------------------------------------------------------
% contains_subqueries: Check whether Skolemization is needed.
%--------------------------------------------------------------------------

% contains_subqueries(+Where):

contains_subqueries(exists(_,_,_)).

contains_subqueries(not(Cond)) :-
	contains_subqueries(Cond).

contains_subqueries(and(Cond1,_)) :-
	contains_subqueries(Cond1).

contains_subqueries(and(_,Cond2)) :-
	contains_subqueries(Cond2).

contains_subqueries(or(Cond1,_)) :-
	contains_subqueries(Cond1).

contains_subqueries(or(_,Cond2)) :-
	contains_subqueries(Cond2).

%--------------------------------------------------------------------------
% print_cons_check: Print query for which consistency check is called.
%--------------------------------------------------------------------------

% print_cons_check(+ShowConsCheck, +From, +Where):

print_cons_check(yes, From, Where) :-
	nl,
	writeln('*** Consistency Check called for:'),
	writeln('    SELECT ...'),
	write('    FROM '),
	print_from(From),
	nl,
	write('    WHERE '),
	print_cond(Where),
	nl,
	nl.

print_cons_check(no, _, _).

%--------------------------------------------------------------------------
% print_model_search: Print headline for model search.
%--------------------------------------------------------------------------

% print_model_search(+ShowConsCheck):

print_model_search(yes) :-
	writeln('Model Search Details:').

print_model_search(no).

%--------------------------------------------------------------------------
% print_nl: Conditionally print a newline.
%--------------------------------------------------------------------------

% print_nl(+YesNo):

print_nl(yes) :-
	nl.

print_nl(no).

%--------------------------------------------------------------------------
% print_inconsistent: Conditionally print message 'Inconsistent'.
%--------------------------------------------------------------------------

% print_inconsistent(+YesNo):

print_inconsistent(yes) :-
	writeln('  Inconsistent.'),
	nl.

print_inconsistent(no).

%==========================================================================
% Skolemization:
%==========================================================================

% skolemize(+From, +Where, +Verbose, -FlatForm):

skolemize(From, Where, yes, FlatForm) :-
	skolem_functions(From, Where, SkolemFunctions),
	write('Skolem Functions:'),
	nl,
	print_skolem_functions(SkolemFunctions),
	nl,
	skolem_universe(SkolemFunctions, CycleSorts, SkolemUniverse),
	write('Skolem Universe:'),
	nl,
	print_skolem_universe(SkolemUniverse),
	nl,
	flat_form(From, Where, SkolemFunctions, SkolemUniverse,
		CycleSorts, FlatForm),
	write('Flat Form:'),
	nl,
	write('    '),
	print_cond(FlatForm),
	nl,
	nl.

skolemize(From, Where, no, FlatForm) :-
	skolem_functions(From, Where, SkolemFunctions),
	skolem_universe(SkolemFunctions, CycleSorts, SkolemUniverse),
	flat_form(From, Where, SkolemFunctions, SkolemUniverse,
		CycleSorts, FlatForm).

%--------------------------------------------------------------------------
% skolem_functions: Determine list of Skolem functions for a given query.
%--------------------------------------------------------------------------

% skolem_functions(+From, +Where, -Skolem):

skolem_functions(From, Where, Skolem) :-
	skolem_functions_from(From, [], Where, [], Skolem1),
	skolem_functions_exists(Where, [], Skolem1, Skolem).

%--------------------------------------------------------------------------
% skolem_functions_from: Compute Skolem functions for FROM clause.
%--------------------------------------------------------------------------

% This assumes that the variables in the FROM clause are existential
% variables, i.e. the FROM clause is nested inside an even number of NOTs
% or at the outermost level.
% <UnivVars> is the list of universal variables declared in FROM clauses
% in outer queries.

% skolem_functions_from(+From, +UnivVars, +Where, +SkolemIn, -SkolemOut)

skolem_functions_from([], _, _, Skolem, Skolem).

skolem_functions_from([var(Rel,Var)|From], UnivVars, Where, SkolemIn,
			SkolemOut) :-
	occurring_vars_cond(Where, VarsOccur),
	from_subset(UnivVars, VarsOccur, UnivVarsOccur),
	skolem_functions_from(From, UnivVars, Where,
			[skolem(Var,UnivVarsOccur,Rel)|SkolemIn],
			SkolemOut).

%--------------------------------------------------------------------------
% from_subset: Select subset of from clause where variables occur in list.
%--------------------------------------------------------------------------

% from_subset(+From, +Vars, +FromSubset):

from_subset([], _, []).

from_subset([var(Rel,Var)|From], Vars, [var(Rel,Var)|FromSubset]) :-
	is_member(Var, Vars),
	!,
	from_subset(From, Vars, FromSubset).

from_subset([var(_,Var)|From], Vars, FromSubset) :-
	\+ is_member(Var, Vars),
	from_subset(From, Vars, FromSubset).

%--------------------------------------------------------------------------
% skolem_functions_exists: Skolem functions for subqueries (not negated).
%--------------------------------------------------------------------------

% <UnivVars> is the list of universal variables declared in FROM clauses
% in outer queries.

% skolem_functions_exists(+Where, +UnivVars, +SkolemIn, -SkolemOut):

skolem_functions_exists(true, _, Skolem, Skolem).

skolem_functions_exists(comp(_,_,_), _, Skolem, Skolem).

skolem_functions_exists(not(Cond), UnivVars, SkolemIn, SkolemOut) :-
	skolem_functions_all(Cond, UnivVars, SkolemIn, SkolemOut).

skolem_functions_exists(and(Cond1,Cond2), UnivVars, SkolemIn, SkolemOut) :-
	skolem_functions_exists(Cond1, UnivVars, SkolemIn, Skolem),
	skolem_functions_exists(Cond2, UnivVars, Skolem, SkolemOut).

skolem_functions_exists(or(Cond1,Cond2), UnivVars, SkolemIn, SkolemOut) :-
	skolem_functions_exists(Cond1, UnivVars, SkolemIn, Skolem),
	skolem_functions_exists(Cond2, UnivVars, Skolem, SkolemOut).

skolem_functions_exists(exists(_,From,Where), UnivVars, SkolemIn,
		SkolemOut) :-
	skolem_functions_from(From, UnivVars, Where, SkolemIn, Skolem),
	skolem_functions_exists(Where, UnivVars, Skolem, SkolemOut).

%--------------------------------------------------------------------------
% skolem_functions_all: Skolem functions for subqueries (inside not).
%--------------------------------------------------------------------------

% <UnivVars> is the list of universal variables declared in FROM clauses
% in outer queries.

% skolem_functions_all(+Where, +UnivVars, +SkolemIn, -SkolemOut):

skolem_functions_all(true, _, Skolem, Skolem).

skolem_functions_all(comp(_,_,_), _, Skolem, Skolem).

skolem_functions_all(not(Cond), UnivVars, SkolemIn, SkolemOut) :-
	skolem_functions_exists(Cond, UnivVars, SkolemIn, SkolemOut).

skolem_functions_all(and(Cond1,Cond2), UnivVars, SkolemIn, SkolemOut) :-
	skolem_functions_all(Cond1, UnivVars, SkolemIn, Skolem),
	skolem_functions_all(Cond2, UnivVars, Skolem, SkolemOut).

skolem_functions_all(or(Cond1,Cond2), UnivVars, SkolemIn, SkolemOut) :-
	skolem_functions_all(Cond1, UnivVars, SkolemIn, Skolem),
	skolem_functions_all(Cond2, UnivVars, Skolem, SkolemOut).

skolem_functions_all(exists(_,From,Where), UnivVars, SkolemIn, SkolemOut):-
	list_append(UnivVars, From, NewUnivVars),
	skolem_functions_all(Where, NewUnivVars, SkolemIn, SkolemOut).

%--------------------------------------------------------------------------
% occurring_vars_cond: Returns list of variables that occur in WHERE clause
%--------------------------------------------------------------------------

% occurring_vars_cond(+Where, -VarList):

occurring_vars_cond(Where, VarList) :-
	occurring_vars_cond(Where, [], VarList).

% occurring_vars_cond(+Where, +VarsIn, -VarsOut):

occurring_vars_cond(true, Vars, Vars).

occurring_vars_cond(comp(_,Term1,Term2), VarsIn, VarsOut) :-
	occurring_vars_term(Term1, VarsIn, Vars),
	occurring_vars_term(Term2, Vars, VarsOut).

occurring_vars_cond(exists(_,_,Where), VarsIn, VarsOut) :-
	occurring_vars_cond(Where, VarsIn, VarsOut).

occurring_vars_cond(not_exists(_,_,Where), VarsIn, VarsOut) :-
	occurring_vars_cond(Where, VarsIn, VarsOut).

occurring_vars_cond(not(Cond), VarsIn, VarsOut) :-
	occurring_vars_cond(Cond, VarsIn, VarsOut).

occurring_vars_cond(and(Cond1,Cond2), VarsIn, VarsOut) :-
	occurring_vars_cond(Cond1, VarsIn, Vars),
	occurring_vars_cond(Cond2, Vars, VarsOut).

occurring_vars_cond(or(Cond1,Cond2), VarsIn, VarsOut) :-
	occurring_vars_cond(Cond1, VarsIn, Vars),
	occurring_vars_cond(Cond2, Vars, VarsOut).

% occurring_vars_term(+Term, +VarsIn, -VarsOut):

occurring_vars_term(int(_), Vars, Vars).

occurring_vars_term(str(_), Vars, Vars).

occurring_vars_term(aref(_,Var,_), VarsIn, VarsOut) :-
	list_add(Var, VarsIn, VarsOut).

%--------------------------------------------------------------------------
% print_skolem_functions: Print list of Skolem functions.
%--------------------------------------------------------------------------

% print_skolem_functions(+SkolemList):

print_skolem_functions([]).

print_skolem_functions([skolem(Fun,Args,Result)|MoreSkolem]) :-
	print_skolem_functions(MoreSkolem),
	% We need the reverse order here
	write('    '),
	write(Fun),
	print_skolem_args(Args),
	write(': '),
	write(Result),
	writeln('.').

% print_skolem_args(+Args):

print_skolem_args([]).

print_skolem_args([var(Rel,Var)|MoreArgs]) :-
	write('('),
	write(Rel),
	write(' '),
	write(Var),
	print_skolem_args_rest(MoreArgs),
	write(')').

% print_skolem_args_rest(+Args).

print_skolem_args_rest([]).

print_skolem_args_rest([var(Rel,Var)|MoreArgs]) :-
	write(', '),
	write(Rel),
	write(' '),
	write(Var),
	print_skolem_args_rest(MoreArgs).

%--------------------------------------------------------------------------
% skolem_universe: All terms that can be constructed from Skolem functions.
%--------------------------------------------------------------------------

% skolem_universe(+SkolemFunctions, -CycleSorts, -SkolemUniverse):

skolem_universe(SkolemFunctions, CycleSorts, Univ) :-
	skolem_universe(SkolemFunctions, [], [], CycleSorts, Univ).

% skolem_universe(+SkolemFunctions, +CycleSortsIn, +UnivIn, -CycleSortsOut,
%			-UnivOut):

skolem_universe(SkolemFunctions, CycleSortsIn, UnivIn,
		CycleSortsOut, UnivOut) :-
	skolem_term(SkolemFunctions, UnivIn, uelem(Fun,ArgValues,Sort)),
	\+ is_member(uelem(Fun,ArgValues,Sort), UnivIn),
	\+ is_member(Sort, CycleSortsIn),
	!,
	skolem_universe_checkcycle(uelem(Fun,ArgValues,Sort),
		SkolemFunctions, CycleSortsIn, UnivIn,
		CycleSortsOut, UnivOut).

skolem_universe(_, CycleSorts, Univ, CycleSorts, Univ).

% skolem_universe_checkcycle(+Term, +SkolemFunctions, +CycleSortsIn,
%				+UnivIn, -CycleSortsOut, -UnivOut):

skolem_universe_checkcycle(uelem(Fun,ArgVals,Sort), SkolemFunctions,
		CycleSortsIn, UnivIn, CycleSortsOut, UnivOut) :-
	skolem_cycle(uelem(Fun,ArgVals,Sort)),
	!,
	write('Consistency check problem: Unknown number of rows in '),
	write('table '),
	write(Sort),
	write('.'),
	nl,
	name(Sort, SortChars),
	name('$1', Dollar1),
	list_append(SortChars, Dollar1, Name1),
	name(NewFun1, Name1),
	name('$2', Dollar2),
	list_append(SortChars, Dollar2, Name2),
	name(NewFun2, Name2),
	skolem_remove_uelems_of_sort(UnivIn, Sort, Univ),
	skolem_universe(SkolemFunctions, [Sort|CycleSortsIn],
		[uelem(NewFun2,[],Sort),uelem(NewFun1,[],Sort)|Univ],
		CycleSortsOut, UnivOut).

skolem_universe_checkcycle(uelem(Fun,ArgVals,Sort), SkolemFunctions,
		CycleSortsIn, UnivIn, CycleSortsOut, UnivOut) :-
	skolem_universe(SkolemFunctions, CycleSortsIn,
		[uelem(Fun,ArgVals,Sort)|UnivIn], CycleSortsOut, UnivOut).

%--------------------------------------------------------------------------
% skolem_term: Construct Term from Skolem Functions.
%--------------------------------------------------------------------------

% skolem_term(+SkolemFunctions, +CurrentTerms, -Term)

skolem_term(SkolemFunctions, CurrentTerms, uelem(Fun,ArgValues,Sort)) :-
	is_member(skolem(Fun,Args,Sort), SkolemFunctions),
	skolem_term_args(Args, CurrentTerms, ArgValues).

% skolem_term_args(+Args, +CurrentTerms, -ArgValues):

skolem_term_args([], _, []).

skolem_term_args([var(Rel,_)|MoreArgs], CurrentTerms,
		[uelem(Fun,TermArgVals,Rel)|MoreArgValues]) :-
	is_member(uelem(Fun,TermArgVals,Rel), CurrentTerms),
	skolem_term_args(MoreArgs, CurrentTerms, MoreArgValues).

%--------------------------------------------------------------------------
% skolem_cycle: Check whether Skolem term starts a cycle.
%--------------------------------------------------------------------------

% This checks whether the outermost function occurs somewhere inside.

% skolem_cycle(+Term):

skolem_cycle(uelem(Fun,ArgVals,_)) :-
	skolem_cycle_argvals(ArgVals, Fun).

% skolem_cycle_argvals(+ArgVals, +Fun):

skolem_cycle_argvals([uelem(Fun,_,_)|_], Fun).

skolem_cycle_argvals([uelem(_,ArgVals,_)|_], Fun) :-
	skolem_cycle_argvals(ArgVals, Fun).

skolem_cycle_argvals([_|ArgVals], Fun) :-
	skolem_cycle_argvals(ArgVals, Fun).

%--------------------------------------------------------------------------
% skolem_remove_uelems_of_sort: Remove terms of a given sort (also as args).
%--------------------------------------------------------------------------

% skolem_remove_uelems_of_sort(+UnivIn, +Sort, -Univ):

skolem_remove_uelems_of_sort([], _, []).

skolem_remove_uelems_of_sort([Term|UnivIn], Sort, UnivOut) :-
	skolem_uelem_contains_sort(Term, Sort),
	!,
	skolem_remove_uelems_of_sort(UnivIn, Sort, UnivOut).

skolem_remove_uelems_of_sort([Term|UnivIn], Sort, [Term|UnivOut]) :-
	% \+ skolem_uelem_contains_sort(Term, Sort),
	skolem_remove_uelems_of_sort(UnivIn, Sort, UnivOut).

% skolem_uelem_contains_sort(+Term, +Sort):

skolem_uelem_contains_sort(uelem(_,_,Sort), Sort).

skolem_uelem_contains_sort(uelem(_,ArgVals,_), Sort) :-
	skolem_uelemlist_contains_sort(ArgVals, Sort).

% skolem_uelemlist_contains_sort(+TermList, +Sort):

skolem_uelemlist_contains_sort([Term|_], Sort) :-
	skolem_uelem_contains_sort(Term, Sort).

skolem_uelemlist_contains_sort([_|TermList], Sort) :-
	skolem_uelemlist_contains_sort(TermList, Sort).

%--------------------------------------------------------------------------
% print_skolem_universe: List all terms in the Skolem universe:
%--------------------------------------------------------------------------

% print_skolem_universe(+SkolemUniverse):

print_skolem_universe([]).

print_skolem_universe([uelem(Fun,Args,Result)|MoreTerms]) :-
	print_skolem_universe(MoreTerms),
	% We need the reverse order here
	write('    '),
	print_skolem_uelem(uelem(Fun,Args,Result)),
	write(': '),
	write(Result),
	writeln('.').

%--------------------------------------------------------------------------
% print_skolem_uelem: Print a term constructed from Skolem functions.
%--------------------------------------------------------------------------

% print_skolem_uelem(+SkolemTerm):

print_skolem_uelem(uelem(Fun,[],_)) :-
	write(Fun).

print_skolem_uelem(uelem(Fun,[ArgVal|ArgVals],_)) :-
	write(Fun),
	write('('),
	print_skolem_uelem(ArgVal),
	print_skolem_argvals_rest(ArgVals),
	write(')').

% print_skolem_argvals_rest(+ArgVals):

print_skolem_argvals_rest([]).

print_skolem_argvals_rest([ArgVal|ArgVals]) :-
	write(', '),
	print_skolem_uelem(ArgVal),
	print_skolem_argvals_rest(ArgVals).

%--------------------------------------------------------------------------
% flat_form: Remove subqueries with Skolem functions.
%--------------------------------------------------------------------------

% flat_form(+From, +Where, +Skolem, +Univ, +CycleSorts, -Cond):

flat_form(From, Where, Skolem, Univ, CycleSorts, Cond) :-
	flat_form_from(From, Where, Skolem, Univ, CycleSorts, Cond1),
	flat_form_exists(Cond1, Skolem, Univ, CycleSorts, Cond2),
	flat_form_all_not(Cond2, Univ, Cond).

% flat_form_from(+From, +Where, +Skolem, +Univ, +CycleSorts, -Cond):

flat_form_from([], Cond, _, _, _, Cond).

flat_form_from([var(Rel,Var)|From], CondIn, Skolem, Univ, CycleSorts,
		CondOut) :-
	is_member(Rel, CycleSorts),
	!,
	flat_form_from(From, CondIn, Skolem, Univ, CycleSorts, Cond),
	univ_of_sort(Univ, Rel, UnivOfSort),
	subst_disj(Cond, Var, UnivOfSort, CondOut).

flat_form_from([var(Rel,Var)|From], CondIn, Skolem, Univ, CycleSorts,
		CondOut) :-
	% \+ is_member(Rel, CycleSorts),
	is_member(skolem(Var,Args,Rel), Skolem),
	!,
	flat_form_from(From, CondIn, Skolem, Univ, CycleSorts, Cond),
	usubst(Cond, Var, uelem(Var,Args,Rel), CondOut).

% flat_form_from_disj(+From, +Where, +Univ, -Cond):

flat_form_from_disj([], Cond, _, Cond).

flat_form_from_disj([var(Rel,Var)|From], CondIn, Univ, CondOut) :-
	flat_form_from_disj(From, CondIn, Univ, Cond),
	univ_of_sort(Univ, Rel, UnivOfSort),
	subst_disj(Cond, Var, UnivOfSort, CondOut).

%--------------------------------------------------------------------------
% flat_form_exists: Remove subqueries (non-negated) with Skolem functions.
%--------------------------------------------------------------------------

% flat_form_exists(+CondIn, +Skolem, +Univ, +CycleSorts, -CondOut):

flat_form_exists(true, _, _, _, true).

flat_form_exists(false, _, _, _, false).

flat_form_exists(comp(Op,Term1,Term2), _, _, _, comp(Op,Term1,Term2)).

flat_form_exists(exists(_,From,Where), Skolem, Univ, CycleSorts,
		Cond) :-
	flat_form_from(From, Where, Skolem, Univ, CycleSorts, Cond1),
	flat_form_exists(Cond1, Skolem, Univ, CycleSorts, Cond).

flat_form_exists(not(CondIn), Skolem, Univ, CycleSorts, not(CondOut)) :-
	flat_form_exists_not(CondIn, Skolem, Univ, CycleSorts, CondOut).

flat_form_exists(and(CondIn1,CondIn2), Skolem, Univ, CycleSorts,
		and(CondOut1,CondOut2)) :-
	flat_form_exists(CondIn1, Skolem, Univ, CycleSorts, CondOut1),
	flat_form_exists(CondIn2, Skolem, Univ, CycleSorts, CondOut2).

flat_form_exists(or(CondIn1,CondIn2), Skolem, Univ, CycleSorts,
		or(CondOut1,CondOut2)) :-
	flat_form_exists(CondIn1, Skolem, Univ, CycleSorts, CondOut1),
	flat_form_exists(CondIn2, Skolem, Univ, CycleSorts, CondOut2).

% flat_form_exists_not(+CondIn, +Skolem, +Univ, +CycleSorts, -CondOut):

flat_form_exists_not(true, _, _, _, true).

flat_form_exists_not(false, _, _, _, false).

flat_form_exists_not(comp(Op,Term1,Term2), _, _, _, comp(Op,Term1,Term2)).

flat_form_exists_not(exists(Select,From,Where), Skolem, Univ, CycleSorts,
		exists(Select,From,Cond)) :-
	flat_form_exists_not(Where, Skolem, Univ, CycleSorts, Cond).

flat_form_exists_not(not(CondIn), Skolem, Univ, CycleSorts, not(CondOut)) :-
	flat_form_exists(CondIn, Skolem, Univ, CycleSorts, CondOut).

flat_form_exists_not(and(CondIn1,CondIn2), Skolem, Univ, CycleSorts,
		and(CondOut1,CondOut2)) :-
	flat_form_exists_not(CondIn1, Skolem, Univ, CycleSorts, CondOut1),
	flat_form_exists_not(CondIn2, Skolem, Univ, CycleSorts, CondOut2).

flat_form_exists_not(or(CondIn1,CondIn2), Skolem, Univ, CycleSorts,
		or(CondOut1,CondOut2)) :-
	flat_form_exists_not(CondIn1, Skolem, Univ, CycleSorts, CondOut1),
	flat_form_exists_not(CondIn2, Skolem, Univ, CycleSorts, CondOut2).

%--------------------------------------------------------------------------
% flat_form_all: Remove subqueries (negated) with disjunctions.
%--------------------------------------------------------------------------

% flat_form_all(+CondIn, +Univ, -CondOut):

flat_form_all(true, _, true).

flat_form_all(false, _, false).

flat_form_all(comp(Op,Term1,Term2), _, comp(Op,Term1,Term2)).

flat_form_all(exists(_,From,Where), Univ, Cond) :-
	flat_form_from_disj(From, Where, Univ, Cond1),
	flat_form_all(Cond1, Univ, Cond).

flat_form_all(not(CondIn), Univ, not(CondOut)) :-
	flat_form_all_not(CondIn, Univ, CondOut).

flat_form_all(and(CondIn1,CondIn2), Univ, and(CondOut1,CondOut2)) :-
	flat_form_all(CondIn1, Univ, CondOut1),
	flat_form_all(CondIn2, Univ, CondOut2).

flat_form_all(or(CondIn1,CondIn2), Univ, or(CondOut1,CondOut2)) :-
	flat_form_all(CondIn1, Univ, CondOut1),
	flat_form_all(CondIn2, Univ, CondOut2).

% flat_form_all_not(+CondIn, +Univ, -CondOut):

flat_form_all_not(true, _, true).

flat_form_all_not(false, _, false).

flat_form_all_not(comp(Op,Term1,Term2), _, comp(Op,Term1,Term2)).

flat_form_all_not(exists(Select,From,Where), Univ,
		exists(Select,From,Cond)) :-
	flat_form_all_not(Where, Univ, Cond).

flat_form_all_not(not(CondIn), Univ, not(CondOut)) :-
	flat_form_all(CondIn, Univ, CondOut).

flat_form_all_not(and(CondIn1,CondIn2), Univ,
		and(CondOut1,CondOut2)) :-
	flat_form_all_not(CondIn1, Univ, CondOut1),
	flat_form_all_not(CondIn2, Univ, CondOut2).

flat_form_all_not(or(CondIn1,CondIn2), Univ,
		or(CondOut1,CondOut2)) :-
	flat_form_all_not(CondIn1, Univ, CondOut1),
	flat_form_all_not(CondIn2, Univ, CondOut2).

%--------------------------------------------------------------------------
% univ_of_sort: Select terms of a given sort in Skolem universe.
%--------------------------------------------------------------------------

% univ_of_sort(+UnivIn, +Sort, -UnivOut):

univ_of_sort([], _, []).

univ_of_sort([uelem(Fun,ArgVals,Sort)|UnivIn], Sort,
		[uelem(Fun,ArgVals,Sort)|UnivOut]) :-
	univ_of_sort(UnivIn, Sort, UnivOut).

univ_of_sort([uelem(_,_,OtherSort)|UnivIn], Sort, UnivOut) :-
	OtherSort \= Sort,
	univ_of_sort(UnivIn, Sort, UnivOut).

%--------------------------------------------------------------------------
% subst_disj: Compute the disjunction for all possible substitutions.
%--------------------------------------------------------------------------

% subst_disj(+CondIn, +Var, +UnivOfSort, -CondOut):

subst_disj(_, _, [], false).

subst_disj(CondIn, Var, [UnivElem], CondOut) :-
	usubst(CondIn, Var, UnivElem, CondOut).

subst_disj(CondIn, Var, [UnivElem1,UnivElem2|MoreUnivElems],
		or(CondOut1,CondOut2)) :-
	usubst(CondIn, Var, UnivElem1, CondOut1),
	subst_disj(CondIn, Var, [UnivElem2|MoreUnivElems], CondOut2).

%--------------------------------------------------------------------------
% usubst: Replace a variable by an element of the Skolem universe.
%--------------------------------------------------------------------------

% usubst(+Cond, +Var, +UnivElem, -CondOut):

usubst(true, _, _, true).

usubst(false, _, _, false).

usubst(comp(Op,TermIn1,TermIn2), Var, UElem, comp(Op,TermOut1,TermOut2)) :-
	usubst_term(TermIn1, Var, UElem, TermOut1),
	usubst_term(TermIn2, Var, UElem, TermOut2).

usubst(not(CondIn), Var, UElem, not(CondOut)) :-
	usubst(CondIn, Var, UElem, CondOut).

usubst(and(CondIn1,CondIn2), Var, UElem, and(CondOut1,CondOut2)) :-
	usubst(CondIn1, Var, UElem, CondOut1),
	usubst(CondIn2, Var, UElem, CondOut2).

usubst(or(CondIn1,CondIn2), Var, UElem, or(CondOut1,CondOut2)) :-
	usubst(CondIn1, Var, UElem, CondOut1),
	usubst(CondIn2, Var, UElem, CondOut2).

usubst(exists(Select,From,CondIn), Var, UElem, exists(Select,From,CondOut))
		:-
	usubst(CondIn, Var, UElem, CondOut).
	% Select will be removed anyway, no need to apply substitution
	% there.

% usubst_term(+TermIn, +Var, +UElem, -TermOut):

usubst_term(int(I), _, _, int(I)).

usubst_term(str(S), _, _, str(S)).

usubst_term(aref(Rel,Var,Attr), Var, UElem, aref(Rel,UElem,Attr)) :-
	!.

usubst_term(aref(Rel,uelem(Fun,ArgValsIn,Sort),Attr), Var, UElem,
	aref(Rel,uelem(Fun,ArgValsOut,Sort),Attr)) :-
	!,
	usubst_args(ArgValsIn, Var, UElem, ArgValsOut).

usubst_term(aref(Rel,OtherVar,Attr), Var, _, aref(Rel,OtherVar,Attr)) :-
	OtherVar \= Var.

% usubst_args(+ArgValsIn, +Var, +UElem, -ArgValsOut):

usubst_args([], _, _, []).

usubst_args([ArgIn|MoreArgsIn], Var, UElem, [ArgOut|MoreArgsOut]) :-
	usubst_arg(ArgIn, Var, UElem, ArgOut),
	usubst_args(MoreArgsIn, Var, UElem, MoreArgsOut).

% usubst_arg(+ArgIn, +Var, +UElem, -ArgOut):

usubst_arg(uelem(Fun,ArgVals,Sort), _, _, uelem(Fun,ArgVals,Sort)) :-
	!.

usubst_arg(var(_,Var), Var, UElem, UElem) :-
	!.

usubst_arg(var(Rel,OtherVar), Var, _, var(Rel,OtherVar)) :-
	OtherVar \= Var.

%==========================================================================
% Consistency Check (without subqueries):
%==========================================================================

%--------------------------------------------------------------------------
% consistent_dnf(+Conj, +Verbose, +ShowModel)
%--------------------------------------------------------------------------

% consistent_dnf(+DNF, +Verbose, +ShowModel):

% The purpose of this predicate is to check a condition in DNF for
% consistency.
% The atomic formulas contain operators =, <>, < <=, >, >=.
% The arguments of the atomic formulas are integer or string constants,
% and qualified attributes (i.e. Tuple Variable.Attribute).
% The representation of the input condition is as a list of lists
% (the outer list corresponds to disjunction, the inner lists to
% conjunction).
% An example call is
% consistent_dnf([[comp(ge,aref(r,x,a),int(1)),
%		comp(eq,aref(r,x,b),str(['a'])]], yes, yes).

% A formula in DNF is consistent iff at least one of the conjunctions
% is consistent:

consistent_dnf([Conj], Verbose, ShowModel) :-
	!,
	consistent_conj(Conj, Verbose, ShowModel).

consistent_dnf([Conj|_], Verbose, ShowModel) :-
	consistent_conj(Conj, Verbose, ShowModel).

consistent_dnf([_|DNF], Verbose, ShowModel) :-
	consistent_dnf(DNF, Verbose, ShowModel).

%--------------------------------------------------------------------------
% consistent_conj(+Conj, +Verbose, +ShowModel)
%--------------------------------------------------------------------------

% This predicate checks a single conjunction (a list of comparisons)
% for consistency.
% It is responsible for eliminating the <>-conditions by backtracking
% over the two possibilities < and >.
% This gives of course a behaviour that is exponential in the number of
% <>-conditions, however the satisfiability problem for <> is NP-hard
% (in the integer domain), so no fundamentally better algorithm is
% possible. However, sometime in the future, I will experiment with
% different algorithms on real examples (after the successes of clever
% algorithms for Hamiltonian paths, it might be that also here time can
% be saved for cases occuring in practice - even when the worst case
% remains exponential). But the present algorithm is simple and obviously
% correct.

consistent_conj(Conj, Verbose, ShowModel) :-
	remove_ne(Conj, NewConj),
	ctest(NewConj, Verbose, ShowModel).

% remove_ne(+Conj, -NewConj):

remove_ne([], []).

remove_ne([comp(ne,Term1,Term2)|Conj], [comp(lt,Term1,Term2)|NewConj]) :-
	remove_ne(Conj, NewConj).

remove_ne([comp(ne,Term1,Term2)|Conj], [comp(gt,Term1,Term2)|NewConj]) :-
	remove_ne(Conj, NewConj).

remove_ne([comp(Op,Term1,Term2)|Conj], [comp(Op,Term1,Term2)|NewConj]) :-
	Op \= ne,
	remove_ne(Conj, NewConj).

%--------------------------------------------------------------------------
% ctest(+Conj, +Verbose, +ShowModel)
%--------------------------------------------------------------------------

% This is the consistency test for the single conjunctions (without <>).
% It works by constructing a graph with equivalence classes of attributes
% and constants (with respect to =) as nodes, and edges labelled < or <=.
% This graph is then topologically sorted, where cycles are merged.

ctest(Conj, Verbose, ShowModel) :-
	ctest_show_cond(Conj, Verbose),
	ctest_gen_nodes(Conj, NodeList1),
	ctest_proc_eq(Conj, NodeList1, NodeList2),
	ctest_gen_edges(Conj, NodeList2, [], Edges),
	ctest_tsort(NodeList2, Edges, NewNodes, NewEdges),
	% The above part is only computation (exactly one solution).
	% The following predicates can fail:
	ctest_node_consistency(NewNodes, Verbose),
	ctest_node_ne(Conj, NewNodes, Verbose),
	ctest_modgen(NewNodes, NewEdges, Verbose, ShowModel).

%--------------------------------------------------------------------------
% ctest_gen_nodes(+Conj, -NodesOut):
%--------------------------------------------------------------------------

% This predicate constructs a node for each term appearing in the
% conjunction. It is important that each constant or attribute appears
% only in a single node (i.e. the nodes are really distinct).

ctest_gen_nodes(Conj, Nodes) :- ctest_gen_nodes(Conj, [], Nodes).

% ctest_gen_nodes(+Conj, +NodesIn, -NodesOut):

ctest_gen_nodes([], Nodes, Nodes).

ctest_gen_nodes([comp(_,Term1, Term2)|Conj], NodesIn, NodesOut) :-
	ctest_add_node(Term1, NodesIn, Nodes1),
	ctest_add_node(Term2, Nodes1, Nodes2),
	ctest_gen_nodes(Conj, Nodes2, NodesOut).

%--------------------------------------------------------------------------
% ctest_add_node(+Term, +NodesIn, -NodesOut):
%--------------------------------------------------------------------------

% This predicate checks whether <Term> already appears in <NodesIn>.
% If yes, <NodesOut>=<NodesIn>.
% Otherwise, <term> is added as a new node (a one element list) to the
% node list.

ctest_add_node(Term, [], [[Term]]) :-
	!.

ctest_add_node(Term, [[Term]|Nodes], [[Term]|Nodes]) :-
	!.

ctest_add_node(Term, [[OtherTerm]|NodesIn], [[OtherTerm]|NodesOut]) :-
	Term \== OtherTerm,
	ctest_add_node(Term, NodesIn, NodesOut).

%--------------------------------------------------------------------------
% ctest_proc_eq(+Conj, +NodesIn, -NodesOut):
%--------------------------------------------------------------------------

% The purpose of this predicate is to merge nodes that contain terms
% which must be equal because of an equality condition.
% This predicate does the loop over the conditions, the real merging
% is done by ctest_merge_nodes.

ctest_proc_eq([], Nodes, Nodes).

ctest_proc_eq([comp(eq,Term1,Term2)|Conj], NodesIn, NodesOut) :-
	!,
	ctest_merge_nodes(NodesIn, Term1, Term2, Nodes),
	ctest_proc_eq(Conj, Nodes, NodesOut).

ctest_proc_eq([comp(Op,_,_)|Conj], NodesIn, NodesOut) :-
	Op \== eq,
	ctest_proc_eq(Conj, NodesIn, NodesOut).

%--------------------------------------------------------------------------
% ctest_merge_nodes(+NodesIn, +Term1, +Term2, -NodesOut):
%--------------------------------------------------------------------------

% This predicate merges the nodes containing Term1 and Term2.
% Of course, it is possible that Term1 and Term2 are already in the same
% node, then nothing is changed.

ctest_merge_nodes(NodesIn, Term1, Term2, NodesOut) :-
	ctest_extract_node(NodesIn, Term1, Node1, RestNodes),
	ctest_merge_nodes2(Term2, RestNodes, Node1, NodesOut).

% ctest_merge_nodes2(+Term2, +RestNodes, +Node1, -NodesOut):

ctest_merge_nodes2(Term2, RestNodes, Node1, [Node1|RestNodes]) :-
	is_member(Term2, Node1),
	!.

ctest_merge_nodes2(Term2, RestNodes, Node1, [Node|OtherNodes]) :-
	ctest_extract_node(RestNodes, Term2, Node2, OtherNodes),
	list_append(Node1, Node2, Node).

%--------------------------------------------------------------------------
% ctest_extract_node(+NodesIn, +Term, -Node, -RestNodes):
%--------------------------------------------------------------------------

% This predicate findes the node <Node> that contains <Term>.
% <RestNodes> are all other nodes in <NodesIn>.

ctest_extract_node([Node|RestNodes], Term, Node, RestNodes) :-
	is_member(Term, Node),
	!.

ctest_extract_node([Node1|MoreNodes], Term, Node, [Node1|RestNodes]) :-
	ctest_extract_node(MoreNodes, Term, Node, RestNodes).

%--------------------------------------------------------------------------
% ctest_gen_edges(+Conj, +Nodes, -Edges):
%--------------------------------------------------------------------------

% This predicate constructs the edges of the graph.
% The edges are represented as a list of terms of the form edge(N1,N2,Op),
% where N1 and N2 are nodes and Op is le or lt.
% Note that <> was eliminated and does not occur in the input conjunction.

ctest_gen_edges([], _, Edges, Edges).

ctest_gen_edges([comp(eq,_,_)|Conj], Nodes, EdgesIn, EdgesOut) :-
	ctest_gen_edges(Conj, Nodes, EdgesIn, EdgesOut).

ctest_gen_edges([comp(lt,Term1,Term2)|Conj], Nodes, EdgesIn, EdgesOut) :-
	ctest_find_node(Nodes, Term1, Node1),
	ctest_find_node(Nodes, Term2, Node2),
	ctest_gen_edges(Conj, Nodes, [edge(Node1,Node2,lt)|EdgesIn],
				EdgesOut).

ctest_gen_edges([comp(le,Term1,Term2)|Conj], Nodes, EdgesIn, EdgesOut) :-
	ctest_find_node(Nodes, Term1, Node1),
	ctest_find_node(Nodes, Term2, Node2),
	ctest_gen_edges(Conj, Nodes, [edge(Node1,Node2,le)|EdgesIn],
				EdgesOut).

ctest_gen_edges([comp(gt,Term1,Term2)|Conj], Nodes, EdgesIn, EdgesOut) :-
	ctest_find_node(Nodes, Term1, Node1),
	ctest_find_node(Nodes, Term2, Node2),
	ctest_gen_edges(Conj, Nodes, [edge(Node2,Node1,lt)|EdgesIn],
				EdgesOut).

ctest_gen_edges([comp(ge,Term1,Term2)|Conj], Nodes, EdgesIn, EdgesOut) :-
	ctest_find_node(Nodes, Term1, Node1),
	ctest_find_node(Nodes, Term2, Node2),
	ctest_gen_edges(Conj, Nodes, [edge(Node2,Node1,le)|EdgesIn],
				EdgesOut).

%--------------------------------------------------------------------------
% ctest_find_node(+Nodes, +Term, -Node):
%--------------------------------------------------------------------------

% <Nodes> is a list of nodes, where each node is a list of terms.
% This predicate returns the node <Node> that contains <Term>.

ctest_find_node([Node|_], Term, Node) :-
	is_member(Term, Node),
	!.

ctest_find_node([_|MoreNodes], Term, Node) :-
	ctest_find_node(MoreNodes, Term, Node).

%--------------------------------------------------------------------------
% ctest_tsort(+Nodes, +Edges, -ResultNodes, -ResultEdges):
%--------------------------------------------------------------------------

% The purpose of this predicate is to topologically sort the graph
% (<Nodes>, <Edges>).
% The graph may contain cycles in which case all nodes in a cycle are
% merged (remember that the nodes are lists).
% (This also happens if one of the edges in the cycle should be labelled
% 'lt'. Then later an inconsistency is detected.)
% When nodes are merged, the edges are updated accordingly.

ctest_tsort(Nodes, Edges, ResultNodes, ResultEdges) :-
	ctest_tsort(Nodes, Edges, [], ResultNodes, ResultEdges).

% ctest_tsort(+RestNodes, +Edges, +Prefix, -ResultNodes, -ResultEdges):

% The method is to successively select a minimal element of the
% <RestNodes>, and append it to the prefix.
% If there is no element in <RestNodes> without a smaller element in
% <RestNodes>, a cycle is extracted and merged.

ctest_tsort([], Edges, Nodes, Nodes, Edges) :-
	!.

ctest_tsort(RestNodes, Edges, Prefix, ResultNodes, ResultEdges) :-
	ctest_tsort_first(RestNodes, Edges, First, MoreNodes),
	!,
	list_append(Prefix, [First], NewPrefix),
	ctest_tsort(MoreNodes, Edges, NewPrefix, ResultNodes, ResultEdges).

ctest_tsort(RestNodes, Edges, Prefix, ResultNodes, ResultEdges) :-
	ctest_tsort_cycle(RestNodes, Edges, Cycle),
	ctest_tsort_merge(RestNodes, Edges, Cycle, NewNodes, NewEdges),
	ctest_tsort(NewNodes, NewEdges, Prefix, ResultNodes, ResultEdges).

%--------------------------------------------------------------------------
% ctest_tsort_first(+Nodes, +Edges, -First, -MoreNodes):
%--------------------------------------------------------------------------

% This predicate returns one element <First> of <Nodes> such that
% there is no edge (in <Edges>) from another element of <Nodes> to <First>.
% <MoreNodes> are the remaining elements in <Nodes>.
% Note that <Edges> may contain other nodes beside those in <Nodes>.

ctest_tsort_first(Nodes, Edges, First, MoreNodes) :-
	ctest_tsort_first(Nodes, Nodes, Edges, First, MoreNodes).

% ctest_tsort_first(+Candidates, +Nodes, +Edges, -First, -MoreNodes):

ctest_tsort_first([Node|RestNodes], Nodes, Edges, First, [Node|MoreNodes]) :-
	ctest_tsort_predecessor(Node, Nodes, Edges, _),
	!,
	ctest_tsort_first(RestNodes, Nodes, Edges, First, MoreNodes).

ctest_tsort_first([First|RestNodes], _, _, First, RestNodes).

%--------------------------------------------------------------------------
% ctest_tsort_predecessor(+Node, +Nodes, +Edges, -Predecessor):
%--------------------------------------------------------------------------

% This predicate checks whether Edges contain an edge from a node
% <Predecessor> to the given node <Node>.
% The node <Predecessor> must be an element of the node set <Nodes>.

ctest_tsort_predecessor(Node, Nodes, [edge(Predecessor,Node,_)|_],
		Predecessor) :-
	is_member(Predecessor, Nodes).

ctest_tsort_predecessor(Node, Nodes, [_|Edges], Predecessor) :-
	ctest_tsort_predecessor(Node, Nodes, Edges, Predecessor).

%--------------------------------------------------------------------------
% ctest_tsort_cycle(+Nodes, +Edges, -Cycle):
%--------------------------------------------------------------------------

% At this point we know that there is a cycle (all remaining nodes have
% predecessors). We only must find it. We start with any node and follow
% a list of predecessors from this node. When we get to a node that
% is already in the list, we found the cycle.

ctest_tsort_cycle([Node|MoreNodes], Edges, Cycle) :-
	ctest_tsort_cycle_path([Node], [Node|MoreNodes], Edges, Cycle).

% ctest_tsort_cycle_path(+Path, +Nodes, +Edges, -Cycle):

ctest_tsort_cycle_path([Node|Path], Nodes, Edges, Cycle) :-
	ctest_tsort_predecessor(Node, Nodes, Edges, Predecessor),
	!, % any predecessor is sufficient
	ctest_tsort_cycle_test(Predecessor, [Node|Path], Nodes, Edges,
		Cycle).

% ctest_tsort_cycle_test(+Predecessor, +Path, +Nodes, +Edges, -Cycle):

ctest_tsort_cycle_test(Predecessor, Path, _, _, Cycle) :-
	ctest_tsort_cycle_found(Predecessor, Path, Cycle),
	!.

ctest_tsort_cycle_test(Predecessor, Path, Nodes, Edges, Cycle) :-
	ctest_tsort_cycle_path([Predecessor|Path], Nodes, Edges, Cycle).

%--------------------------------------------------------------------------
% ctest_tsort_cycle_found(+NextNode, +Path, -Cycle):
%--------------------------------------------------------------------------

% This predicate is true iff <NextNode> occurs in the node list <Path>.
% Then <Cycle> is the prefix of <Path> up to and including <NextNode>. 

ctest_tsort_cycle_found(Node, [Node|_], [Node]) :-
	!.

ctest_tsort_cycle_found(Node, [OtherNode|Path], [OtherNode|Cycle]) :-
	Node \== OtherNode,
	ctest_tsort_cycle_found(Node, Path, Cycle).

%--------------------------------------------------------------------------
% ctest_tsort_merge(+RestNodes, +Edges, +Cycle, -NewNodes, NewEdges):
%--------------------------------------------------------------------------

% This predicate is called when a cycle is detected. It merges all nodes
% on the cycle and updates the edges correspondingly.
% In order to ensure that the topological sort can continue afterwards,
% circular edges from the new merged node to itself are removed.

ctest_tsort_merge(RestNodes, Edges, Cycle, [CycleNode|NonCycleNodes],
		NewEdges) :-
	ctest_tsort_cyclenode(Cycle, CycleNode),
	ctest_tsort_noncyclenodes(RestNodes, Cycle, NonCycleNodes),
	ctest_tsort_update_edges(Edges, Cycle, CycleNode, NewEdges).

%--------------------------------------------------------------------------
% ctest_tsort_cyclenode(+Cycle, -CycleNode):
%--------------------------------------------------------------------------

% This predicate simply merges (appends) all elements of the list <Cycle>.

ctest_tsort_cyclenode([], []).

ctest_tsort_cyclenode([Node|MoreNodes], CycleNode) :-
	ctest_tsort_cyclenode(MoreNodes, MoreMerged),
	list_append(Node, MoreMerged, CycleNode).

%--------------------------------------------------------------------------
% ctest_tsort_noncyclenodes(+RestNodes, +Cycle, -NonCycleNodes):
%--------------------------------------------------------------------------

% This predicate filters the list <RestNodes>: The returned list
% <NonCycleNodes> consists of those elements of <RestNodes> that are not
% contained in the list <Cycle>. I.e. it is simply a set/list-difference.

ctest_tsort_noncyclenodes([], _, []).

ctest_tsort_noncyclenodes([Node|MoreNodes], Cycle, NonCycleNodes) :-
	is_member(Node, Cycle),
	!,
	ctest_tsort_noncyclenodes(MoreNodes, Cycle, NonCycleNodes).

ctest_tsort_noncyclenodes([Node|MoreNodes], Cycle, [Node|NonCycleNodes]) :-
	ctest_tsort_noncyclenodes(MoreNodes, Cycle, NonCycleNodes).

%--------------------------------------------------------------------------
% ctest_tsort_update_edges(+Edges, +Cycle, +CycleNode, +NewEdges).
%--------------------------------------------------------------------------

% This predicate maps a list of edges to a list of edges (input: <Edges>,
% output: <NewEdges>), where every node appearing in the list <Cycle>
% is mapped to <CycleNode>. The circular edge from <CycleNode> to
% <CycleNode> is suppressed.

ctest_tsort_update_edges([], _, _, []).

ctest_tsort_update_edges([edge(From,To,_)|MoreEdges], Cycle, CycleNode,
			NewEdges) :-
	is_member(From, Cycle),
	is_member(To, Cycle),
	!,
	ctest_tsort_update_edges(MoreEdges, Cycle, CycleNode, NewEdges).

ctest_tsort_update_edges([edge(From,To,Op)|MoreEdges], Cycle, CycleNode,
			[edge(CycleNode,To,Op)|NewEdges]) :-
	is_member(From, Cycle),
	% \+ is_member(To, Cycle),
	!,
	ctest_tsort_update_edges(MoreEdges, Cycle, CycleNode, NewEdges).

ctest_tsort_update_edges([edge(From,To,Op)|MoreEdges], Cycle, CycleNode,
			[edge(From,CycleNode,Op)|NewEdges]) :-
	% \+ is_member(From, Cycle),
	is_member(To, Cycle),
	!,
	ctest_tsort_update_edges(MoreEdges, Cycle, CycleNode, NewEdges).

ctest_tsort_update_edges([edge(From,To,Op)|MoreEdges], Cycle, CycleNode,
			[edge(From,To,Op)|NewEdges]) :-
	% \+ is_member(From, Cycle),
	% \+ is_member(To, Cycle),
	ctest_tsort_update_edges(MoreEdges, Cycle, CycleNode, NewEdges).

%--------------------------------------------------------------------------
% ctest_node_consistency(+Nodes, +Verbose):
%--------------------------------------------------------------------------

% This predicate checks whether a node contains two distinct constants.
% (Since all terms in a node are distinct, it suffices to check whether
% there are two constants).

ctest_node_consistency([], _).

ctest_node_consistency([Node|Nodes], Verbose) :-
	ctest_node_consistency1(Node),
	!,
	ctest_node_consistency(Nodes, Verbose).

ctest_node_consistency([Node|_], yes) :-
	write('     => Inconsistent Node: '),
	ctest_print_node(Node),
	nl,
	fail.

% ctest_node_consistency1(+Node):

ctest_node_consistency1([]).

ctest_node_consistency1([int(_)|MoreTerms]) :-
	ctest_node_consistency2(MoreTerms).

ctest_node_consistency1([str(_)|MoreTerms]) :-
	ctest_node_consistency2(MoreTerms).

ctest_node_consistency1([aref(_,_,_)|MoreTerms]) :-
	ctest_node_consistency1(MoreTerms).

% ctest_node_consistency2(+Node):

% This predicate is called after a constant was found in the node.
% No further constant may be in the node.

ctest_node_consistency2([]).

ctest_node_consistency2([aref(_,_,_)|MoreTerms]) :-
	ctest_node_consistency2(MoreTerms).

%--------------------------------------------------------------------------
% ctest_node_ne(+Conj, +Nodes, +Verbose):
%--------------------------------------------------------------------------

% This predicate checks whether a node contains two terms that are required
% to be distinct.
% This may happen when cycles are merged that contain lt-edges
% (as a special case of this, circular edges are left out, e.g.
% A = B and A < B would also generate such a situation).

ctest_node_ne([], _, _).

ctest_node_ne([comp(eq,_,_)|Conj], Nodes, Verbose) :-
	ctest_node_ne(Conj, Nodes, Verbose).

ctest_node_ne([comp(le,_,_)|Conj], Nodes, Verbose) :-
	ctest_node_ne(Conj, Nodes, Verbose).

ctest_node_ne([comp(ge,_,_)|Conj], Nodes, Verbose) :-
	ctest_node_ne(Conj, Nodes, Verbose).

ctest_node_ne([comp(lt,Term1,Term2)|Conj], Nodes, Verbose) :-
	ctest_find_node(Nodes, Term1, Node1),
	ctest_find_node(Nodes, Term2, Node2),
	ctest_check_distinct(Node1, Node2, comp(lt,Term1,Term2), Verbose),
	ctest_node_ne(Conj, Nodes, Verbose).

ctest_node_ne([comp(gt,Term1,Term2)|Conj], Nodes, Verbose) :-
	ctest_find_node(Nodes, Term1, Node1),
	ctest_find_node(Nodes, Term2, Node2),
	ctest_check_distinct(Node1, Node2, comp(lt,Term1,Term2), Verbose),
	ctest_node_ne(Conj, Nodes, Verbose).

% ctest_check_distinct(+Node1, +Node2, +Cond, +Verbose):

ctest_check_distinct(Node1, Node2, _, _) :-
	Node1 \= Node2,
	!.

ctest_check_distinct(Node, Node, Cond, yes) :-
	write('     => Node '),
	ctest_print_node(Node),
	write(' contradicts '),
	print_atomic_formula(Cond),
	nl,
	!,
	fail.

%--------------------------------------------------------------------------
% ctest_modgen(+Nodes, +Edges, +Verbose, +ShowModel):
%--------------------------------------------------------------------------

ctest_modgen(Nodes, Edges, Verbose, ShowModel) :-
	ctest_modgen(Nodes, Edges, Verbose, [], Model),
	ctest_print_model(ShowModel, Model).

% ctest_modgen(+Nodes, +Edges, +Verbose, +ModelIn, +ModelOut):

ctest_modgen([], _, _, Model, Model).

ctest_modgen([Node|MoreNodes], Edges, Verbose, ModelIn, ModelOut) :-
	ctest_smallest_type(Node, Type),
	ctest_min_node_value(Node, Edges, ModelIn, MinVal),
	ctest_modgen_node(Node, Type, MinVal, Verbose, Value),
	list_append(ModelIn, [node(Node,Value)], Model),
	ctest_modgen(MoreNodes, Edges, Verbose, Model, ModelOut).

% ctest_modgen_node(+Node, +Type, +MinVal, +Verbose, -Value):

ctest_modgen_node(Node, Type, MinVal, _, Value) :-
	ctest_modgen_node(Node, Type, MinVal, Value),
	!.

ctest_modgen_node(Node, Type, MinVal, yes, nil) :-
	write('     => No possible value for '),
	ctest_print_node(Node),
	write(' Min: '),
	ctest_print_value(MinVal),
	write(' Type: '),
	ctest_print_type(Type),
	nl,
	!,
	fail.

% ctest_modgen_node(+Node, +Type, +MinVal, -Value):

ctest_modgen_node(Node, Type, MinVal, Value) :-
	ctest_constant(Node, Value),
	% If a node contains a constant, that is the only possible value.
	!,
	ctest_constant_in_type(Value, Type),
	ctest_value_le(MinVal, Value).

ctest_modgen_node(_, Type, MinVal, Value) :-
	MinVal \= nil,
	!,
	% Incoming edges determine the minimum value
	ctest_valid_val_ge(MinVal, Type, Value),
	Value \= overflow.

ctest_modgen_node(_, Type, nil, Value) :-
	ctest_min_value(Type, Value),
	% Choose the minimum value of the type
	!.

%--------------------------------------------------------------------------
% ctest_constant(+Node, -Value):
%--------------------------------------------------------------------------

ctest_constant([int(I)|_], int(I)) :-
	!.

ctest_constant([str(S)|_], str(S)) :-
	!.

ctest_constant([_|MoreNodeElems], Value) :-
	ctest_constant(MoreNodeElems, Value).

%--------------------------------------------------------------------------
% ctest_smallest_type(+Node, -Type):
%--------------------------------------------------------------------------

% This predicate computes the most restricted type for the elements of
% a node.
% It only looks at the attributes, constants are not considered.
% Later, it will be checked that constants satisfy the type restriction.

ctest_smallest_type(Node, Type) :-
	ctest_smallest_type(Node, top, Type).

% ctest_smallest_type(+Node, +TypeIn, -TypeOut):

ctest_smallest_type([], Type, Type).

ctest_smallest_type([Term|Node], TypeIn, TypeOut) :-
	ctest_type(Term, Type),
	ctest_intersect_types(TypeIn, Type, NextType),
	ctest_smallest_type(Node, NextType, TypeOut).

% ctest_type(+Term, -Type)

ctest_type(int(_), top).

ctest_type(str(_), top).

ctest_type(aref(Rel,_,Attr), Type) :-
	column(Rel, Attr, Type, _).

% ctest_intersect_types(+Type1, +Type2, Type):

ctest_intersect_types(top, Type, Type) :-
	!. % ctest_intersect_types(top,top,X) should succeed only once.

ctest_intersect_types(Type, top, Type).

ctest_intersect_types(numeric(L1,P1), numeric(L2,P2), numeric(L,P)) :-
	% First compute minimal number of digits before decimal point:
	N1 is L1 - P1,
	N2 is L2 - P2,
	min(N1, N2, N),
	% Now minimal number of digits after decimal point:
	min(P1, P2, P),
	% Now compute minimal length:
	L is N + P.

	% E.g., the intersection of numeric(5,1) and numeric(4,3) is
	% numeric(2,1).

ctest_intersect_types(varchar(N), varchar(M), varchar(Min)) :-
	min(N, M, Min).

ctest_intersect_types(char(N), varchar(M), varchar(Min)) :-
	min(N, M, Min).

ctest_intersect_types(varchar(N), char(M), varchar(Min)) :-
	min(N, M, Min).

ctest_intersect_types(char(N), char(M), varchar(Min)) :-
	min(N, M, Min).

% Note! This simplifies matters by assuming always the PAD SPACE comparison
% semantics (e.g., '' and ' ' are considered equal).
% In a future version, this should be corrected.

ctest_intersect_types(char(_), numeric(_,_), bot).

ctest_intersect_types(varchar(_), numeric(_,_), bot).

ctest_intersect_types(numeric(_,_), char(_), bot).

ctest_intersect_types(numeric(_,_), varchar(_), bot).

ctest_intersect_types(bot, _, bot).

ctest_intersect_types(_, bot, bot).

%--------------------------------------------------------------------------
% ctest_constant_in_type(+Value, +Type):
%--------------------------------------------------------------------------

% This predicate checks whether the value is possible given the type.

ctest_constant_in_type(_, top).

ctest_constant_in_type(str(CharList), char(Len)) :-
	list_length(CharList, N),
	N =< Len.

ctest_constant_in_type(str(CharList), varchar(Len)) :-
	list_length(CharList, N),
	N =< Len.

ctest_constant_in_type(int(N), numeric(TotalDigits,Prec)) :-
	IntDigits is TotalDigits - Prec,
	dec_length(N, L),
	L =< IntDigits.

%--------------------------------------------------------------------------
% ctest_min_node_value(+Node, +Edges, +Model, -Value),
%--------------------------------------------------------------------------

% This predicate determines the minimal possible value of a node
% from the incoming edges and the values of the source nodes.
% If there are no incoming edges, it returns "nil".

ctest_min_node_value(Node, Edges, Model, Value) :-
	ctest_min_node_value(Node, Edges, Model, nil, Value).

% ctest_min_node_value(+Node, +Edges, +Model, +ValueIn, -ValueOut):

ctest_min_node_value(_, [], _, Value, Value).

ctest_min_node_value(Node, [edge(FromNode,Node,le)|MoreEdges], Model,
			ValueIn, ValueOut) :-
		!,
		ctest_find_value(FromNode, Model, Value),
		ctest_max_value(ValueIn, Value, NextValue),
		ctest_min_node_value(Node, MoreEdges, Model,
					NextValue, ValueOut).

ctest_min_node_value(Node, [edge(FromNode,Node,lt)|MoreEdges], Model,
			ValueIn, ValueOut) :-
		!,
		ctest_find_value(FromNode, Model, Value),
		ctest_next_value(Value, GreaterValue),
		ctest_max_value(ValueIn, GreaterValue, NextValue),
		ctest_min_node_value(Node, MoreEdges, Model,
					NextValue, ValueOut).

ctest_min_node_value(Node, [edge(_,ToNode,_)|MoreEdges], Model,
			ValueIn, ValueOut) :-
		ToNode \= Node,
		ctest_min_node_value(Node, MoreEdges, Model,
					ValueIn, ValueOut).

%--------------------------------------------------------------------------
% ctest_find_value(+Node, +Model, -Value):
%--------------------------------------------------------------------------

% This predicate returns the value of a node in a model.
% It fails if no value is assigned yet.

ctest_find_value(Node, [node(Node,Value)|_], Value) :-
	!.

ctest_find_value(Node, [_|Model], Value) :-
	ctest_find_value(Node, Model, Value).

%--------------------------------------------------------------------------
% ctest_max_value(+Value1, +Value2, -MaxValue):
%--------------------------------------------------------------------------

% This predicate is called in the loop over the incoming edges to a node.
% It computes the maximum value of the source nodes.
% The first argument is the current value, which may be nil at the
% beginning.
% The second argument is the value of the next node, from which an edge
% leads to the current node (or that value + 1, if the edge is labelled <).

ctest_max_value(nil, int(M), int(M)).

ctest_max_value(int(N), int(M), int(Max)) :-
	max(N, M, Max).

ctest_max_value(nil, str(S), str(S)).

ctest_max_value(str(S), str(T), str(Max)) :-
	ctest_str_le(S, T),
	!,
	Max = T.

ctest_max_value(str(S), str(T), str(Max)) :-
	ctest_str_le(T, S),
	Max = S.

%--------------------------------------------------------------------------
% ctest_valid_val_ge(+Value, +Type, -ValidVal):
%--------------------------------------------------------------------------

% This predicate returns a value of <Type> that is >= the given <Value>.
% More specifically, it returns the smalles such value.
% Therefore, if <Value> is itself a possible value of <Type>, <Value>
% is returned.

ctest_valid_val_ge(int(N), numeric(Length,Prec), int(N)) :-
	PermittedDigits is Length - Prec,
	dec_length(N, Digits),
	Digits =< PermittedDigits,
	!.

ctest_valid_val_ge(int(N), numeric(Length,Prec), int(MinVal)) :-
	PermittedDigits is Length - Prec,
	ctest_min_int(PermittedDigits, MinVal),
	N =< MinVal,
	!.

ctest_valid_val_ge(int(_), numeric(_,_), overflow) :-
	!.

ctest_valid_val_ge(str(S), char(Length), str(S)) :-
	list_length(S, N),
	N =< Length,
	!.

ctest_valid_val_ge(str(S), char(Length), str(X)) :-
	!,
	list_prefix(S, Length, P),
	ctest_str_inc(P, X).

ctest_valid_val_ge(str(S), varchar(Length), str(S)) :-
	list_length(S, N),
	N =< Length,
	!.

ctest_valid_val_ge(str(S), varchar(Length), str(X)) :-
	list_prefix(S, Length, P),
	ctest_str_inc(P, X).

%--------------------------------------------------------------------------
% ctest_min_int(+Digits, -Value):
%--------------------------------------------------------------------------

ctest_min_int(1, -9).

ctest_min_int(D, N) :-
	D > 1,
	D1 is D - 1,
	ctest_min_int(D1, N1),
	N is N1 * 10 - 9.

%--------------------------------------------------------------------------
% ctest_next_value(+Value, -NextValue):
%--------------------------------------------------------------------------

ctest_next_value(int(N), int(M)) :-
	M is N + 1.

ctest_next_value(str(S), str(T)) :-
	str_charset(1, FirstChar),
	list_append(S, [FirstChar], T).

%--------------------------------------------------------------------------
% str_charset(?Code, ?Char):
%--------------------------------------------------------------------------

str_charset(  0, ' ').
str_charset(  1, 'a').
str_charset(  2, 'b').
str_charset(  3, 'c').
str_charset(  4, 'd').
str_charset(  5, 'e').
str_charset(  6, 'f').
str_charset(  7, 'g').
str_charset(  8, 'h').
str_charset(  9, 'i').
str_charset( 10, 'j').
str_charset( 11, 'k').
str_charset( 12, 'l').
str_charset( 13, 'm').
str_charset( 14, 'n').
str_charset( 15, 'o').
str_charset( 16, 'p').
str_charset( 17, 'q').
str_charset( 18, 'r').
str_charset( 19, 's').
str_charset( 20, 't').
str_charset( 21, 'u').
str_charset( 22, 'v').
str_charset( 23, 'w').
str_charset( 24, 'x').
str_charset( 25, 'y').
str_charset( 26, 'z').
str_charset( 27, 'A').
str_charset( 28, 'B').
str_charset( 29, 'C').
str_charset( 30, 'D').
str_charset( 31, 'E').
str_charset( 32, 'F').
str_charset( 33, 'G').
str_charset( 34, 'H').
str_charset( 35, 'I').
str_charset( 36, 'J').
str_charset( 37, 'K').
str_charset( 38, 'L').
str_charset( 39, 'M').
str_charset( 40, 'N').
str_charset( 41, 'O').
str_charset( 42, 'P').
str_charset( 43, 'Q').
str_charset( 44, 'R').
str_charset( 45, 'S').
str_charset( 46, 'T').
str_charset( 47, 'U').
str_charset( 48, 'V').
str_charset( 49, 'W').
str_charset( 50, 'X').
str_charset( 51, 'Y').
str_charset( 52, 'Z').
str_charset( 53, '0').
str_charset( 54, '1').
str_charset( 55, '2').
str_charset( 56, '3').
str_charset( 57, '4').
str_charset( 58, '5').
str_charset( 59, '6').
str_charset( 60, '7').
str_charset( 61, '8').
str_charset( 62, '9').
str_charset( 62, '9').
str_charset( 63, '.').
str_charset( 64, ',').
str_charset( 65, ';').
str_charset( 66, ':').
str_charset( 67, '?').
str_charset( 68, '!').
str_charset( 69, '-').
str_charset( 70, '_').
str_charset( 71, '(').
str_charset( 72, ')').
str_charset( 73, '[').
str_charset( 74, ']').
str_charset( 75, '{').
str_charset( 76, '}').
str_charset( 77, '<').
str_charset( 78, '>').
str_charset( 79, '\'').
str_charset( 80, '\"').
str_charset( 81, '%').
str_charset( 82, '+').
str_charset( 83, '*').
str_charset( 84, '/').
str_charset( 85, '=').
str_charset( 86, '\\').
str_charset( 87, '|').
str_charset( 88, '@').
str_charset( 89, '~').
str_charset( 90, '$').
str_charset( 91, '#').

%--------------------------------------------------------------------------
% ctest_min_value(+Type, -Value):
%--------------------------------------------------------------------------

ctest_min_value(char(_), str([])).

ctest_min_value(varchar(_), str([])).

ctest_min_value(numeric(N,0), int(M)) :-
	ctest_min_int(N, M).

%--------------------------------------------------------------------------
% ctest_value_le(+Value1, +Value2):
%--------------------------------------------------------------------------

ctest_value_le(nil, _).

ctest_value_le(int(N), int(M)) :-
	N =< M.

ctest_value_le(str(S), str(T)) :-
	ctest_str_le(S, T).

%--------------------------------------------------------------------------
% ctest_str_le(+Str1, +Str2):
%--------------------------------------------------------------------------

ctest_str_le([], _).

ctest_str_le([Char|Str1], [Char|Str2]) :-
	ctest_str_le(Str1, Str2).

ctest_str_le([Char1|_], [Char2|_]) :-
	str_charset(Code1, Char1),
	str_charset(Code2, Char2),
	Code1 < Code2.

%--------------------------------------------------------------------------
% ctest_str_inc(+Str, -NextStr):
%--------------------------------------------------------------------------

% This predicate increments a string seen as a number over a large base.
% I.e. it tries to choose the next character in the last position.
% If the last position contains already the last character of the
% characterset it tries the character before the last character and
% shortens the string (the former last character is removed).
% The goal is to get the next character string that is larger than the
% given character string without making the character string longer
% (otherwise the next character string could be computed by appending the
% first character of the alphabet).

ctest_str_inc([Char|Rest], [Char|RestInc]) :-
	ctest_str_inc(Rest, RestInc),
	!.

ctest_str_inc([Char|_], [NextChar]) :-
	str_charset(Code, Char),
	Code1 is Code + 1,
	str_charset(Code1, NextChar).

%--------------------------------------------------------------------------
% ctest_print_model(+ShowModel, +Model):
%--------------------------------------------------------------------------

ctest_print_model(no, _).

ctest_print_model(yes, Model) :-
	writeln('  Model found: '),
	ctest_print_model(Model).

% ctest_print_model(+Model):

ctest_print_model([]) :-
	nl.

ctest_print_model([node(Node,Value)|Model]) :-
	write('    '),
	ctest_print_node(Node),
	write(': '),
	print_term(Value),
	nl,
	ctest_print_model(Model).

%--------------------------------------------------------------------------
% ctest_print_node(+Node):
%--------------------------------------------------------------------------

ctest_print_node([Term|TermList]) :-
	write('['),
	print_term(Term),
	ctest_print_node_cont(TermList),
	write(']').

% ctest_print_node_cont(+Node):

ctest_print_node_cont([]).

ctest_print_node_cont([Term|Node]) :-
	write(', '),
	print_term(Term),
	ctest_print_node_cont(Node).

%--------------------------------------------------------------------------
% ctest_show_cond(+Conj, +Verbose):
%--------------------------------------------------------------------------

ctest_show_cond(_, no).

ctest_show_cond([Cond|Conj], yes) :-
	write('    '),
	print_atomic_formula(Cond),
	ctest_show_cond(Conj),
	writeln(':').

% ctest_show_cond(+Conj):

ctest_show_cond([]).

ctest_show_cond([Cond|Conj]) :-
	write(' and '),
	print_atomic_formula(Cond),
	ctest_show_cond(Conj).

%--------------------------------------------------------------------------
% ctest_print_value(+Value):
%--------------------------------------------------------------------------

ctest_print_value(nil) :-
	write('nil').

ctest_print_value(int(N)) :-
	write(N).

ctest_print_value(str(S)) :-
	write('\''),
	print_str(S),
	write('\'').

%--------------------------------------------------------------------------
% ctest_print_type(+Type):
%--------------------------------------------------------------------------

ctest_print_type(top) :-
	write('-').

ctest_print_type(char(N)) :-
	write(char(N)).

ctest_print_type(varchar(N)) :-
	write(varchar(N)).

ctest_print_type(numeric(N,0)) :-
	write(numeric(N)).

ctest_print_type(numeric(N,P)) :-
	P > 0,
	write(numeric(N,P)).

%==========================================================================
% Start This Program:
%==========================================================================

% For testing only:
emp :-
	clean_db,
	read_file('C:/stefan/sqllint/emp').
test_sk :-
	clean_db,
	read_file('C:/stefan/sqllint/test_sk').
test0 :-
	clean_db,
	read_file('C:/stefan/sqllint/test0').
test1 :-
	clean_db,
	read_file('C:/stefan/sqllint/test1').
test2 :-
	clean_db,
	read_file('C:/stefan/sqllint/test2').
test3 :-
	clean_db,
	read_file('C:/stefan/sqllint/test3').
test4 :-
	clean_db,
	read_file('C:/stefan/sqllint/test4').
test5 :-
	clean_db,
	read_file('C:/stefan/sqllint/test5').
test8 :-
	clean_db,
	read_file('C:/stefan/sqllint/test8').
test26 :-
	clean_db,
	read_file('C:/stefan/sqllint/test26').
test34 :-
	clean_db,
	read_file('C:/stefan/sqllint/test34').
test39 :-
	clean_db,
	read_file('C:/stefan/sqllint/test39').

%==========================================================================
% Start This Program:
%==========================================================================

autostart :-
	nl,
	writeln('*** Welcome to SQLLINT 0.3 ***'),
	write('Enter $h for help, '),
	%write('$v for current restrictions (version), '),
	write('$q to quit, '),
	write('CREATE TABLE ...; '),
	write('or a query SELECT ...; to check.'),
	nl,
	nl,
	run.

 :- autostart.
