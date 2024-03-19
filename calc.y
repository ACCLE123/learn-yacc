%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *s);
%}

%union {
    int ival;
}

%token <ival> INTEGER
%token PLUS

%type <ival> expression

%%
/* 语法规则开始 */

calculation:
    expression               { printf("Result: %d\n", $1); }
    ;

expression:
    INTEGER                  { $$ = $1; }
    | expression PLUS INTEGER { $$ = $1 + $3; }
    ;

%%
/* 辅助函数 */

int main(void) {
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
