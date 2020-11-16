DECLARE
    idJugador1 NUMBER := 3;
    idJugador2 NUMBER := 4;
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
    (MATCHES_ID_SEQ.nextval, CURRENT_DATE, 1, idJugador1, idJugador2, 1);
    matchId := MATCHES_ID_SEQ.currval;

    /*
    Piezas Negras
    */
    --Torres
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NT1', matchId, 8, 'a', 0);
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('NT2', matchId, 8, 'h', 0);


    /*
    Piezas Blancas
    */
    --Torres
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BT1', matchId, 1, 'a', 1);
    INSERT INTO PIECES_PER_MATCH (PIECES_CODE, MATCHES_ID, "ROW", "COLUMN", COLOR) values ('BT2', matchId, 1, 'h', 1);
END;
/