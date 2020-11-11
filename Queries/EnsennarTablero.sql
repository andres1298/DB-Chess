DECLARE
    idJuego NUMBER := 1;
    contenido VARCHAR2(300) := '';
    letra char;
    piecesCode VARCHAR2(3);
    pieceDisplay  VARCHAR2(3);
BEGIN


    DBMS_OUTPUT.PUT_LINE(LPAD('a', 6) || LPAD('b', 6) || LPAD('c', 6) || LPAD('d', 6) || LPAD('e', 6) || LPAD('f', 6) || LPAD('g', 6) || LPAD('h', 6));

    for i in 1..8 loop
        contenido:=i||' |';
        for h in 1..8 loop

            if(h = 1) then
                letra:='a';
            elsif(h = 2) then
                letra:='b';
            elsif(h = 3) then
                letra:='c';
            elsif(h = 4) then
                letra:='d';
            elsif(h = 5) then
                letra:='e';
            elsif(h = 6) then
                letra:='f';
            elsif(h = 7) then
                letra:='g';
            elsif(h = 8) then
                letra:='h';
            end if;



            BEGIN
            SELECT pieces_code into piecesCode FROM PIECES_PER_MATCH WHERE matches_id = idJuego AND "ROW"=i AND "COLUMN" = letra;
            EXCEPTION
                when NO_DATA_FOUND then

                    contenido := contenido || '___|' ;

                CONTINUE;
            END;


            if(piecesCode is not null) then
                SELECT DISPLAY into pieceDisplay from PIECES where code = piecesCode;
                contenido := contenido || '  ' || pieceDisplay || ' |';
            else
                contenido := contenido || '___|';
            end if;

        end loop;

        DBMS_OUTPUT.PUT_LINE(contenido);

    end loop;

    DBMS_OUTPUT.PUT_LINE('Fin');
END;
/