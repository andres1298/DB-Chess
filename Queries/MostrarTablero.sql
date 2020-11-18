DECLARE
    idJuego NUMBER := 22;
    contenido VARCHAR2(500) := '';
    letra char;
    piecesCode VARCHAR2(3);
    pieceDisplay  VARCHAR2(3);
BEGIN

    DBMS_OUTPUT.PUT_LINE(rpad('.',3) || LPAD('a', 8) || LPAD('b', 8) || LPAD('c', 8) || LPAD('d', 8) || LPAD('e', 8) || LPAD('f', 8) || LPAD('g', 8) || LPAD('h', 8));

	-- Ciclo que imprime las filas del tablero
    for i in REVERSE 1..8 loop
		-- Se concatena la línea horizontal divisoria de las celdas
        contenido := rpad('.',6) || '-----------------------------------------------------------------' || chr(10);
		-- Se concatenan las barras horizontales en la primera línea de la casilla y un salto de línea
		contenido := contenido || rpad('.',6) || '|' || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || chr(10);
		-- Se concatena el número de fila del tablero (posición i del ciclo)
		contenido := contenido || rpad('.',4) || i || ' ';
		-- Ciclo que imprime las columnas del tablero
        for h in 1..8 loop

	        letra:= NUMBERTOCOLUMN(h);

            BEGIN
            SELECT pieces_code into piecesCode FROM PIECES_PER_MATCH WHERE matches_id = idJuego AND "ROW"=i AND "COLUMN" = letra;
            EXCEPTION
                when NO_DATA_FOUND then

                    contenido := contenido || rpad('|',8,' ');

                CONTINUE;
            END;


            if(piecesCode is not null) then
                SELECT DISPLAY into pieceDisplay from PIECES where code = piecesCode;
				contenido := contenido || rpad('|',4,' ');
				contenido := contenido || rpad(pieceDisplay,4,' ');
            end if;

        end loop;
		contenido := contenido || rpad('|',2,' ') ||  i || chr(10);
		contenido := contenido || rpad('.',6) || '|' || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8) || LPAD('|', 8);

        DBMS_OUTPUT.PUT_LINE(contenido);

    end loop;
	DBMS_OUTPUT.PUT_LINE(rpad('.',6) || '-----------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE(rpad('.',3) || LPAD('a', 8) || LPAD('b', 8) || LPAD('c', 8) || LPAD('d', 8) || LPAD('e', 8) || LPAD('f', 8) || LPAD('g', 8) || LPAD('h', 8));
END;
/