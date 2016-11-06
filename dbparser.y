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
%union
{
int number;
char *string;
}
%token SELECT CREATE FROM TABLE ATTSTART ATTEND INT STR20 COMA 
%token <number>INTEGER 
%token <string> STRING
%token <string> NAME
%%
commands: /* empty */
               | commands command
               ;
       command:
               create_table_statement
               ;
       create_table_statement:
               CREATE TABLE table_name ATTSTART attribute_type_list ATTEND
               {
                       printf("\tcreate table statement new\n");
               }
	       |
	       CREATE NAME
               {
			printf("No table\n");
	       }
               ;
	attribute_type_list:
		attribute_name data_type
		|
		attribute_name data_type COMA attribute_type_list
		;
	attribute_name:
		NAME
		{
			printf("Attr name %s \t",$1);
		}
		;
	table_name:
		NAME
		{
			printf("Table Name : %s\n",$1);
		}
		|
		NAME '.' NAME
		{
			printf("Table Name : %s\n",$1);
	
		}
		;
	data_type:
		INT
		{
			printf("Attr type : INT\n");
		}
		|
		STR20
		{
			
			printf("Attr type : STR20\n");
		}
		; 
%%

