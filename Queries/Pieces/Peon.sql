-- =========================================
-- Author: Kamil Sauma
-- Create date: 17/11/2020
-- Description: Function that determines whether a pawn movement is valid.
-- Returns: boolean
-- =========================================

CREATE OR REPLACE FUNCTION
CHECKPEON (source VARCHAR2, target VARCHAR2, targetData VARCHAR2, matchTurn MATCHES.TURN%TYPE, matchID NUMBER) RETURN BOOLEAN
IS
    ROW1 NUMBER(1);
    ROW2 NUMBER(1);
    COLUMN1 NUMBER(1);
    COLUMN2 NUMBER(1);
	CHECKPOS VARCHAR2(10);
BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
		COLUMN2 := COLUMNTONUMBER(LOWER(SUBSTR(target, 1, 1)));
		ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
		ROW2 := TO_NUMBER(SUBSTR(target, 2, 2));
		IF(matchTurn=1) then
        DBMS_OUTPUT.PUT_LINE('blanco');


            IF(targetData <> 'EMPTY'
                   AND ((ROW1+1)=ROW2)
                   AND ((COLUMN1 + 1) = COLUMN2) OR (COLUMN1 - 1) = COLUMN2) THEN
            DBMS_OUTPUT.PUT_LINE('Diagonal');

            DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND "COLUMN" = NUMBERTOCOLUMN(COLUMN2) AND "ROW" = ROW2;
            UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND "COLUMN" = NUMBERTOCOLUMN(COLUMN1) AND "ROW" = ROW1;
            RETURN TRUE;
            END IF;



        CHECKPOS := UPPER(NUMBERTOCOLUMN(COLUMN1))||''||(ROW1+1);
		CHECKPOS := TargetPosition(CHECKPOS, matchTurn, matchID);
            IF(CHECKPOS = 'EMPTY' AND COLUMN1 = COLUMN2 AND (ROW1 + 1 = ROW2 OR ((ROW1 = 2) AND ((ROW1 + 2 = ROW2) OR (ROW1 + 1 = ROW2))))) then
                UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND "COLUMN" = NUMBERTOCOLUMN(COLUMN1) AND "ROW" = ROW1;
                RETURN TRUE;
            END IF;
        ELSE


            IF(targetData <> 'EMPTY'
                   AND ((ROW1-1)=ROW2)
                   AND ((COLUMN1 - 1) = COLUMN2) OR (COLUMN1 + 1) = COLUMN2) THEN
            DBMS_OUTPUT.PUT_LINE('Diagonal');

            DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND "COLUMN" = NUMBERTOCOLUMN(COLUMN2) AND "ROW" = ROW2;
            UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND "COLUMN" = NUMBERTOCOLUMN(COLUMN1) AND "ROW" = ROW1;
            RETURN TRUE;
            END IF;


        CHECKPOS := UPPER(NUMBERTOCOLUMN(COLUMN1))||''||(ROW1-1);
		CHECKPOS := TargetPosition(CHECKPOS, matchTurn, matchID);
                DBMS_OUTPUT.PUT_LINE('negro');
            IF(CHECKPOS = 'EMPTY' AND COLUMN1 = COLUMN2 AND (ROW1 - 1 = ROW2 OR ((ROW1 = 7) AND ((ROW1 - 2 = ROW2)) OR (ROW1 - 1 = ROW2)))) then
                UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND "COLUMN" = NUMBERTOCOLUMN(COLUMN1) AND "ROW" = ROW1;
                RETURN TRUE;
            END IF;
        END IF;

        RETURN FALSE;
END;
/