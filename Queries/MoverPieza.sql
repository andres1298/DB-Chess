CREATE OR REPLACE PROCEDURE moverPieza (matchID number, source VARCHAR2, target VARCHAR2) IS 

	matchTurn MATCHES.TURN%TYPE;
	sourcePiece PIECE;
	targetPiece PIECE;
	move boolean;
    checkmateBool boolean;
	-- Exceptions
	SOURCE_INCORRECT_SIZE EXCEPTION;
	TARGET_INCORRECT_SIZE EXCEPTION;
	ERROR_EXCEPTION EXCEPTION;
BEGIN
	-- Validaciones de formato 
	-- Posible implementar REGEX_LIKE para validar que contenga una letra entre A y H en la primera posicion y numeros del 1 al 8 en la segunda posicion
	IF LENGTH(source) <> 2 THEN
		RAISE SOURCE_INCORRECT_SIZE;
	ELSIF LENGTH(target) <> 2 THEN 
		RAISE TARGET_INCORRECT_SIZE;
	END IF;
	matchTurn := GETTURN(matchID);
	IF matchTurn IS NOT NULL THEN
		sourcePiece := SourcePosition(source, matchTurn, matchID);
		targetPiece := TargetPosition(target, matchTurn, matchID, true);
		IF sourcePiece IS NULL OR targetPiece IS NULL THEN
			-- Si se obtiene un valor nulo (un error) se imprime el error de cada funcion y se retonar un valor para ejecutar el ciclo de la partida de nuevo
			-- RETURN TRUE;
			DBMS_OUTPUT.PUT_LINE('Error');
			raise ERROR_EXCEPTION;
		END IF;
	-- Si no se puede obtener el ID de la partida, se muestra el mensaje de error obtenido en la funcion GetTurn 
	-- y se retorna un valor para ejecutar el ciclo de la partida de nuevo
	
	-- ELSE 
		-- RETURN TRUE;
	END IF;

	CASE LOWER(sourcePiece.DISPLAY)
		
		WHEN 'p' THEN
			-- Funcion peon
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Peon');


        	DBMS_OUTPUT.PUT_LINE(sourcePiece.DISPLAY);
        	DBMS_OUTPUT.PUT_LINE(targetPiece.DISPLAY);
        	move:=PEON(source, target, sourcePiece, targetPiece, matchTurn, matchID);
			DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(move));
			-- MOVE=1 Se movió 0 = No

		WHEN 't' THEN
			-- Funcion torre
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Torre');
		WHEN 'c' THEN
			-- Funcion caballo

			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo caballo');


        	DBMS_OUTPUT.PUT_LINE(sourcePiece.DISPLAY);
        	DBMS_OUTPUT.PUT_LINE(targetPiece.DISPLAY);
        	move:=CABALLO(source, target, sourcePiece, targetPiece, matchID);
			DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(move));
			-- MOVE=1 Se movió 0 = No
		WHEN 'a' THEN
			-- Funcion alfil
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Alfil');
		WHEN 'd' THEN
			-- Funcion dama
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Dama');
		WHEN 'r' THEN
			-- Funcion rey
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Rey');
			DBMS_OUTPUT.PUT_LINE(sourcePiece.DISPLAY);
        	DBMS_OUTPUT.PUT_LINE(targetPiece.DISPLAY);
        	move:=REY(source, target, sourcePiece, targetPiece, matchID);
			DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(move));
		ELSE
			-- Mensaje de error de pieza no encontrada
			DBMS_OUTPUT.PUT_LINE('Error de pieza');
	END CASE;
    
    IF move THEN
     IF matchTurn = 1 then 
       update matches set turn = 0 where id = matchID;
     ELSE
       update matches set turn = 1 where id = matchID;
     end if;
       MostrarTablero(matchID);
    
    end if;
     
	 
	EXCEPTION
		WHEN ERROR_EXCEPTION THEN
			DBMS_OUTPUT.PUT_LINE('Movimiento inválido');
		WHEN SOURCE_INCORRECT_SIZE THEN
			DBMS_OUTPUT.PUT_LINE('Las coordenadas de origen no tienen el formato adecuado');
		WHEN TARGET_INCORRECT_SIZE THEN
			DBMS_OUTPUT.PUT_LINE('Las coordenadas de destino no tienen el formato adecuado');
			
	-- DBMS_OUTPUT.PUT_LINE(sourcePieceCode || ' ' || sourcePieceColor || ' ' || matchTurn);
END;
/