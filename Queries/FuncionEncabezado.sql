set serveroutput on
--recibe el id de la partida
CREATE OR REPLACE function encabezado (vid number) return VARCHAR2 is 
  id1 matches.players_id1%type;
  id2 matches.players_id2%type;
  turno matches.turn%type;
  mueve varchar2(7);
  nombre1 players.name%type;
  nombre2 players.name%type;
  resul varchar2(200);
BEGIN
  SELECT players_id1, players_id2,turn into id1, id2, turno from matches 
  where id = vid;
  SELECT name into nombre1 from players where id =id1;
  SELECT name into nombre2 from players where id =id2;

  IF turno = '1' THEN
   mueve := 'Blancas';
  ELSE
   mueve:= 'Negras';
  END IF;
  resul :=rpad('.',6)||' Blancas: ' || nombre1 ||' '|| lpad('  Negras: ' ||nombre2,25)||lpad('Mueve: '|| mueve,20);
  return resul;

END;

/*
Pruebas
update matches set turn = 'N' where id = 13;
update matches set turn = 'B' where id = 13;
*/