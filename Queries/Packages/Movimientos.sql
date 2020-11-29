CREATE OR REPLACE PACKAGE MOV IS
    FUNCTION VerticalAscending (sourceRow NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION VerticalDescending (sourceRow NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION HorizontalAscending (sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION HorizontalDescending (sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION RightDiagonalAscending (sourceRow NUMBER, sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION RightDiagonalDescending (sourceRow NUMBER, sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION LeftDiagonalAscending (sourceRow NUMBER, sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION LeftDiagonalDescending (sourceRow NUMBER, sourceColumn NUMBER, targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
END MOV;
/