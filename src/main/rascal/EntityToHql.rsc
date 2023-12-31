module EntityToHql

import HqlAst;
import HqlSyntax;
import Ast;
import Syntax;

public Hlang transformProgramToHql(MyEntityLang lang) {
  switch(lang) {
    case entitylang(modulename, entities): 
      return hlang([transformEntityToHql(e) | e <- entities]);
    default: return hlang([]);
  }
}

public HEntity transformEntityToHql(Entity entity) {
  switch(entity) {
    case entity(eName, attribute, keyId): 
      return HqlAst::entity(eName, [transformAttributeToHql(a) | a <- attribute]);
    default: return HqlAst::entity("", []);
  }
}

public Column transformAttributeToHql(Attribute aattribute) {
  switch(aattribute) {
    case attribute(aName, typename): 
      return column(aName, transformTypeToHql(typename));
    case relationattr(onetomany(omname, omentity)): 
      return column(omname, HqlAst::string());
    default: return column("", HqlAst::string());
  }
}

public HqlAst::Type transformTypeToHql(Type types) {
  switch(types) {
    case string():
        return HqlAst::string();
    default: throw "Unsupported type: <types>";
  }
}
