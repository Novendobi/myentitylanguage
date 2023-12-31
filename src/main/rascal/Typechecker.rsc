module Typechecker

import Ast;
import Syntax;
extend analysis::typepal::TypePal;

data AType
	= integer()
	| string()
	| boolean()
	| entityname(str entName)
    | moduleName(str mdName)
    ;
data IdRole
    = entityId()
    | attributeId()
    | moduleId()
    ;
str prettyType(integer()) = "int";
str prettyType(string()) = "str";
str prettyType(boolean()) = "bool";
str prettyType(entityname(str entName)) = entName;
str prettyType(moduleName(str mdName)) = mdName;


void collect(
	current: (MyEntityLang) `module <Id modulename> <Entity* entities>`, Collector c
){
    c.define("<modulename>", moduleId(), current, defType(moduleName("<modulename>")));

    c.enterScope(current);
	    collect(entities, c);
    c.leaveScope(current);
}

void collect(
	current: (Entity) `entity <Id etName> <Attribute* attributes> key ( <Id keyname> ) end`, Collector c
){
	c.define("<etName>", entityId(), current, defType(entityname("<etName>")));
    
	c.enterScope(current);
		collect(attributes, c);
        c.use(keyname, {attributeId()});
    c.leaveScope(current);
}

void collect(
	current: (Attribute) `<Id aname> : <Type typename>`, Collector c
){
	c.define("<aname>", attributeId(), current, defType(typename));
	c.fact(current, typename);
	collect(typename, c);
}

void collect(
	current: (Attribute) `<Association associations>`, Collector c
){
	collect(associations, c);
}

void collect(
	current: (Type) `Integer`, Collector c
){
    c.fact(current, integer());
}

void collect(
	current: (Type) `String`, Collector c
){
    c.fact(current, string());
}

void collect(
	current: (Type) `Boolean`, Collector c
){
    c.fact(current, boolean());
}

void collect(
	current: (Association) `<Id ooname> -\> <Id ooentity>`, Collector c
){
    c.define("<ooname>", attributeId(), current, defType(entityname("<ooentity>")));
    c.fact(current, ooentity);
    c.use(ooentity, {entityId()});
}

void collect(
	current: (Association) `<Id omname> -\> List[ <Id omentity> ]`, Collector c
){
    c.define("<omname>", attributeId(), current, defType(entityname("<omentity>")));
    c.fact(current, omentity);
    c.use(omentity, {entityId()});
}

void collect(
	current: (Association) `List [<Id mmname>] -\> List [ <Id mmentity> ]`, Collector c
){
    c.define("<mmname>", attributeId(), current, defType(entityname("<mmentity>")));
    c.fact(current, mmentity);
    c.use(mmentity, {entityId()});
}