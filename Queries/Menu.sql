prompt ****Men�****
prompt �Qu� desea realizar?
prompt opci�n 1: Jugar Partida
prompt opci�n 2: Crear Partida
prompt opci�n 3: Ver jugador
prompt opci�n 4: Crear jugador
prompt opci�n 0: Salir


DECLARE
 opcion number := &opcion;

 vnombre players.name%type;
 vuser   players.username%type;
 vuser2  players.username%type;
 
begin

--while opcion<0 and opcion>4 loop

 if opcion = 0 then 
   DBMS_OUTPUT.PUT_LINE ('Sali�');
   
 elsif  opcion = 1 then 
   DBMS_OUTPUT.PUT_LINE ('Jugar');
   
    elsif opcion = 2 then
     DBMS_OUTPUT.PUT_LINE ('Crear Partida');
     /*
     vuser  := '&Usuario1';
     vuser2 := '&Usuario2';
     crearPartida(vuser, vuser2);
     */
     elsif opcion = 3 then
       DBMS_OUTPUT.PUT_LINE ('Ver jugador');
       /*
       vuser:= '&Usuario';
       verUsuario(vuser);
       */
        elsif opcion = 4 then
          DBMS_OUTPUT.PUT_LINE ('Crear jugador');
          /*
            vnombre := '&Nombre';
            vuser := '&Usuario';
            AgregarUsuario(vnombre,vuser);
    */
 end if;
/*
  
  case opcion
    when 0 then DBMS_OUTPUT.PUT_LINE ('Sali�');
                 exit;
    when 1 then DBMS_OUTPUT.PUT_LINE ('Jugar');
                 exit;
    when 2 then DBMS_OUTPUT.PUT_LINE ('Crear Partida');
                
               vuser  := '&Usuario1';
               vuser2 := '&Usuario2';
               crearPartida(vuser, vuser2);               
               exit;
    when 3 then DBMS_OUTPUT.PUT_LINE ('Ver jugador');
                 vuser:= '&Usuario';
                 verUsuario(vuser);
                 exit;         
   when 4 then DBMS_OUTPUT.PUT_LINE ('Crear jugador');
               vnombre := '&Nombre';
               vuser := '&Usuario';
               AgregarUsuario(vnombre,vuser);
               exit; 
  end case;
  */
--end loop;
end;

