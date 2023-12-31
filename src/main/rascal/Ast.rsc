module Ast

import Syntax;

data MyEntityLang
            = entitylang(str modulename, list[Entity] entities)
            ;
data Entity
            = entity(str eName, list[Attribute], str keyId)
            ;
data Attribute
            = attribute(str aName, Type typename)
            | relationattr(Association association)
            ;
data Type
            = integer()
            | string()
            | boolean()
            ;
data Association
            = onetoone(str ooname, str ooentity)
            | onetomany(str omname, str omentity)
            | manytomany(str mmname, str mmentity)
            ;