/* PROCEDIMIENTO PARA CREAR USUARIOS*/
CREATE OR REPLACE PROCEDURE AgregarUsuario (nombre varchar2 , user_name varchar2 ) is
   vid players.id%type := players_id_seq.nextval;
   vnombre players.name%type := nombre;
   vusername players.username%type := user_name;
BEGIN  
    Insert into players (id, name, username) values (vid,vnombre,vusername);
END AgregarUsuario;

/*PRUEBAS
EXEC AgregarUsuario('Johan', 'J');
EXEC AgregarUsuario('Andres', 'A');
EXEC AgregarUsuario('Kamil', 'K');
*/

/* PROCEDIMIENTO PARA VER USUARIOS*/
CREATE OR REPLACE PROCEDURE verUsuario (usuario varchar2 ) is  

     vusername players.username%type := usuario;
     vdatos players%rowtype;
BEGIN  
    SELECT * into vdatos 
    FROM players 
    WHERE username = vusername;
    DBMS_OUTPUT.PUT_LINE('Nombre completo:    ' || vdatos.name);
    DBMS_OUTPUT.PUT_LINE('Nombre del usuario: ' || vdatos.username);
    DBMS_OUTPUT.PUT_LINE('Total de juegos:    ' || vdatos.played_matches);
    DBMS_OUTPUT.PUT_LINE('Juegos ganados:     ' || vdatos.won_matches);
    DBMS_OUTPUT.PUT_LINE('Juegos empatados:   ' || vdatos.tied_matches);
    DBMS_OUTPUT.PUT_LINE('Juegos perdidos:    ' || vdatos.lost_matches);
       
END verUsuario;

/*
EXEC verUsuario('J');
EXEC verUsuario('A');
EXEC verUsuario('K');
*/


/*PROCEDIMIENTO PARA CREAR PARTIDA*/
CREATE OR REPLACE PROCEDURE crearPartida (usuario1 varchar2, usuario2 varchar2 )
is  
  vid matches.id%type := matches_id_seq.nextval;
  vstart_date matches.start_date%type := TO_DATE(sysdate);
  vturn matches.turn%type := 'B';
  vstatus matches.status%type := '1';
  id1 players.id%type;
  id2 players.id%type;
Begin
  select id into id1 from players where username = usuario1;
  select id into id2 from players where username = usuario2;

  Insert into matches (id, start_date, turn, players_id1, players_id2,status) 
                Values(vid,vstart_date,vturn,id1,id2,vstatus);
End crearPartida;

/*
EXEC crearPartida('J', 'K')
*/


