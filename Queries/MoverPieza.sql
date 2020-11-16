DECLARE
	source VARCHAR2(2) := 'A1'; 
	target VARCHAR2(2) := 'A7'; 
	proceed BOOLEAN := FALSE;
	matchID NUMBER := 4;
	sourcePieceCode PIECES_PER_MATCH.PIECES_CODE%TYPE;
	sourcePieceColor PIECES_PER_MATCH.COLOR%TYPE;
	targetPieceCode PIECES_PER_MATCH.PIECES_CODE%TYPE;
	targetPieceColor PIECES_PER_MATCH.COLOR%TYPE;
	matchTurn MATCHES.TURN%TYPE;
	
	-- Exceptions
	PIECE_DOESNOT_MATCH EXCEPTION;
BEGIN 
	-- Query to get the piece in the source position
	SELECT PIECES_CODE, COLOR, TURN INTO sourcePieceCode, sourcePieceColor, matchTurn
	FROM PIECES_PER_MATCH PPM 
	JOIN MATCHES M ON (PPM.MATCHES_ID = M.ID)
	WHERE "ROW" = TO_NUMBER(SUBSTR(source, 2, 2)) AND "COLUMN" = LOWER(SUBSTR(source, 1, 1));
	
	-- Query to get the piece in the target position
	SELECT PIECES_CODE, COLOR INTO targetPieceCode, targetPieceColor
	FROM PIECES_PER_MATCH PPM 
	WHERE "ROW" = TO_NUMBER(SUBSTR(target, 2, 2)) AND "COLUMN" = LOWER(SUBSTR(target, 1, 1));
	-- Crear una funcion que retorne la pieza al enviarle las coordenadas. Una para el source y otra para target
	-- Ya que el manejo de las excepciones debe ser diferente

	-- Validations of the move
	IF sourcePieceColor <> matchTurn THEN
		RAISE PIECE_DOESNOT_MATCH;
	END IF;
	
	EXCEPTION
		WHEN PIECE_DOESNOT_MATCH THEN
			DBMS_OUTPUT.PUT_LINE('La pieza seleccionada pertenece al jugador contrario');
		
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('La casilla seleccionada esta vacia');
			
	-- DBMS_OUTPUT.PUT_LINE(sourcePieceCode || ' ' || sourcePieceColor || ' ' || matchTurn);
END;
/