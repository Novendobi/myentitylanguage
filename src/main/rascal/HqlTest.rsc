module HqlTest

import HqlSyntax;
import HqlAst;
import ParseTree;
import vis::Text;
import IO;
import Exception;

void main(){
    try{
        loc FileLoc = |project://myentitytest/src/resources/hqtest.tap|;
        str Entexample = readFile(FileLoc);
        Tree Enttree = parse(#start[Hlang], Entexample);
        println(prettyTree(Enttree));

        // implode to Ast
        Hlang Entadt = implode(#Hlang, Enttree);
        println(Entadt);
    }catch ParseError(e): println("error failed at <e>");
}