clea screen
set serveroutput on
set verify off
prompt 'Estadisticas del jugar...'

accept usuario char prompt 'Digite el nombre del usuario que desea consultar: ' 

DECLARE 
  vusuario players.username%type := '&usuario';
BEGIN
  verUsuario(vusuario);
  
EXCEPTION
  WHEN no_data_found THEN 
    DBMS_OUTPUT.PUT_LINE('El usuario no existe');
    
    
END;
/
PAUSE
START menu