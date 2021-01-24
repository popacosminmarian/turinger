module tgr::Plugin

import ParseTree;
import util::IDE;
import tgr::Check;
import tgr::Parser;
import tgr::CST2AST;
import tgr::Compile;
import tgr::Syntax;
import IO;
import Visualize;
import util::ShellExec;

void compileProgram(loc fil) {
	// Parsing
	start[Program] program = parseTGR(fil.top);
	// Output file - <name>.py
	out = (program@\loc)[extension="py"].top;
	// Transform the parse tree into an abstract syntax tree
	&T ast = cst2ast(program);
	if (checkProgram(ast)) {
		// Compile the program and write the output to file
		writeFile(out, compile(ast));
		println("Compiled successfully!");
	}
}

/*
 * This is the main function of the project. This function enables the editor's syntax highlighting.
 * After calling this function from the terminal, all files with extension .tgr will be parsed using the parser defined in module tgr::Parser.
 */
void main() {
	registerLanguage("turinger", "tgr", Tree(str _, loc path) {
		return parseTGR(path);
  	});
  	
  	// register "Compile to Python" menu button
  	contribs = {
  		popup(
  			menu("turinger", [
  				action("Compile to Python", void (start[Program] p, loc l) {
  					compileProgram(l);
  				})
  			])
  		)
  	};
  	
  	registerContributions("turinger", contribs);
}
