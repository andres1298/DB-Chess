CREATE OR REPLACE PACKAGE CHECKMATE IS
    FUNCTION VerticalAsc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION VerticalDesc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION HorizontalAsc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION HorizontalDesc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION RightDiagonalAsc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION RightDiagonalDesc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION LeftDiagonalAsc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION LeftDiagonalDesc (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION Knight (source VARCHAR2, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION KnightCheck (x NUMBER, y NUMBER, matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
    FUNCTION CM(matchId NUMBER, matchTurn NUMBER, DEBUG boolean default FALSE) RETURN BOOLEAN;
END CHECKMATE;
/