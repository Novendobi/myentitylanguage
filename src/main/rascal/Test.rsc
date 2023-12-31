module Test

import Syntax;
import Ast;
import ParseTree;
import vis::Text;
import IO;
import Exception;
import EntityToHql;
import HqlToText;

void main(){
    try{
        loc FileLoc = |project://myentitytest/src/resources/test.tap|;
        str Entexample = readFile(FileLoc);
        Tree Enttree = parse(#start[MyEntityLang], Entexample);
        println(prettyTree(Enttree));

        // implode to Ast
        MyEntityLang Entadt = implode(#MyEntityLang, Enttree);
        println(Entadt);

        //model to model
        HqEnt = transformProgramToHql(Entadt);
        println("\nthis is the Hive Ast: \n\n<HqEnt>");

        //model to text
        str HiveCode = hqlProgramToText(HqEnt);
        println("\nthis is the code\n\n<HiveCode>");
        writeFile(|project://myentitytest/src/main/rascal/modeltotext/EntitytoHiveql.rcfile|, HiveCode);
    }catch ParseError(e): println("error failed at <e>");
}