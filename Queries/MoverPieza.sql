CREATE OR REPLACE PROCEDURE moverPieza (matchID number, source VARCHAR2, target VARCHAR2) IS 

	matchTurn MATCHES.TURN%TYPE;
	sourcePiece PIECE;
	targetPiece PIECE;
	move boolean;
    checkmateBool boolean;
	currStatus MATCHES.STATUS%TYPE;
	-- Exceptions
	SOURCE_INCORRECT_SIZE EXCEPTION;
	TARGET_INCORRECT_SIZE EXCEPTION;
	ERROR_EXCEPTION EXCEPTION;
	GAME_IS_OVER EXCEPTION;
BEGIN
	-- Validaciones de formato 
	-- Posible implementar REGEX_LIKE para validar que contenga una letra entre A y H en la primera posicion y numeros del 1 al 8 en la segunda posicion
	IF LENGTH(source) <> 2 THEN
		RAISE SOURCE_INCORRECT_SIZE;
	ELSIF LENGTH(target) <> 2 THEN 
		RAISE TARGET_INCORRECT_SIZE;
	END IF;
	matchTurn := GETTURN(matchID);
	SELECT STATUS into currStatus from MATCHES where id = matchID;
	IF(currStatus=0) THEN
        RAISE GAME_IS_OVER;
    end if;
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
        	move:=PEON(source, target, sourcePiece, targetPiece, matchTurn, matchID);
		WHEN 't' THEN
			-- Funcion torre
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Torre');
			-- move:=ROOK(source, target, sourcePiece, targetPiece, matchID);
			DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(move));
		WHEN 'c' THEN
			-- Funcion caballo

        	move:=CABALLO(source, target, sourcePiece, targetPiece, matchID);

		WHEN 'a' THEN
			-- Funcion alfil
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Alfil');
			-- move:=BISHOP(source, target, sourcePiece, targetPiece, matchID);
			DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(move));
		WHEN 'd' THEN
			-- Funcion dama
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Dama');
			-- move:=QUEEN(source, target, targetPiece, matchID);
			DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(move));
		WHEN 'r' THEN
			-- Funcion rey
        	move:=REY(source, target, sourcePiece, targetPiece, matchID);

		ELSE
			-- Mensaje de error de pieza no encontrada
			DBMS_OUTPUT.PUT_LINE('Error de pieza');
	END CASE;
    
    IF move THEN
    checkmateBool:= CHECKMATE.CM(matchID, matchTurn);

         IF matchTurn = 1 then
           update matches set turn = 0 where id = matchID;
         ELSE
           update matches set turn = 1 where id = matchID;
         end if;

     IF(checkmateBool) THEN

         IF matchTurn = 1 then
           TERMINARJUEGO(matchID, 0);
           raise GAME_IS_OVER;
         ELSE
           TERMINARJUEGO(matchID, 1);
           raise GAME_IS_OVER;
         end if;
     end if;

         MostrarTablero(matchID);
    ELSE
        raise ERROR_EXCEPTION;
    end if;
     
	 
	EXCEPTION
		WHEN GAME_IS_OVER THEN
			DBMS_OUTPUT.PUT_LINE('La partida ha acabado');
		WHEN ERROR_EXCEPTION THEN
			DBMS_OUTPUT.PUT_LINE('Movimiento inválido');
		WHEN SOURCE_INCORRECT_SIZE THEN
			DBMS_OUTPUT.PUT_LINE('Las coordenadas de origen no tienen el formato adecuado');
		WHEN TARGET_INCORRECT_SIZE THEN
			DBMS_OUTPUT.PUT_LINE('Las coordenadas de destino no tienen el formato adecuado');
			
	-- DBMS_OUTPUT.PUT_LINE(sourcePieceCode || ' ' || sourcePieceColor || ' ' || matchTurn);
END;
/