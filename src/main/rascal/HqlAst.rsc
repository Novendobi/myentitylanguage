module HqlAst

import HqlSyntax;

data Hlang
    = hlang(list[HEntity] entities)
    ;
data HEntity
    = entity(str tableName, list[Column] columns)
    ;
data Column
    = column(str columnName, Type types)
    ;
data Type
    = string()
    ;
