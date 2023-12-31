module HqlTestchecker

extend HqlTypechecker;
extend analysis::typepal::TestFramework;
import ParseTree;
import HqlSyntax;

//implementing checker test
TModel syntaxTModelFromTree(Tree pt){
    return collectAndSolve(pt);
}

TModel syntaxTModelFromStr(str text){
    pt = parse(#start[Hlang], text);
    return syntaxTModelFromTree(pt);
}
        
test bool syntaxTests() {
    return runTests([|project://myentitytest/src/resources/hqtest.ttl|],
    #start[Hlang], syntaxTModelFromTree);
}
bool main() = syntaxTests();
