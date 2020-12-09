
set serveroutput on
set verify off
prompt 'Digite el numero de partida...'
accept id char prompt 'Numero de partida: ' 
prompt 'Digite la posicion destino...'
accept source char prompt 'Posicion de inicio: ' 
prompt 'Digite la posicion origen...'
accept target char prompt 'Posicion final: ' 

DECLARE
  idpartida number := '&id';
  vsource VARCHAR2(2) := '&source';
  vtarget VARCHAR2(2) := '&target';
  
BEGIN
  select id into idpartida from matches where id = idpartida;
  moverPieza(idpartida,vsource, vtarget);  
  
EXCEPTION
  WHEN no_data_found THEN 
    DBMS_OUTPUT.PUT_LINE('La partida no existe');
END;
/