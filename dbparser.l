%{
#include <stdio.h>
#include "y.tab.h"
extern YYSTYPE yylval;
%}
%%
SELECT {return SELECT;}
CREATE {return CREATE;}
TABLE {return TABLE;}
FROM {return FROM;}
INT {return INT;}
STR20 {return STR20;}
\( {return ATTSTART;}
\) {return ATTEND;}
, {return COMA;}
[A-Za-z][A-Za-z0-9_]*	{ yylval.string = strdup(yytext); return NAME; }
[0-9]+	|
[0-9]+"."[0-9]* |
"."[0-9]*	{ yylval.number=atoi(yytext); return INTEGER; }
'[^'\n]*'	{
		int c = input();

		unput(c);	/* just peeking */
		if(c != '\'') {
			yylval.string=strdup(yytext);
			return STRING;
		} else
			yymore();
	}
[ \t\r]+	;	/* white space */		
%%
