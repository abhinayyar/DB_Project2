%{
#include <stdio.h>
#include <string.h>
extern FILE *yyin;
extern "C"
{
    int yyparse(void);
    int yylex(void);  
    int yywrap()
    {
       return 1;
    }
	
}
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
int main(int ac, char **av)
{
	if(ac > 1 && (yyin = fopen(av[1], "r")) == NULL) {
		perror(av[1]);
		return 1;
	}

	if(!yyparse())
		printf("SQL parse worked\n");
	else
		printf("SQL parse failed\n");

	return 0;
}
%}
%token TOKSELECT NAME
%%
commands: /* empty */
               | commands command
               ;

       command:
               select_statement
               ;

       select_statement:
               TOKSELECT NAME
               {
                       printf("\tSelect identified as sql statement\n");
               }
               ; 
%%

