module tgr::Plugin

import ParseTree;
import util::IDE;
import tgr::Check;
import tgr::Parser;
import tgr::CST2AST;
import tgr::Compile;

/*
* This function is defined to test the functionality of the whole assignment. It receives a file path as a parameter and returns true if the program satisfies the specification, or false otherwise.
* First, it calls the parser. Then, it transforms the resulting parse tree of the previous program and calls the function cst2ast, responsible for transforming a parse tree into an abstract syntax tree.
* Finally, the resulting AST is used to evaluate the well-formedness of the tgr program using the check function.
*/
bool checkWellFormedness(loc fil) {
	// Parsing
	&T program = parseTGR(fil);
	// Transform the parse tree into an abstract syntax tree
	&T ast = cst2ast(program);
	// Check the well-formedness of the program
	return checkProgram(ast);
}

void compileProgram(loc fil) {
	// Parsing
	&T program = parseTGR(fil);
	// Transform the parse tree into an abstract syntax tree
	&T ast = cst2ast(program);
	// Compile the program
	compile(ast);
}

/*
* This is the main function of the project. This function enables the editor's syntax highlighting.
* After calling this function from the terminal, all files with extension .tgr will be parsed using the parser defined in module tgr::Parser.
* If there are syntactic errors in the program, no highlighting will be shown in the editor.
*/
void main() {
	registerLanguage("turinger", "tgr", Tree(str _, loc path) {
		return parseTGR(path);
  	});
}
