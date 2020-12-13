CLEA SCREEN
SET SERVEROUTPUT ON

DECLARE
 txt varchar2(100):= 'Gracias por utilizar nuestra aplicacion';
BEGIN
  DBMS_OUTPUT.PUT_LINE(' ');
  DBMS_OUTPUT.PUT_LINE(txt);
  DBMS_OUTPUT.PUT_LINE('Fin del menu');
  
END;

/
exit