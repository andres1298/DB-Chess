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
TargetPosition (position VARCHAR2, matchTurn CHAR, matchId number, withException boolean DEFAULT FALSE) RETURN PIECE
IS
	pieceData PIECE;
	X NUMBER;
	Y NUMBER;

	-- EXCEPTIONS
	PIECE_DOESNOT_MATCH EXCEPTION;
    NONEXISTING_COORDINATES EXCEPTION;
BEGIN

    IF(length(position) = 2) THEN
        X:=TO_NUMBER(SUBSTR(position, 2, 2));
        Y:=COLUMNTONUMBER(LOWER(SUBSTR(position, 1, 1)));
    ELSE
        RAISE NONEXISTING_COORDINATES;
    end if;

    IF(x <= 0 OR x >= 9 OR y <= 0 OR y >= 9) THEN
        RAISE NONEXISTING_COORDINATES;
    end if;

	pieceData := PIECE();
	SELECT P.CODE, P.DISPLAY, P.COLOR INTO pieceData.CODE, pieceData.DISPLAY, pieceData.COLOR
	FROM PIECES_PER_MATCH PPM
	JOIN PIECES P ON (PPM.PIECES_CODE = P.CODE)
	WHERE "ROW" = TO_NUMBER(SUBSTR(position, 2, 2)) AND "COLUMN" = LOWER(SUBSTR(position, 1, 1))
	AND PPM.MATCHES_ID = matchId;

	IF pieceData.COLOR = matchTurn AND withException THEN
		RAISE PIECE_DOESNOT_MATCH;
	END IF;

	pieceData.EXIST := 1;
	
	RETURN pieceData;
	
	EXCEPTION
        WHEN NONEXISTING_COORDINATES THEN
			RETURN NULL;
        WHEN PIECE_DOESNOT_MATCH THEN
			DBMS_OUTPUT.PUT_LINE('La casilla de destino contiene una pieza aliada');
			RETURN NULL;
		WHEN NO_DATA_FOUND THEN	-- The target position is empty. Hence the user can make the move if the piece algorithm validated later is also correct
			pieceData.EXIST := 0;
			RETURN pieceData;
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Error al validar la posicion de destino. Por favor intente de nuevo');
			RETURN NULL;
END ;
/