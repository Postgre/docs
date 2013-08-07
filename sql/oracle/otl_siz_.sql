REM ****************************************************************************
REM Nom: OTL_CMP_OBJ
REM Objet: Surveillance des tailles pour les tables et index
REM Auteur: DOMAS C.
REM Création: 17/07/97
REM
REM Paramètre: aucun
REM
REM
REM ****************************************************************************
SET LINESIZE 80
SET PAGESIZE 4000
SET FEEDBACK OFF

SPOOL AFP_SPL:OTL_SIZ_OBJ.LIS

SET HEADING OFF
SELECT  'Liste des tables et index avec leurs tailles de '
      || substr(global_name,1,instr(global_name,'.')-1)
FROM global_name
/

SET HEADING ON
COLUMN  C0     	FORMAT A5       HEADING "TYPE"
COLUMN  C1      FORMAT  A20     HEADING "NOM"

BREAK ON C0 SKIP 1

select 	segment_type C0,
	segment_name C1,
	bytes,extents,
	initial_extent,
	next_extent
from user_segments
order by segment_type desc,segment_name
/
select tablespace_name,sum(bytes),sum(initial_extent)
from user_segments
group by tablespace_name
/
PROMPT
PROMPT
PROMPT TOTAL:
select sum(bytes),sum(initial_extent)
from user_segments
/

PROMPT
PROMPT Résultats dans AFP_SPL:OTL_SIZ_OBJ.LIS
PROMPT

spool off
exit
