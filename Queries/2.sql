clea screen
set serveroutput on
set verify off
prompt 'Creando partida...'
accept usuario1 char prompt 'Digite el usuario 1: ' 
accept usuario2 char prompt 'Digite el usuario 2: '

DECLARE
  vid matches.id%type := matches_id_seq.nextval;
  vstart_date matches.start_date%type := TO_DATE(sysdate);
  vturn matches.turn%type := 'B';
  vstatus matches.status%type := '1';
  id1 players.id%type;
  id2 players.id%type;
  vusuario1 players.username%type := '&usuario1';
  vusuario2 players.username%type := '&usuario2';
BEGIN
  select id into id1 from players where username = vusuario1;
  select id into id2 from players where username = vusuario2;
  
   Insert into matches (id, start_date, turn, players_id1, players_id2,status) 
                Values(vid,vstart_date,vturn,id1,id2,vstatus);
  DBMS_OUTPUT.PUT_LINE ('Partida creada exitosamente');
 
END;
/
pause
-- acá invocamos el inicio del juego 