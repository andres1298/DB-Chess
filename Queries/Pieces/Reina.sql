-- =========================================
-- Author: Andrés Bonilla
-- Create date: 21/11/2020
-- Description: Function that determines whether a queen movement is valid.
-- Returns: boolean
-- =========================================

CREATE OR REPLACE FUNCTION
QUEEN (source VARCHAR2, target VARCHAR2, targetData VARCHAR2, matchTurn NUMBER, matchID NUMBER) RETURN BOOLEAN
IS
    sourceRow NUMBER(1);
    targetRow NUMBER(1);
    sourceColumn NUMBER(1);
    targetColumn NUMBER(1);
    invalidFlag BOOLEAN := FALSE;
    errorFlag BOOLEAN := FALSE;
    pieceData PIECE;

BEGIN
    pieceData := PIECE();
    sourceColumn := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
    targetColumn := COLUMNTONUMBER(LOWER(SUBSTR(target, 1, 1)));
    sourceRow := TO_NUMBER(SUBSTR(source, 2, 2));
    targetRow := TO_NUMBER(SUBSTR(target, 2, 2));

    IF (sourceColumn = targetColumn AND sourceRow <> targetRow) OR (sourceColumn <> targetColumn AND sourceRow = targetRow) THEN
        IF sourceColumn = targetColumn AND sourceRow < targetRow THEN -- Movimiento vertical ascendente
            invalidFlag := MOV.VerticalAscending(sourceRow, targetRow, targetColumn, matchId, matchTurn);

        ELSIF sourceColumn = targetColumn AND sourceRow > targetRow THEN -- Movimiento vertical descendente
            invalidFlag := MOV.VerticalDescending(sourceRow, targetRow, targetColumn, matchId, matchTurn);
        
        ELSIF sourceColumn < targetColumn AND sourceRow = targetRow THEN -- Movimiento horizontal ascendente
            invalidFlag := MOV.HorizontalAscending(sourceColumn, targetRow, targetColumn, matchId, matchTurn);

        ELSIF sourceColumn > targetColumn AND sourceRow = targetRow THEN -- Movimiento horizontal descendente
            invalidFlag := MOV.HorizontalDescending(sourceColumn, targetRow, targetColumn, matchId, matchTurn);
        END IF;

    ELSIF ABS((sourceRow - targetRow)) = ABS((sourceColumn - targetColumn)) THEN
        IF sourceColumn < targetColumn AND sourceRow < targetRow THEN -- Movimiento horizontal ascendente hacia la derecha
            invalidFlag := MOV.RightDiagonalAscending(sourceRow, sourceColumn, targetRow, targetColumn, matchId, matchTurn);

        ELSIF sourceColumn < targetColumn AND sourceRow > targetRow THEN -- Movimiento horizontal descendente hacia la derecha
            invalidFlag := MOV.RightDiagonalDescending(sourceRow, sourceColumn, targetRow, targetColumn, matchId, matchTurn);
        
        ELSIF sourceColumn > targetColumn AND sourceRow < targetRow THEN -- Movimiento horizontal ascendente hacia la izquierda
            invalidFlag := MOV.LeftDiagonalAscending(sourceRow, sourceColumn, targetRow, targetColumn, matchId, matchTurn);

        ELSIF sourceColumn > targetColumn AND sourceRow > targetRow THEN -- Movimiento horizontal descendente hacia la izquierda
            invalidFlag := MOV.LeftDiagonalDescending(sourceRow, sourceColumn, targetRow, targetColumn, matchId, matchTurn);

        END IF;
    ELSE
        errorFlag := TRUE;
    END IF;

    IF errorFlag THEN
        DBMS_OUTPUT.PUT_LINE('El movimiento de la torre no es lineal.');
    ELSIF invalidFlag THEN
        DBMS_OUTPUT.PUT_LINE('Movimiento invalido. Hay una pieza en la coordenada');
    ELSE
        pieceData := TargetPosition(target, matchTurn, matchId);
        IF pieceData.Exist = 1 THEN
            DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND "COLUMN" = NUMBERTOCOLUMN(targetColumn) AND "ROW" = targetRow;
        END IF;
        
            UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(targetColumn), "ROW" = targetRow 
            WHERE MATCHES_ID = matchID AND "COLUMN" = NUMBERTOCOLUMN(sourceColumn) AND "ROW" = sourceRow;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Movimiento realizado.');
    END IF;

    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al ejecutar el movimiento de la torre');
END;
/