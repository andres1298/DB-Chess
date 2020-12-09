SET LINE 500

set serveroutput on
set verify off
prompt Que desea realizar?
prompt 1.Crear usuario.
prompt 2.Crear partida.
prompt 3.Ver Jugador.
prompt 4.Buscar partida.
prompt 5.Mostrar tablero
prompt 6.Mover pieza
prompt 7.Declarar empate
prompt 0.Salir
prompt 

accept op number prompt 'Digite la opcion: '
start &op



