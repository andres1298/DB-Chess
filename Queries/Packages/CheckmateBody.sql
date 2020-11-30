-- =========================================
-- Author: Kamil Sauma
-- Create date: 30/11/2020
-- Description: Package with all logic related to checkmate.
-- Returns: boolean
-- =========================================


CREATE OR REPLACE PACKAGE BODY CHECKMATE IS

    -- VARIABLES
    tempCoordinates VARCHAR2(2) := '';
    loops NUMBER := 0;
    counter NUMBER := 0;
    counter2 NUMBER := 0;
    threats NUMBER := 0;
    EXIT_EXISTS BOOLEAN := FALSE;
    pieceData PIECE := PIECE();
    ROW1 NUMBER(1);
    COLUMN1 NUMBER(1);

    -- EXCEPTIONS
    PIECE_IN_BETWEEN EXCEPTION;

    --FUNCTIONS
    FUNCTION VerticalAsc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
        ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
        counter:=row1+1;
        EXIT_EXISTS:=false;
        threats:=0;
        loops:=0;

        WHILE 8>=counter AND NOT EXIT_EXISTS LOOP
            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(COLUMN1) || TO_CHAR(counter);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);

                IF(DEBUG) THEN
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.DISPLAY);
                DBMS_OUTPUT.PUT_LINE('color: ' || matchTurn);
                DBMS_OUTPUT.PUT_LINE('tempCoordinates: ' || tempCoordinates);
                end if;

                counter := counter + 1;


                EXIT_EXISTS:=pieceData.Exist=1;
                IF pieceData.Exist = 1 and pieceData.COLOR = matchTurn THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;

                IF(loops=0 AND UPPER(pieceData.DISPLAY) in ('R') ) THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                IF UPPER(pieceData.DISPLAY) in ('T', 'D') THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;
                loops:=loops+1;
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        EXIT;
            END;

        END LOOP;
        RETURN threats > 0;
    END;

    FUNCTION VerticalDesc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
        ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
        counter:=row1-1;
        EXIT_EXISTS:=false;
        threats:=0;
        loops:=0;

        WHILE counter>=0 AND NOT EXIT_EXISTS LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(COLUMN1) || TO_CHAR(counter);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);

                IF(DEBUG) THEN
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.DISPLAY);
                DBMS_OUTPUT.PUT_LINE('color: ' || matchTurn);
                DBMS_OUTPUT.PUT_LINE('tempCoordinates: ' || tempCoordinates);
                end if;

                counter := counter - 1;

                EXIT_EXISTS:=pieceData.Exist=1;
                IF pieceData.Exist = 1 and pieceData.COLOR = matchTurn THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;

                IF(loops=0 AND UPPER(pieceData.DISPLAY) in ('R') ) THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                IF UPPER(pieceData.DISPLAY) in ('T', 'D') THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                loops:=loops+1;

                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        EXIT;
            END;

        END LOOP;
        RETURN threats > 0;
    END;

   FUNCTION HorizontalAsc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
        ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
        counter:=COLUMN1+1;
        EXIT_EXISTS:=false;
        threats:=0;
        loops:=0;

        WHILE 8>=counter AND NOT EXIT_EXISTS LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(counter) || TO_CHAR(ROW1);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);

                IF(DEBUG) THEN
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.DISPLAY);
                DBMS_OUTPUT.PUT_LINE('color: ' || matchTurn);
                DBMS_OUTPUT.PUT_LINE('tempCoordinates: ' || tempCoordinates);
                end if;

                counter := counter + 1;

                EXIT_EXISTS:=pieceData.Exist=1;
                IF pieceData.Exist = 1 and pieceData.COLOR = matchTurn THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;

                IF(loops=0 AND UPPER(pieceData.DISPLAY) in ('R') ) THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                IF UPPER(pieceData.DISPLAY) in ('T', 'D') THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;
                loops:=loops+1;

                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        EXIT;
            END;

        END LOOP;
        RETURN threats > 0;
    END;

    FUNCTION HorizontalDesc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
        ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
        counter:=COLUMN1-1;
        EXIT_EXISTS:=false;
        threats:=0;
        loops:=0;

        WHILE counter>=0 AND NOT EXIT_EXISTS LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(counter) || TO_CHAR(ROW1);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);

                IF(DEBUG) THEN
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.DISPLAY);
                DBMS_OUTPUT.PUT_LINE('color: ' || matchTurn);
                DBMS_OUTPUT.PUT_LINE('tempCoordinates: ' || tempCoordinates);
                end if;

                counter := counter - 1;

                EXIT_EXISTS:=pieceData.Exist=1;
                IF pieceData.Exist = 1 and pieceData.COLOR = matchTurn THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;

                IF(loops=0 AND UPPER(pieceData.DISPLAY) in ('R') ) THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                IF UPPER(pieceData.DISPLAY) in ('T', 'D') THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                loops:=loops+1;
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        EXIT;
            END;

        END LOOP;
        RETURN threats > 0;
    END;

    FUNCTION RightDiagonalAsc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
        ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
        counter:=COLUMN1+1;
        counter2:=ROW1+1;
        EXIT_EXISTS:=false;
        threats:=0;
        loops:=0;

        WHILE 8>=counter AND 8>=counter2 AND NOT EXIT_EXISTS LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(counter) || TO_CHAR(counter2);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);

                IF(DEBUG) THEN
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.DISPLAY);
                DBMS_OUTPUT.PUT_LINE('color: ' || matchTurn);
                DBMS_OUTPUT.PUT_LINE('tempCoordinates: ' || tempCoordinates);
                end if;

                counter := counter + 1;
                counter2 := counter2 + 1;

                EXIT_EXISTS:=pieceData.Exist=1;
                IF pieceData.Exist = 1 and pieceData.COLOR = matchTurn THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;

                IF(loops=0 AND (UPPER(pieceData.DISPLAY) in ('R') OR (matchTurn = 1 AND UPPER(pieceData.DISPLAY) = 'P'))) THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                IF UPPER(pieceData.DISPLAY) in ('A', 'D') THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                loops:=loops+1;

                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        EXIT;
            END;

        END LOOP;
        RETURN threats > 0;
    END;

    FUNCTION RightDiagonalDesc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
        ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
        counter:=COLUMN1+1;
        counter2:=ROW1-1;
        EXIT_EXISTS:=false;
        threats:=0;
        loops:=0;

        WHILE 8>=counter AND counter2>=0 AND NOT EXIT_EXISTS LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(counter) || TO_CHAR(counter2);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);

                IF(DEBUG) THEN
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.DISPLAY);
                DBMS_OUTPUT.PUT_LINE('color: ' || matchTurn);
                DBMS_OUTPUT.PUT_LINE('tempCoordinates: ' || tempCoordinates);
                end if;

                counter := counter + 1;
                counter2 := counter2 - 1;

                EXIT_EXISTS:=pieceData.Exist=1;
                IF pieceData.Exist = 1 and pieceData.COLOR = matchTurn THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;

                IF(loops=0 AND (UPPER(pieceData.DISPLAY) in ('R') OR (matchTurn = 0 AND UPPER(pieceData.DISPLAY) = 'P')) ) THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                IF UPPER(pieceData.DISPLAY) in ('A', 'D') THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;


                loops:=loops+1;
                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        EXIT;
            END;

        END LOOP;
        RETURN threats > 0;
    END;

    FUNCTION LeftDiagonalAsc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
        ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
        counter:=COLUMN1-1;
        counter2:=ROW1+1;
        EXIT_EXISTS:=false;
        threats:=0;
        loops:=0;

        WHILE counter>=0 AND 8>=counter2 AND NOT EXIT_EXISTS LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(counter) || TO_CHAR(counter2);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);

                IF(DEBUG) THEN
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.DISPLAY);
                DBMS_OUTPUT.PUT_LINE('color: ' || matchTurn);
                DBMS_OUTPUT.PUT_LINE('tempCoordinates: ' || tempCoordinates);
                end if;

                counter := counter - 1;
                counter2 := counter2 + 1;

                EXIT_EXISTS:=pieceData.Exist=1;
                IF pieceData.Exist = 1 and pieceData.COLOR = matchTurn THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;

                IF(loops=0 AND (UPPER(pieceData.DISPLAY) in ('R') OR (matchTurn = 1 AND UPPER(pieceData.DISPLAY) = 'P')) ) THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                IF UPPER(pieceData.DISPLAY) in ('A', 'D') THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                loops:=loops+1;

                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        EXIT;
            END;

        END LOOP;
        RETURN threats > 0;
    END;

    FUNCTION LeftDiagonalDesc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
        ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));
        counter:=COLUMN1-1;
        counter2:=ROW1-1;
        EXIT_EXISTS:=false;
        threats:=0;
        loops:=0;

        WHILE counter>=0 AND counter2>=0 AND NOT EXIT_EXISTS LOOP

            BEGIN
                tempCoordinates := NUMBERTOCOLUMN(counter) || TO_CHAR(counter2);
                pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);

                IF(DEBUG) THEN
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.DISPLAY);
                DBMS_OUTPUT.PUT_LINE('color: ' || matchTurn);
                DBMS_OUTPUT.PUT_LINE('tempCoordinates: ' || tempCoordinates);
                end if;

                counter := counter - 1;
                counter2 := counter2 - 1;

                EXIT_EXISTS:=pieceData.Exist=1;
                IF pieceData.Exist = 1 and pieceData.COLOR = matchTurn THEN
                    RAISE PIECE_IN_BETWEEN;
                END IF;

                IF(loops=0 AND (UPPER(pieceData.DISPLAY) in ('R') OR (matchTurn = 0 AND UPPER(pieceData.DISPLAY) = 'P')) ) THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                IF UPPER(pieceData.DISPLAY) in ('A', 'D') THEN
                    if(threats>0) then
                        exit;
                    end if;
                    threats := threats+1;
                end if;

                loops:=loops+1;

                EXCEPTION
                    WHEN PIECE_IN_BETWEEN THEN
                        EXIT;
            END;

        END LOOP;
        RETURN threats > 0;
    END;


    FUNCTION Knight (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        COLUMN1 := COLUMNTONUMBER(LOWER(SUBSTR(source, 1, 1)));
        ROW1 := TO_NUMBER(SUBSTR(source, 2, 2));

        IF(KnightCheck(ROW1+1, COLUMN1+2, matchId, matchTurn) OR
           KnightCheck(ROW1-1, COLUMN1+2, matchId, matchTurn) OR
           KnightCheck(ROW1+1, COLUMN1-2, matchId, matchTurn) OR
           KnightCheck(ROW1-1, COLUMN1-2, matchId, matchTurn) OR
           KnightCheck(ROW1+2, COLUMN1-1, matchId, matchTurn) OR
           KnightCheck(ROW1+2, COLUMN1+1, matchId, matchTurn) OR
           KnightCheck(ROW1-2, COLUMN1-1, matchId, matchTurn) OR
           KnightCheck(ROW1-2, COLUMN1+1, matchId, matchTurn)) THEN
            RETURN TRUE;
            else
            return FALSE;
        end if;
    END;


    FUNCTION KnightCheck (x number, y number, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN
            IF(x <= 0 OR x >= 9 OR y <= 0 OR y >= 9) THEN
                return false;
            end if;
            tempCoordinates := NUMBERTOCOLUMN(y) || x;
            pieceData := TargetPosition(tempCoordinates, matchTurn, matchId);

                IF(DEBUG) THEN
                DBMS_OUTPUT.PUT_LINE('Existe: ' || pieceData.DISPLAY);
                DBMS_OUTPUT.PUT_LINE('color: ' || matchTurn);
                DBMS_OUTPUT.PUT_LINE('tempCoordinates: ' || tempCoordinates);
                end if;

             IF pieceData.Exist = 1 and pieceData.COLOR = matchTurn THEN
                    return FALSE;
             END IF;

            IF(UPPER(pieceData.DISPLAY) in ('C') ) THEN
                   return TRUE;
            end if;
        RETURN FALSE;
    END;

    FUNCTION CM (matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN
    IS
    BEGIN

        IF(matchTurn = 0) then
            select "ROW", COLUMNTONUMBER("COLUMN") into ROW1, COLUMN1 from PIECES_PER_MATCH where MATCHES_ID = matchId and PIECES_CODE = 'NR';
        else
            select "ROW", COLUMNTONUMBER("COLUMN") into ROW1, COLUMN1 from PIECES_PER_MATCH where MATCHES_ID = matchId and PIECES_CODE = 'BR';
        end if;


        IF(VERTICALASC((NUMBERTOCOLUMN(COLUMN1)||ROW1), matchId, matchTurn, DEBUG) OR
           VERTICALDESC((NUMBERTOCOLUMN(COLUMN1)||ROW1), matchId, matchTurn, DEBUG) OR
           HORIZONTALASC((NUMBERTOCOLUMN(COLUMN1)||ROW1), matchId, matchTurn, DEBUG) OR
           HORIZONTALDESC((NUMBERTOCOLUMN(COLUMN1)||ROW1), matchId, matchTurn, DEBUG) OR
           RIGHTDIAGONALASC((NUMBERTOCOLUMN(COLUMN1)||ROW1), matchId, matchTurn, DEBUG) OR
           RIGHTDIAGONALDESC((NUMBERTOCOLUMN(COLUMN1)||ROW1), matchId, matchTurn, DEBUG) OR
           LEFTDIAGONALASC((NUMBERTOCOLUMN(COLUMN1)||ROW1), matchId, matchTurn, DEBUG) OR
           LEFTDIAGONALDESC((NUMBERTOCOLUMN(COLUMN1)||ROW1), matchId, matchTurn, DEBUG) OR
           Knight((NUMBERTOCOLUMN(COLUMN1)||ROW1), matchId, matchTurn, DEBUG)) THEN
            RETURN TRUE;
            ELSE
            RETURN FALSE;
        end if;
    END;

END CHECKMATE;
/