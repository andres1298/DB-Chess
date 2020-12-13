-- =========================================
-- Author: Kamil Sauma
-- Create date: 29/11/2020
-- Edit date: 13/12/2020
-- Edited by: Andrés Bonilla
-- Description: Function that determines whether a king movement is valid.
-- Returns: boolean
-- =========================================

CREATE OR REPLACE FUNCTION
REY (source VARCHAR2, target VARCHAR2, sourceData PIECE, targetData PIECE, matchTurn MATCHES.TURN%TYPE, matchID NUMBER) RETURN BOOLEAN
IS
    ROW1 NUMBER(1);
    ROW2 NUMBER(1);
    COLUMN1 NUMBER(1);
    COLUMN2 NUMBER(1);
    invalidFlag BOOLEAN := FALSE;

    -- Enroque
    castlinTower PIECE;
    whiteLeftTowerPosition CONSTANT VARCHAR2(2) := 'A1';
    whiteRightTowerPosition CONSTANT VARCHAR2(2) := 'H1';
    blackLeftTowerPosition CONSTANT VARCHAR2(2) := 'A8';
    blackRightTowerPosition CONSTANT VARCHAR2(2) := 'H8';
    towerDestinationColumn VARCHAR2(1);
BEGIN

    COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
    COLUMN2 := COLUMNTONUMBER(LOWER(SUBSTR(target, 1, 1)));
    ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
    ROW2 := TO_NUMBER(SUBSTR(target, 2, 2));

    --DBMS_OUTPUT.PUT_LINE('T display: ' || targetData.DISPLAY || ' T exists: ' || targetData.EXIST);
    --DBMS_OUTPUT.PUT_LINE(row1 || ', ' || NUMBERTOCOLUMN(column1));
    --DBMS_OUTPUT.PUT_LINE(row2 || ', ' || NUMBERTOCOLUMN(column2));
        IF((ROW1+1 = ROW2 AND COLUMN1-1 = COLUMN2) OR
           (ROW1+1 = ROW2 AND COLUMN1 = COLUMN2) OR
           (ROW1+1 = ROW2 AND COLUMN1+1 = COLUMN2) OR
           (ROW1 = ROW2 AND COLUMN1-1 = COLUMN2) OR
           (ROW1 = ROW2 AND COLUMN1+1 = COLUMN2) OR
           (ROW1-1 = ROW2 AND COLUMN1-1 = COLUMN2) OR
           (ROW1-1 = ROW2 AND COLUMN1 = COLUMN2) OR
           (ROW1-1 = ROW2 AND COLUMN1+1 = COLUMN2)) then
            --DBMS_OUTPUT.PUT_LINE('Sí es movimiento valido (quitar comentarios para eliminar)');

            --DBMS_OUTPUT.PUT_LINE(sourceData.CODE);


            IF(targetData.EXIST = 1) then
                DELETE FROM PIECES_PER_MATCH WHERE MATCHES_ID = matchID AND PIECES_CODE = targetData.CODE;
            end if;
            UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;

            RETURN TRUE;

        ELSE
            castlinTower := PIECE();
            IF(COLUMN1 = 5 AND (ROW1 = 1 OR ROW1 = 8)) THEN
                -- Validar enroque largo
                IF ((ROW1 = ROW2) AND (COLUMN1 - 2 = COLUMN2)) THEN
                    -- Validar enroque de blancas
                    IF(matchTurn = 1) THEN
                        castlinTower := TargetPosition(whiteLeftTowerPosition, matchTurn, matchID);

                        -- Se valida si la pieza existe y si concuerda con el color del turno
                        IF (castlinTower.EXIST = 1 AND castlinTower.CODE = 'BT1') THEN
                            invalidFlag := MOV.HorizontalDescending(COLUMN1, ROW2, 1, matchID, matchTurn);
                        END IF;

                    -- Varlidar enroque de negras
                    ELSE
                        castlinTower := TargetPosition(blackLeftTowerPosition, matchTurn, matchID);
                        -- Se valida si la pieza existe y si concuerda con el color del turno
                        IF (castlinTower.EXIST = 1 AND castlinTower.CODE = 'NT1') THEN
                            invalidFlag := MOV.HorizontalDescending(COLUMN1, ROW2, 1, matchID, matchTurn);
                        END IF;
                    END IF;
                    towerDestinationColumn := 'd';

                -- Validar enroque corto
                ELSIF ((ROW1 = ROW2) AND (COLUMN1 + 2 = COLUMN2)) THEN
                    -- Validar enroque de blancas
                    IF(matchTurn = 1) THEN
                        castlinTower := TargetPosition(whiteRightTowerPosition, matchTurn, matchID);

                        -- Se valida si la pieza existe y si concuerda con el color del turno
                        IF (castlinTower.EXIST = 1 AND castlinTower.CODE = 'BT2') THEN
                            invalidFlag := MOV.HorizontalAscending(COLUMN1, ROW2, 8, matchID, matchTurn);
                        END IF;

                    -- Varlidar enroque de negras
                    ELSE
                        castlinTower := TargetPosition(blackRightTowerPosition, matchTurn, matchID);
                        -- Se valida si la pieza existe y si concuerda con el color del turno
                        IF (castlinTower.EXIST = 1 AND castlinTower.CODE = 'NT2') THEN
                            invalidFlag := MOV.HorizontalAscending(COLUMN1, ROW2, 8, matchID, matchTurn);
                        END IF;
                    END IF;
                    towerDestinationColumn := 'f';
                ELSE 
                    RETURN FALSE;
                END IF;
            ELSE 
                RETURN FALSE;
            END IF;
            
            IF invalidFlag THEN
                RETURN FALSE;
            ELSE
                UPDATE PIECES_PER_MATCH SET "COLUMN" = NUMBERTOCOLUMN(COLUMN2), "ROW" = ROW2 where MATCHES_ID = matchID AND PIECES_CODE = sourceData.CODE;
                UPDATE PIECES_PER_MATCH SET "COLUMN" = towerDestinationColumn, "ROW" = ROW2 where MATCHES_ID = matchID AND PIECES_CODE = castlinTower.CODE;
                COMMIT;
                RETURN TRUE;
            END IF;
        
        END IF;

    RETURN FALSE;
END;
/