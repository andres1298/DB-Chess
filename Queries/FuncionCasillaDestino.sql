-- =========================================
-- Author: Andres Bonilla
-- Create date: 16/11/2020
-- Description: Function that obtains and returns the code and display code of the piece in the target position entered by the user
-- Parameters:
-- 		@position: VARCHAR2 with the position entered by the user. Format had to be valited beforehand
-- 		@matchTurn: CHAR with code of the current turn in the match. Used to valite if the selected piece belongs to the current player.
-- Returns: VARCHAR2 containing the code and display code of the selected piece separated by a comma.  If error, returns NULL. If NO_DATA_FOUND returns emptyValue constant
-- =========================================

CREATE OR REPLACE FUNCTION
TargetPosition (position VARCHAR2, matchTurn CHAR, matchId number) RETURN PIECE
IS
	pieceData PIECE;

	-- EXCEPTIONS
	PIECE_DOESNOT_MATCH EXCEPTION;
BEGIN
	pieceData := PIECE();
	SELECT P.CODE, P.DISPLAY, P.COLOR INTO pieceData.CODE, pieceData.DISPLAY, pieceData.COLOR
	FROM PIECES_PER_MATCH PPM
	JOIN PIECES P ON (PPM.PIECES_CODE = P.CODE)
	WHERE "ROW" = TO_NUMBER(SUBSTR(position, 2, 2)) AND "COLUMN" = LOWER(SUBSTR(position, 1, 1))
	AND PPM.MATCHES_ID = matchId;
	
	IF pieceData.COLOR = matchTurn THEN
		RAISE PIECE_DOESNOT_MATCH;
	END IF;
	
	RETURN pieceData;
	
	EXCEPTION
		
		WHEN PIECE_DOESNOT_MATCH THEN
			DBMS_OUTPUT.PUT_LINE('La casilla de destino contiene una pieza aliada');
			RETURN NULL;
		WHEN NO_DATA_FOUND THEN	-- The target position is empty. Hence the user can make the move if the piece algorithm validated later is also correct
			pieceData.EMPTY := 1;
			RETURN pieceData;
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Error al validar la posicion de destino. Por favor intente de nuevo');
			RETURN NULL;
END ;
/