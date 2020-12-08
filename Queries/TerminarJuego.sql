CREATE OR REPLACE PROCEDURE TerminarJuego(vid varchar, ganadorN number) is
  id1 number;
  id2 number;
  i1 number;
  i2 number;
  ganador PLAYERS.NAME%TYPE := '';
  color  VARCHAR2(10) := '';
BEGIN
   select players_id1 into id1 from matches where id = vid;
   select players_id2 into id2 from matches where id = vid;

   IF(ganadorN = 1) THEN
    color:='Blanco';
    SELECT WON_MATCHES, NAME INTO i1, ganador FROM PLAYERS where ID = id1;
    UPDATE PLAYERS set WON_MATCHES = i1+1 where ID = id1;
    SELECT LOST_MATCHES INTO i2 FROM PLAYERS where ID = id2;
    UPDATE PLAYERS set LOST_MATCHES = i2+1 where ID = id2;
       ELSE
    color:='Negro';
    SELECT LOST_MATCHES INTO i1 FROM PLAYERS where ID = id1;
    UPDATE PLAYERS set LOST_MATCHES = i1+1 where ID = id1;
    SELECT WON_MATCHES, NAME INTO i2, ganador FROM PLAYERS where ID = id2;
    UPDATE PLAYERS set WON_MATCHES = i2+1 where ID = id2;
   end if;

   UPDATE MATCHES set STATUS = '0' WHERE ID = vid;
   DBMS_OUTPUT.PUT_LINE('El ganador de la partida ' || vid || ' es: ' || ganador || '('||color||').');

EXCEPTION
  WHEN no_data_found THEN
   DBMS_OUTPUT.PUT_LINE ('El usuario no existe');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('No se encontro la partida');
END;
/