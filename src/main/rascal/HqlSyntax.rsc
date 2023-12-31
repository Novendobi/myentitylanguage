module HqlSyntax

extend Lexical;

start syntax Hlang 
    = hlang: HEntity*
    ;
syntax HEntity
    = entity: "CREATE TABLE IF NOT EXISTS" Id "(" {Column ","}* ")" "STORED AS PARQUET" ";"
    ;
syntax Column
    = column: Id Type
    ;
syntax Type
    = string: "STRING"
    ;