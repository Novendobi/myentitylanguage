module Syntax

extend Lexical;

start syntax MyEntityLang 
            = entitylang: "module" Id Entity*
            ;
syntax Entity 
            = entity: "entity" Id Attribute* "key" "(" Id ")" "end"
            ;
syntax Attribute 
            = attribute: Id ":" Type
            | relationattr: Association
            ;
syntax Type
            = integer: "Integer"
            | string: "String"
            | boolean: "Boolean"
            ;
syntax Association
            = onetoone:Id "-\>" Id //one to one or foreignkey
            | onetomany: Id "-\>" "List" "[" Id "]" //one to many
            | manytomany: "List" "[" Id "]" "-\>" "List" "[" Id "]" // many to many
            ;