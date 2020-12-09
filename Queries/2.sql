clea screen
set serveroutput on
set verify off
prompt 'Creando partida...'
accept usuario1 char prompt 'Digite el usuario 1: ' 
accept usuario2 char prompt 'Digite el usuario 2: '
DECLARE  
  id1 players.id%type;
  id2 players.id%type;
  vusuario1 players.username%type := '&usuario1';
  vusuario2 players.username%type := '&usuario2';
BEGIN
  select id into id1 from players where username = vusuario1;

  select id into id2 from players where username = vusuario2;
  
  CrearPartida(id1,id2);
  
EXCEPTION
  WHEN no_data_found THEN 
    DBMS_OUTPUT.PUT_LINE('Alguno de los usuarios digitados no existe');
END;
/
pause
