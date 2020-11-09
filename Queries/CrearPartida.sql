DECLARE
    idJugador1 NUMBER := 4;
    idJugador2 NUMBER := 5;
    i1 NUMBER  := 0;
    i2 NUMBER  := 0;
    matchId NUMBER := 0;
BEGIN


    --Se podría hacer un trigger o algo distinto
    SELECT PLAYED_MATCHES INTO i1 FROM PLAYERS where ID = idJugador1;
    SELECT PLAYED_MATCHES INTO i2 FROM PLAYERS where ID = idJugador2;
    UPDATE PLAYERS set PLAYED_MATCHES = i1+1 where ID = idJugador1;
    UPDATE PLAYERS set PLAYED_MATCHES = i2+1 where ID = idJugador2;



    INSERT INTO MATCHES (ID, START_DATE, TURN, PLAYERS_ID1, PLAYERS_ID2, STATUS) VALUES
    (MATCHES_ID_SEQ.nextval, CURRENT_DATE, TO_CHAR(FLOOR(DBMS_RANDOM.VALUE(0,2))), idJugador1, idJugador2, 'P');
    matchId := MATCHES_ID_SEQ.currval;

    /*
    Piezas Negras
    */
    --Torres
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NT1', matchId, 8, 'a', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NT2', matchId, 8, 'h', '0');
    --Caballos
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NC1', matchId, 8, 'b', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NC2', matchId, 8, 'g', '0');
    --Alfiles
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NA1', matchId, 8, 'c', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NA2', matchId, 8, 'f', '0');
    --Rey
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NR', matchId, 8, 'd', '0');
    --Dama
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('ND', matchId, 8, 'e', '0');
    --Peones
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NP8', matchId, 7, 'a', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NP7', matchId, 7, 'b', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NP6', matchId, 7, 'c', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NP5', matchId, 7, 'd', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NP4', matchId, 7, 'e', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NP3', matchId, 7, 'f', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NP2', matchId, 7, 'g', '0');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NP1', matchId, 7, 'h', '0');


    /*
    Piezas Blancas
    */
    --Torres
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BT1', matchId, 1, 'a', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BT2', matchId, 1, 'h', '1');
    --Caballos
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BC1', matchId, 1, 'b', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BC2', matchId, 1, 'g', '1');
    --Alfiles
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BA1', matchId, 1, 'c', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BA2', matchId, 1, 'f', '1');
    --Rey
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BR', matchId, 1, 'd', '1');
    --Dama
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BD', matchId, 1, 'e', '1');
    --Peones
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BP8', matchId, 2, 'a', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BP7', matchId, 2, 'b', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BP6', matchId, 2, 'c', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BP5', matchId, 2, 'd', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BP4', matchId, 2, 'e', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BP3', matchId, 2, 'f', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BP2', matchId, 2, 'g', '1');
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BP1', matchId, 2, 'h', '1');

    DBMS_OUTPUT.PUT_LINE('Fin');
END;
/