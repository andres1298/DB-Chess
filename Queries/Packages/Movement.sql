CREATE OR REPLACE PACKAGE MOV IS
    FUNCTION VerticalAscending (targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION VerticalDescending (targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION HorizontalAscending (targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;
    FUNCTION HorizontalDescending (targetRow NUMBER, targetColumn NUMBER, matchId NUMBER, matchTurn NUMBER) RETURN BOOLEAN;

END MOV;
/