clear screen
set serveroutput on
set verify off
prompt Que desea realizar?
prompt 1.Crear usuario.
prompt 2.Crear partida.
prompt 3.Ver Jugador
prompt 0.Salir
prompt 
accept op number prompt 'Digite la opcion: '
start &op
