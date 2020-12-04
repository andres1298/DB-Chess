create or replace PROCEDURE verUsuario (usuario varchar2 ) is  

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