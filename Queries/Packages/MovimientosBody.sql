CREATE OR REPLACE PACKAGE BODY MOV IS

    -- VARIABLES
    tempCoordinates VARCHAR2(2) := '';
    counter NUMBER := 0;
    FLAG BOOLEAN := FALSE;
    pieceData PIECE := PIECE();

    -- EXCEPTIONS
    PIECE_IN_BETWEEN EXCEPTION;

    --FUNCTIONS
    FUNCTION VerticalAscending (sourceRow NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN
    IS
    BEGIN
        counter := sourceRow + 1;
        DBMS_OUTPUT.PUT_LINE('EMTRA ' || sourceRow || ' ' || targetRow || ' Counter: ' || counter);
        WHILE counter < targetRow AND NOT FLAG LOOP
        
            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(targetColumn) || TO_CHAR(counter);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.EXIST);
                counter := counter + 1;

                IF pieceData.Exist = 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        FLAG := TRUE;
                        CONTINUE;
            END;

        END LOOP;
        RETURN FLAG;
    END;

    FUNCTION VerticalDescending (sourceRow NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN
    IS
    BEGIN
        counter := sourceRow - 1;
        DBMS_OUTPUT.PUT_LINE('EMTRA ' || sourceRow || ' ' || targetRow || ' Counter: ' || counter);
        WHILE counter > targetRow AND NOT FLAG LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(targetColumn) || TO_CHAR(counter);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                counter := counter - 1;

                IF pieceData.Exist = 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        FLAG := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;
        RETURN FLAG;
    END;

    FUNCTION HorizontalAscending (sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN
    IS
    BEGIN
        counter := sourceColumn + 1;
        DBMS_OUTPUT.PUT_LINE('EMTRA ' || sourceColumn || ' ' || targetColumn || ' Counter: ' || counter);
        WHILE counter < targetColumn AND NOT FLAG LOOP
        
            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(counter) || TO_CHAR(targetRow);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                counter := counter + 1;
                IF pieceData.Exist = 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        FLAG := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(sys.diutil.bool_to_int(FLAG));
        RETURN FLAG;
    END;

    FUNCTION HorizontalDescending (sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN
    IS
    BEGIN
        counter := sourceColumn - 1;
        WHILE counter > targetColumn AND NOT FLAG LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(counter) || TO_CHAR(targetRow);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                counter := counter - 1;

                IF pieceData.Exist = 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        FLAG := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;
        RETURN FLAG;
    END;

    FUNCTION RightDiagonalAscending (sourceRow NUMBER, sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN
    IS
    BEGIN
    
        counter := 1;
        WHILE (sourceColumn + counter) < targetColumn AND NOT FLAG LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(sourceColumn + counter) || TO_CHAR(sourceRow + counter);
                DBMS_OUTPUT.PUT_LINE(tempCoordinates);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                counter := counter + 1;

                IF pieceData.Exist = 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        FLAG := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;
        RETURN FLAG;
    END;

    FUNCTION RightDiagonalDescending (sourceRow NUMBER, sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN
    IS
    BEGIN
    
        counter := 1;
        WHILE (sourceColumn + counter) < targetColumn AND NOT FLAG LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(sourceColumn + counter) || TO_CHAR(sourceRow - counter);
                DBMS_OUTPUT.PUT_LINE(tempCoordinates);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                counter := counter + 1;

                IF pieceData.Exist = 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        FLAG := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;
        RETURN FLAG;
    END;

    FUNCTION LeftDiagonalAscending (sourceRow NUMBER, sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN
    IS
    BEGIN
    
        counter := 1;
        WHILE (sourceColumn - counter) > targetColumn AND NOT FLAG LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(sourceColumn - counter) || TO_CHAR(sourceRow + counter);
                DBMS_OUTPUT.PUT_LINE(tempCoordinates);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                counter := counter + 1;

                IF pieceData.Exist = 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        FLAG := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;
        RETURN FLAG;
    END;

    FUNCTION LeftDiagonalDescending (sourceRow NUMBER, sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN
    IS
    BEGIN
    
        counter := 1;
        WHILE (sourceColumn - counter) > targetColumn AND NOT FLAG LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(sourceColumn - counter) || TO_CHAR(sourceRow - counter);
                DBMS_OUTPUT.PUT_LINE(tempCoordinates);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);
                counter := counter + 1;

                IF pieceData.Exist = 1 THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;
                
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        FLAG := TRUE;
                        CONTINUE;
            END;
            
        END LOOP;
        RETURN FLAG;
    END;
END MOV;
/