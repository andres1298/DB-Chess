set serveroutput on
set verify off
prompt 'Digite el numero de partida...'
accept id char prompt 'Numero de partida: ' 

DECLARE
  idpartida number := '&id';
  
BEGIN
  select id into idpartida from matches where id = idpartida;
  MostrarTablero(idpartida);  
  
EXCEPTION
  WHEN no_data_found THEN 
    DBMS_OUTPUT.PUT_LINE('La partida no existe');
END;
/

--select * from matches