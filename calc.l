%{
#include "calc.tab.h"
%}

%%

[0-9]+  { yylval.ival = atoi(yytext); return INTEGER; }
"+"     { return PLUS; }
\n      { return 0; }
[ \t]   ; /* 忽略空格和制表符 */

%%
