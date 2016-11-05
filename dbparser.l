%{
#include <stdio.h>
#include "y.tab.h"
extern YYSTYPE yylval;
%}
%%
SELECT {return TOKSELECT;}
[A-Za-z][A-Za-z0-9_]*	{ return NAME; }
%%
