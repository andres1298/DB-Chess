clea screen
set serveroutput on
set verify off
prompt 'Buscar partida...'

accept usuario char prompt 'Digite el nombre del usuario para consultar las partidas: ' 

DECLARE
  vid players.id%type;
  vusuario players.username%type := '&usuario';
BEGIN   
    select id into vid FROM players  
    WHERE username = vusuario; 
    
    buscar(vid);
 
EXCEPTION
  WHEN no_data_found THEN     
   DBMS_OUTPUT.PUT_LINE ('El usuario no existe');   
  WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('No se encontró la partida solicitada');
END;

