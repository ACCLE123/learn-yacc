%{
#include "calc.tab.h"
%}

%%

[0-9]+  { yylval.ival = atoi(yytext); return INTEGER; }
[a-zA-Z]+ { yylval.sval = strdup(yytext); return VARIABLE; }
"="     { return ASSIGN; }
"+"     { return PLUS; }
"-"     { return MINUS; }
"*"     { return MUL; }
"("     { return LPAR; }
")"     { return RPAR; }
\n      { return 0; }
[ \t]   

%%
