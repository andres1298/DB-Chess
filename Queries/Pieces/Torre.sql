-- =========================================
-- Author: Andrés Bonilla
-- Create date: 21/11/2020
-- Description: Function that determines whether a rook movement is valid.
-- Returns: boolean
-- =========================================

-- CREATE OR REPLACE FUNCTION
-- CHECKPEON (source VARCHAR2, target VARCHAR2, targetData VARCHAR2, matchTurn MATCHES.TURN%TYPE, matchID NUMBER) RETURN BOOLEAN
-- IS
DECLARE
    source VARCHAR2(2) := 'A1';
    target VARCHAR2(3) := 'A5';
    matchId NUMBER(2) := 5;
    matchTurn NUMBER(1) := 1;
    sourceRow NUMBER(1);
    targetRow NUMBER(1);
    sourceColumn NUMBER(1);
    targetColumn NUMBER(1);
    flag BOOLEAN := FALSE;
    counter NUMBER(1) := 0;
    pieceData PIECE;

    tempCoordinates VARCHAR2(2);
    -- EXCEPTIONS
    PIECE_IN_BETWEEN EXCEPTION;
BEGIN
    pieceData := PIECE();
    sourceColumn := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
    targetColumn := COLUMNTONUMBER(LOWER(SUBSTR(target, 1, 1)));
    sourceRow := TO_NUMBER(SUBSTR(source, 2, 2));
    targetRow := TO_NUMBER(SUBSTR(target, 2, 2));

    IF sourceColumn <> targetColumn AND sourceRow <> targetRow THEN
        DBMS_OUTPUT.PUT_LINE('El movimiento de la torre no es lineal.');
        flag := TRUE;
    
    ELSIF sourceColumn = targetColumn AND sourceRow < targetRow THEN -- Movimiento vertical ascendente
        COUNTER := sourceRow + 1;
        WHILE COUNTER < targetRow AND NOT flag LOOP
        
            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(targetColumn) || TO_CHAR(COUNTER);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                COUNTER := COUNTER + 1;

                IF pieceData.EMPTY <> 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        flag := TRUE;
                        CONTINUE;
            END;

        END LOOP;

    ELSIF sourceColumn = targetColumn AND sourceRow > targetRow THEN -- Movimiento vertical descendente
        COUNTER := sourceRow - 1;
        WHILE COUNTER > targetRow AND NOT flag LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(targetColumn) || TO_CHAR(COUNTER);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                COUNTER := COUNTER - 1;

                IF pieceData.EMPTY <> 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        flag := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;
    
    ELSIF sourceColumn < targetColumn AND sourceRow = targetRow THEN -- Movimiento horizontal ascendente
        COUNTER := sourceColumn + 1;
        WHILE COUNTER < targetColumn AND NOT flag LOOP
        
            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(COUNTER) || TO_CHAR(targetRow);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                COUNTER := COUNTER + 1;

                IF pieceData.EMPTY <> 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        flag := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;

    ELSIF sourceColumn > targetColumn AND sourceRow = targetRow THEN -- Movimiento horizontal descendente
        COUNTER := sourceColumn - 1;
        WHILE COUNTER > targetColumn AND NOT flag LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(COUNTER) || TO_CHAR(targetRow);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                COUNTER := COUNTER - 1;

                IF pieceData.EMPTY <> 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        flag := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;
    END IF;

    IF flag THEN
            DBMS_OUTPUT.PUT_LINE('Movimiento invalido. Hay una pieza en la coordenada' || tempCoordinates);
        ELSE
            pieceData := TargetPosition(target, matchTurn, matchId);
            IF pieceData.EMPTY <> 1 THEN
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