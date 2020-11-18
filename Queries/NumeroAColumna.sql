-- =========================================
-- Author: Kamil Sauma
-- Create date: 17/11/2020
-- Description: Function that receives a number and converts it to a column
-- Parameters:
-- 		@numero: number
-- Returns: char
-- =========================================

CREATE OR REPLACE FUNCTION 
NUMBERTOCOLUMN (numero number) RETURN CHAR
IS
	columna char;
BEGIN

    if(numero = 1) then
        columna:='a';
    elsif(numero = 2) then
        columna:='b';
    elsif(numero = 3) then
        columna:='c';
    elsif(numero = 4) then
        columna:='d';
    elsif(numero = 5) then
        columna:='e';
    elsif(numero = 6) then
        columna:='f';
    elsif(numero = 7) then
        columna:='g';
    elsif(numero = 8) then
        columna:='h';
    end if;

    return columna;
END;
/