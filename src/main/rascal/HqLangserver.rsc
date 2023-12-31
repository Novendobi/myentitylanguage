module HqLangserver

import HqlSyntax;
import ParseTree;
import util::Reflective;
import util::LanguageServer;
import HqlTestchecker;
import Message;
import Prelude;
import IO;
extend analysis::typepal::TypePal;

set[LanguageService] testCont() = {
    parser(parser(#start[Hlang])),
    summarizer(testSummarizer, providesImplementations = false)
};

Summary testSummarizer(loc l, start[Hlang] input) {
    pt = parse(#start[Hlang], l).top;
    TModel model = syntaxTModelFromTree(input);

    // iprintToFile(|project://rascal-yaml/src/resources/mod.yml|, model);
    definitions = model.definitions;
    Summary val =  summary(l,
        messages = {<message.at, message> | message <- model.messages},
        references = {<definition, definitions[definition].defined> | definition <- definitions}
    );
    println(val);
    return val;
}

void main() {
  registerLanguage(
    language(
    pathConfig(srcs = [|std:///|, |project://myentitytest/src/main/rascal|]),
    "HQ Lang", 
    "hqtest", 
    "HqLangserver",
    "testCont"
    ));
}