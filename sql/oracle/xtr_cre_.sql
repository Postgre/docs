SET PAUSE OFF
SET VERIFY OFF
SET HEADING OFF
SET LINESIZE 132
SET PAGESIZE 50000
SET FEEDBACK OFF

COLUMN	comde	FORMAT A80 	WRAPPED;
COLUMN	ligne	FORMAT A80 	WRAPPED;
COLUMN	tri 	FORMAT A20	NOPRINT;
COLUMN	id	FORMAT 999	NOPRINT;

SET TERMOUT ON

ACCEPT Tables CHAR PROMPT 'Nom de la table (ou [RETOUR] pour toutes) : '

SET TERMOUT OFF

BREAK ON tri SKIP 2;

SPOOL CLI_SQL:CRE_COM_&&Tables..SQL

/* ENTETE */

SELECT 'REM ************************************************************************
REM	Script de création des commentaires
REM	généré  le '||TO_CHAR(sysdate,'FMDD MON YYYY" à "HH24:MI')||' PAR '||user||'
REM ************************************************************************'
FROM dual;


/* COMPTE RENDU */

SELECT 'SPOOL CLI_SPL:CRE_COM_&&Tables..LIS' FROM dual;

/* TABLES */

SELECT 'REM' cmde,
       'PROMPT '||REPLACE(SUBSTR(A.comments,1,INSTR(A.comments,CHR(10))-1),CHR(39),CHR(39)||CHR(39))||' ('||A.table_name||').' ligne ,
		 A.table_name tri,
		 -1 id
FROM 	user_tab_comments A
WHERE A.table_name LIKE UPPER('&&Tables.%')
UNION
SELECT 'COMMENT ON TABLE '||B.table_name||' IS ' cmde,
	CHR(39)||REPLACE(B.comments,CHR(39),CHR(39)||CHR(39))||CHR(39)||';' ligne,
		 B.table_name tri,
		 0 id
FROM 	user_tab_comments B
WHERE B.table_name LIKE UPPER('&&Tables.%')
UNION
SELECT	'COMMENT ON COLUMN '||C.table_name||'.'||C.column_name||' IS ' cmde,
	CHR(39)||REPLACE(C.comments,CHR(39),CHR(39)||CHR(39))||CHR(39)||';' ligne,
		C.Table_name tri,
		1 id
FROM 	user_col_comments C
WHERE	C.table_name LIKE UPPER('&&Tables.%')
ORDER BY 3, 4;

/* FIN DE COMPTE RENDU */

SELECT 'SPOOL OFF' FROM dual;

/* SORTIE DE SQLPLUS */

SELECT 'EXIT' FROM dual;

SPOOL OFF

EXIT
