DECLARE
	source VARCHAR2(2) := 'A1'; 
	target VARCHAR2(2) := 'A7'; 
	matchID NUMBER := 3;
	matchTurn MATCHES.TURN%TYPE;
	proceed BOOLEAN := FALSE;
	
	sourceData VARCHAR2(10);
	targetData VARCHAR2(10);
	
	-- Exceptions
	SOURCE_INCORRECT_SIZE EXCEPTION;
	TARGET_INCORRECT_SIZE EXCEPTION;
BEGIN 
	-- Validaciones de formato 
	-- Posible implementar REGEX_LIKE para validar que contenga una letra entre A y H en la primera posicion y numeros del 1 al 8 en la segunda posicion
	IF LENGTH(source) <> 2 THEN
		RAISE SOURCE_INCORRECT_SIZE;
	ELSIF LENGTH(target) <> 2 THEN 
		RAISE TARGET_INCORRECT_SIZE;
	END IF;
	
	matchTurn := GetTurn(matchID);
	IF matchTurn IS NOT NULL THEN
		sourceData := SourcePosition(source, matchTurn);
		targetData := TargetPosition(target, matchTurn);
		IF sourceData IS NULL OR targetData IS NULL THEN
			-- Si se obtiene un valor nulo (un error) se imprime el error de cada funcion y se retonar un valor para ejecutar el ciclo de la partida de nuevo
			-- RETURN TRUE;
			DBMS_OUTPUT.PUT_LINE('Error');
		END IF;
	-- Si no se puede obtener el ID de la partida, se muestra el mensaje de error obtenido en la funcion GetTurn 
	-- y se retorna un valor para ejecutar el ciclo de la partida de nuevo
	
	-- ELSE 
		-- RETURN TRUE;
	END IF;
	
	CASE LOWER(SUBSTR(sourceData, INSTR(sourceData, ',') + 1))
		WHEN 'p' THEN
			-- Funcion peon
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Peon');
		WHEN 't' THEN
			-- Funcion torre
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Torre');
		WHEN 'c' THEN
			-- Funcion caballo
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Caballo');
		WHEN 'a' THEN
			-- Funcion alfil
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Alfil');
		WHEN 'd' THEN
			-- Funcion dama
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Dama');
		WHEN 'r' THEN
			-- Funcion rey
			DBMS_OUTPUT.PUT_LINE('Ejecutar algoritmo Rey');
		ELSE
			-- Mensaje de error de pieza no encontrada
			DBMS_OUTPUT.PUT_LINE('Error de pieza');
	END CASE;
		
	DBMS_OUTPUT.PUT_LINE('Source: ' || sourceData || ' Target: ' || targetData || ' Turn: ' || matchTurn);
	 
	EXCEPTION
		
		WHEN SOURCE_INCORRECT_SIZE THEN
			DBMS_OUTPUT.PUT_LINE('Las coordenadas de origen no tienen el formato adecuado');
		WHEN TARGET_INCORRECT_SIZE THEN
			DBMS_OUTPUT.PUT_LINE('Las coordenadas de destino no tienen el formato adecuado');
			
	-- DBMS_OUTPUT.PUT_LINE(sourcePieceCode || ' ' || sourcePieceColor || ' ' || matchTurn);
END;
/