module TestChecker

extend Typechecker;
extend analysis::typepal::TestFramework;
import ParseTree;
import Syntax;

//implementing checker test
TModel syntaxTModelFromTree(Tree pt){
    return collectAndSolve(pt);
}

TModel syntaxTModelFromStr(str text){
    pt = parse(#start[MyEntityLang], text);
    return syntaxTModelFromTree(pt);
}
        
test bool syntaxTests() {
    return runTests([|project://myentitytest/src/resources/test.ttl|],
    #start[MyEntityLang], syntaxTModelFromTree);
}
bool main() = syntaxTests();
