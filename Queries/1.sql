clea screen
prompt 'Creando usuario...'
accept nombre char prompt 'Digite su nombre completo: ' 
accept user char prompt 'Digite su usuario de juego: '

DECLARE
  
  vid players.id%type := players_id_seq.nextval;
  vnombre players.name%type := '&nombre';
  vusername players.username%type := '&user';
BEGIN
  Insert into players (id, name, username) values (vid,vnombre,vusername);
  DBMS_OUTPUT.PUT_LINE ('Jugador creado exitosamente');
  DBMS_OUTPUT.PUT_LINE ('Nombre: '||            vnombre );
  DBMS_OUTPUT.PUT_LINE ('Nombre de usuario: '|| vusername );
  
EXCEPTION
  WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('El nombre de usuario ya existe');
    
END;
/
pause
start menu




