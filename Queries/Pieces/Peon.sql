-- =========================================
-- Author: Kamil Sauma
-- Create date: 17/11/2020
-- Description: Function that determines whether a pawn movement is valid.
-- Returns: boolean
-- =========================================

CREATE OR REPLACE FUNCTION
PEON (source VARCHAR2, target VARCHAR2, sourceData PIECE, targetData PIECE, matchTurn MATCHES.TURN%TYPE, matchID NUMBER) RETURN BOOLEAN
IS
    ROW1 NUMBER(1);
    ROW2 NUMBER(1);
    COLUMN1 NUMBER(1);
    COLUMN2 NUMBER(1);
	CHECKPOS PIECE;
BEGIN

    COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
    COLUMN2 := COLUMNTONUMBER(LOWER(SUBSTR(target, 1, 1)));
    ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
    ROW2 := TO_NUMBER(SUBSTR(target, 2, 2));

    --DBMS_OUTPUT.PUT_LINE('T display: ' || targetData.DISPLAY || ' T exists: ' || targetData.EXIST);

    IF(matchTurn=1) then
        --DBMS_OUTPUT.PUT_LINE('Blanco');

        IF((targetData.EXIST = 1) AND ((ROW1+1)=ROW2) AND (((COLUMN1 + 1) = COLUMN2) OR (COLUMN1 - 1) = COLUMN2)) THEN
            --DBMS_OUTPUT.PUT_LINE('Sí es diagonal (quitar comentarios para eliminar)');


            DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND PIECES_CODE = targetData.CODE;
            UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;
            IF(ROW2=8)THEN
                DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;
                INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BD'||SUBSTR(sourceData.CODE, 3,1), matchID, ROW2, NUMBERTOCOLUMN(COLUMN2), 1);
                DBMS_OUTPUT.PUT_LINE('El peon se ha convertido.');
            end if;
            RETURN TRUE;
        END IF;


        CHECKPOS := TargetPosition(UPPER(NUMBERTOCOLUMN(COLUMN1)) || '' || (ROW1+1), matchTurn, matchID, true);

        IF(CHECKPOS.EXIST = 0 AND COLUMN1 = COLUMN2 AND (ROW1 + 1 = ROW2 OR ((ROW1 = 2) AND ((ROW1 + 2 = ROW2) OR (ROW1 + 1 = ROW2))))) then
            --DBMS_OUTPUT.PUT_LINE('Sí es movimiento normal (quitar comentarios para eliminar)');

            UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;
            IF(ROW2=8)THEN
                DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;
                INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BD'||SUBSTR(sourceData.CODE, 3,1), matchID, ROW2, NUMBERTOCOLUMN(COLUMN2), 1);
                DBMS_OUTPUT.PUT_LINE('El peon se ha convertido.');
            end if;
            RETURN TRUE;
        END IF;
    ELSE
        --DBMS_OUTPUT.PUT_LINE('Negro');
        IF((targetData.EXIST = 1) AND ((ROW1-1)=ROW2) AND (((COLUMN1 - 1) = COLUMN2) OR (COLUMN1 + 1) = COLUMN2)) THEN
            --DBMS_OUTPUT.PUT_LINE('Si es diagonal (quitar comentarios para eliminar)');

            DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND PIECES_CODE = targetData.CODE;
            UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;
            IF(ROW2=1)THEN
                DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;
                INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('ND'||SUBSTR(sourceData.CODE, 3,1), matchID, ROW2, NUMBERTOCOLUMN(COLUMN2), 0);
                DBMS_OUTPUT.PUT_LINE('El peon se ha convertido.');
            end if;
            RETURN TRUE;
        END IF;


        CHECKPOS := TargetPosition(UPPER(NUMBERTOCOLUMN(COLUMN1))||''||(ROW1-1), matchTurn, matchID, true);
        IF(CHECKPOS.EXIST = 0 AND COLUMN1 = COLUMN2 AND (ROW1 - 1 = ROW2 OR ((ROW1 = 7) AND ((ROW1 - 2 = ROW2)) OR (ROW1 - 1 = ROW2)))) then
            --DBMS_OUTPUT.PUT_LINE('Sí es movimiento normal (quitar comentarios para eliminar)');

            UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;
            IF(ROW2=1)THEN
                DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;
                INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('ND'||SUBSTR(sourceData.CODE, 3,1), matchID, ROW2, NUMBERTOCOLUMN(COLUMN2), 0);
                DBMS_OUTPUT.PUT_LINE('El peon se ha convertido.');
            end if;
            RETURN TRUE;
        END IF;
    END IF;

    RETURN FALSE;
END;
/