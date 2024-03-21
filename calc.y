%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);

#define MAX_VARS 100
int vars[MAX_VARS];
char* var_names[MAX_VARS];
int var_count = 0;

int find_var_index(char* name) {
    for (int i = 0; i < var_count; i++)
        if (strcmp(var_names[i], name) == 0) return i;
    return -1;
}

%}



%union {
    int ival;
    char* sval;
}

%token <ival>INTEGER <sval>VARIABLE ASSIGN PLUS MUL LPAR RPAR MINUS

%type <ival>expression <ival>term <ival>factor

%%

start
    :
    | start VARIABLE ASSIGN expression  { 
        int idx = find_var_index($2);
        if (idx == -1) {
            idx = var_count;
            var_names[var_count++] = strdup($2);
        }
        vars[idx] = $4;
    }
    | start expression               { printf("Result: %d\n", $2); }
    ;


expression
    : expression PLUS term { $$ = $1 + $3; }
    | expression MINUS term { $$ = $1 - $3; }
    | term               { $$ = $1; }
    ;

term
    : term MUL factor { $$ = $1 * $3; }
    | factor       { $$ = $1; }
    ;

factor
    : LPAR expression RPAR { $$ = $2; }
    | MINUS factor    { $$ = -$2; }
    | INTEGER         { $$ = $1; }
    | VARIABLE        {
        int idx = find_var_index($1);
        // printf("test: %d\n", idx);
        if (idx != -1) $$ = vars[idx];
        else $$ = 0;
    }
    ;
  
%%

int main(void) {
    printf("Enter expressions to calculate. Press Ctrl+C to exit.\n");
    while (1) {
        printf("> "); // 提示符，指示用户可以输入
        if (yyparse() != 0) { // yyparse() 返回 0 表示成功
            break; // 如果解析出错，退出循环
        }
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
