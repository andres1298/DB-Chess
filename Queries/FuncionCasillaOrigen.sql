-- =========================================
-- Author: Andres Bonilla
-- Create date: 16/11/2020
-- Description: Function that obtains and returns the code and display code of the piece in the source position entered by the user
-- Parameters:
-- 		@position: VARCHAR2 with the position entered by the user. Format had to be valited beforehand
-- 		@matchTurn: CHAR with code of the current turn in the match. Used to valite if the selected piece belongs to the current player.
-- Returns: VARCHAR2 containing the code and display code of the selected piece separated by a comma.  If error, returns NULL
-- =========================================

CREATE OR REPLACE FUNCTION 
SourcePosition (position VARCHAR2, matchTurn CHAR, matchId number) RETURN PIECE
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
	
	IF pieceData.COLOR <> matchTurn THEN
		RAISE PIECE_DOESNOT_MATCH;
	END IF;

	pieceData.EXIST := 1;

	RETURN pieceData;
	
	EXCEPTION
		
		WHEN PIECE_DOESNOT_MATCH THEN
			DBMS_OUTPUT.PUT_LINE('La pieza seleccionada pertenece al jugador contrario');
			RETURN NULL;
		WHEN NO_DATA_FOUND THEN
		    pieceData.EXIST := 0;
			DBMS_OUTPUT.PUT_LINE('La casilla de origen se encuentra vacia');
			RETURN NULL;
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Error al obtener la pieza de origen. Por favor intente de nuevo');
			RETURN NULL;
END ;
/