-- =========================================
-- Author: Kamil Sauma
-- Create date: 29/11/2020
-- Description: Function that determines whether a king movement is valid.
-- Returns: boolean
-- =========================================

CREATE OR REPLACE FUNCTION
REY (source VARCHAR2, target VARCHAR2, sourceData PIECE, targetData PIECE, matchID NUMBER) RETURN BOOLEAN
IS
    ROW1 NUMBER(1);
    ROW2 NUMBER(1);
    COLUMN1 NUMBER(1);
    COLUMN2 NUMBER(1);
BEGIN

    COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
    COLUMN2 := COLUMNTONUMBER(LOWER(SUBSTR(target, 1, 1)));
    ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
    ROW2 := TO_NUMBER(SUBSTR(target, 2, 2));

    DBMS_OUTPUT.PUT_LINE('T display: ' || targetData.DISPLAY || ' T exists: ' || targetData.EXIST);
    DBMS_OUTPUT.PUT_LINE(row1 || ', ' || NUMBERTOCOLUMN(column1));
    DBMS_OUTPUT.PUT_LINE(row2 || ', ' || NUMBERTOCOLUMN(column2));
        IF((ROW1+1 = ROW2 AND COLUMN1-1 = COLUMN2) OR
           (ROW1+1 = ROW2 AND COLUMN1 = COLUMN2) OR
           (ROW1+1 = ROW2 AND COLUMN1+1 = COLUMN2) OR
           (ROW1 = ROW2 AND COLUMN1-1 = COLUMN2) OR
           (ROW1 = ROW2 AND COLUMN1+1 = COLUMN2) OR
           (ROW1-1 = ROW2 AND COLUMN1-1 = COLUMN2) OR
           (ROW1-1 = ROW2 AND COLUMN1 = COLUMN2) OR
           (ROW1-1 = ROW2 AND COLUMN1+1 = COLUMN2)) then
            DBMS_OUTPUT.PUT_LINE('Sí es movimiento valido (quitar comentarios para eliminar)');


            /*
            IF(targetData.EXIST = 1) then
                DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND PIECES_CODE = targetData.DISPLAY;
            end if;
            UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND PIECES_CODE = sourceData.DISPLAY;
            */
            RETURN TRUE;
        END IF;

    RETURN FALSE;
END;
/