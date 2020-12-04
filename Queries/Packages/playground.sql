DECLARE
    checkmateBool boolean;
	matchID NUMBER := 21;
	matchTurn MATCHES.TURN%TYPE;
BEGIN
    matchTurn := GETTURN(matchID);
    DBMS_OUTPUT.PUT_LINE('Turno de: ' || matchTurn);
	--DBMS_OUTPUT.PUT_LINE(sys.diutil.bool_to_int(Mov.HorizontalAscending(4, 5, 8, 5, 0)));
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Vertical ASC');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool:= CHECKMATE.VERTICALASC('C6', matchID, matchTurn);
	DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));


    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Vertical DESC');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool:= CHECKMATE.VERTICALDESC('C6', matchID, matchTurn);
	DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));


    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Horizontal ASC');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool:= CHECKMATE.HORIZONTALASC('C6', matchID, matchTurn);
	DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));

    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Horizontal DESC');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool:= CHECKMATE.HORIZONTALDESC('C6', matchID, matchTurn);
	DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));


    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Diagonal Right Asc');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool:= CHECKMATE.RIGHTDIAGONALASC('C6', matchID, matchTurn);
	DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));


    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Diagonal Right Desc');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool:= CHECKMATE.RIGHTDIAGONALDESC('C6', matchID, matchTurn);
	DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));



    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Diagonal Left Asc');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool := CHECKMATE.LEFTDIAGONALASC('C6', matchID, matchTurn);
	DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));


    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Diagonal Left Desc');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool:= CHECKMATE.LEFTDIAGONALDESC('C6', matchID, matchTurn);
	DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));


    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Knight');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool:= CHECKMATE.Knight('C6', matchID, matchTurn);
    DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));


    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Resultado final: ');
    DBMS_OUTPUT.PUT_LINE(' ');
    checkmateBool:= CHECKMATE.CM(matchID, matchTurn);
	DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(checkmateBool));


END;
/
