module HqlToText

import HqlAst;
import List;

public str hqlProgramToText(Hlang p) {
  switch(p) {
    case hlang(hEntities): 
      return "<intercalate("\n\n", [hqlEntityToText(e) | e <- hEntities])>";
    default: return "";
  }
}

public str hqlEntityToText(HEntity e) {
  switch(e) {
    case entity(name, columns): 
      return 
"CREATE TABLE IF NOT EXISTS <name> (
    <intercalate(",\n    ", [hqlColumnToText(c) | c <- columns])>
)\nSTORED AS PARQUET;";
    default: return "";
  }
}

public str hqlColumnToText(Column c) {
  switch(c) {
    case column(cName, types): 
      return "<cName> <hqlTypeToText(types)>";
    default: return "";
  }
}

public str hqlTypeToText(Type t) {
  switch(t) {
    case string(): return "STRING";
    default: return "";
  }
}
