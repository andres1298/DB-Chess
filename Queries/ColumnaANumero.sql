-- =========================================
-- Author: Kamil Sauma
-- Create date: 17/11/2020
-- Description: Function that receives a column and converts it to a number
-- Parameters:
-- 		@columna: char
-- Returns: number
-- =========================================

CREATE OR REPLACE FUNCTION 
COLUMNTONUMBER (columna char) RETURN NUMBER
IS
	numberColumn NUMBER;
BEGIN

    if(columna = 'a') then
        numberColumn:=1;
    elsif(columna = 'b') then
        numberColumn:=2;
    elsif(columna = 'c') then
        numberColumn:=3;
    elsif(columna = 'd') then
        numberColumn:=4;
    elsif(columna = 'e') then
        numberColumn:=5;
    elsif(columna = 'f') then
        numberColumn:=6;
    elsif(columna = 'g') then
        numberColumn:=7;
    elsif(columna = 'h') then
        numberColumn:=8;
    end if;

    return numberColumn;
END;
/