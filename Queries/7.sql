clea screen
set serveroutput on
set verify off

accept id char prompt 'Digite la partida la cual desea declarar empatada: ' 

DECLARE
  vid number := &id;
  id1 number;
  id2 number;
  i1 number;
  i2 number;
BEGIN  
   select players_id1 into id1 from matches where id = vid;
   select players_id2 into id2 from matches where id = vid;   
   
    SELECT tied_matches INTO i1 FROM PLAYERS where ID = id1;
    SELECT tied_matches INTO i2 FROM PLAYERS where ID = id2;
    UPDATE PLAYERS set tied_matches = i1+1 where ID = id1;
    UPDATE PLAYERS set tied_matches = i2+1 where ID = id2;  
 
EXCEPTION
  WHEN no_data_found THEN     
   DBMS_OUTPUT.PUT_LINE ('El usuario no existe');   
  WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('No se encontró la partida solicitada');
END;
/
