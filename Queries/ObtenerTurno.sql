CREATE OR REPLACE FUNCTION GetTurn (matchID NUMBER) RETURN CHAR
IS
matchTurn MATCHES.TURN%TYPE;
BEGIN
	SELECT TURN into matchTurn
	FROM MATCHES
	WHERE ID = matchID;
	
	RETURN matchTurn;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('El ID de partida ingresado no fue encontrado en el sistema. Por favor intente de nuevo');
			RETURN NULL;
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Error al obtener la partida. Por favor intente de nuevo');
			RETURN NULL;
END;
/