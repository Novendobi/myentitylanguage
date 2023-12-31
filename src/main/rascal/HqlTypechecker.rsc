module HqlTypechecker

import HqlAst;
import HqlSyntax;
extend analysis::typepal::TypePal;

data AType
    = string()
    ;
data IdRole
    = tableId()
    | columnId()
    ;
str prettyType(string()) = "str";

void collect(
    current: (Hlang) `<HEntity* entities>`, Collector c
){
    c.enterScope(current);
        collect(entities, c);
    c.leaveScope(current);
}

void collect(
    current: (HEntity) `CREATE TABLE IF NOT EXISTS <Id tableName> ( <{Column ","}* columns> ) STORED AS PARQUET ;`, Collector c
){
    c.define("<tableName>", tableId(), current, defType(string()));
    
    c.enterScope(current);
        collect(columns, c);
    c.leaveScope(current);
}

void collect(
    current: (Column) `<Id columnName> <Type types>`, Collector c
){
    c.define("<columnName>", columnId(), current, defType(types));
    c.fact(current, types);
    collect(types, c);
}

void collect(
    current: (Type) `STRING`, Collector c
){
    c.fact(current, string());
}