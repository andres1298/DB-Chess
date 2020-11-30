CREATE OR REPLACE PROCEDURE buscar( vid number) is
   id1 matches.players_id1%type;
   id2 matches.players_id2%type;
   vname1 players.name%type;
   vname2 players.name%type;
   cursor buscar is
   select * from matches  
   where players_id1 = vid or players_id2 = vid and status = '1'
   ORDER BY id ASC;

begin
DBMS_OUTPUT.PUT_LINE ('Número de juego  Fecha de inicio  Turno  Jugador 1  Jugador2');
      for i in buscar loop
        id1 := i.players_id1;
        id2 :=i.players_id2;
        select name into vname1 from players
        where id = id1;
  
        select name into vname2 from players
        where id = id2;
        DBMS_OUTPUT.PUT_LINE (lpad(i.id,8,' ')  || lpad(i.start_date, 20,' ')||
                              lpad(i.turn,9,' ') || lpad(vname1,10,' ') ||
                              lpad(vname2,12, ' '));
      
      end loop;
end;

