-- Generated by Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   at:        2020-11-01 11:45:47 CST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE matches (
    id            NUMBER NOT NULL,
    start_date    DATE NOT NULL, default sysdate,
    end_date      DATE NOT NULL,
    turn          CHAR(1) NOT NULL,
    id_white      NUMBER NOT NULL,
    id_black      NUMBER NOT NULL,
    winner_color  CHAR(1) NOT NULL,
    winner_id     NUMBER NOT NULL,
    status        CHAR(1) NOT NULL
);

ALTER TABLE matches ADD CONSTRAINT matches_pk PRIMARY KEY ( id );

CREATE TABLE pieces (
    code                       VARCHAR2(3) NOT NULL,
    name                       VARCHAR2(200) 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    color                      CHAR(1) NOT NULL,
    pieces_per_match_id_match  NUMBER NOT NULL
);

ALTER TABLE pieces ADD CONSTRAINT pieces_pk PRIMARY KEY ( code );

CREATE TABLE pieces_per_match (
    id_piece  VARCHAR2(3) NOT NULL,
    id_match  NUMBER NOT NULL,
    "ROW"     NUMBER NOT NULL,
    "COLUMN"  CHAR(1) NOT NULL,
    color     CHAR(1) NOT NULL
);

ALTER TABLE pieces_per_match ADD CONSTRAINT pieces_per_match_pk PRIMARY KEY ( id_match,
                                                                              id_piece );

CREATE TABLE players (
    id              NUMBER NOT NULL,
    name            VARCHAR2(200) 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    username        VARCHAR2(200) 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    played_matches  NUMBER NOT NULL,
    won_matches     NUMBER NOT NULL,
    tied_matches    NUMBER NOT NULL,
    lost_matches    NUMBER NOT NULL
);

ALTER TABLE players ADD CONSTRAINT players_pk PRIMARY KEY ( id );

ALTER TABLE matches
    ADD CONSTRAINT black_player_relation FOREIGN KEY ( id_black )
        REFERENCES players ( id );

ALTER TABLE pieces_per_match
    ADD CONSTRAINT match_relation FOREIGN KEY ( id_match )
        REFERENCES matches ( id );

ALTER TABLE pieces_per_match
    ADD CONSTRAINT pieces_on_match FOREIGN KEY ( id_piece )
        REFERENCES pieces ( code );

ALTER TABLE matches
    ADD CONSTRAINT white_player_relation FOREIGN KEY ( id_white )
        REFERENCES players ( id );

ALTER TABLE matches
    ADD CONSTRAINT winner_player_relation FOREIGN KEY ( winner_id )
        REFERENCES players ( id );

CREATE SEQUENCE matches_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER matches_id_trg BEFORE
    INSERT ON matches
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := matches_id_seq.nextval;
END;
/

CREATE SEQUENCE players_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER players_id_trg BEFORE
    INSERT ON players
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := players_id_seq.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              9
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          2
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   3
-- WARNINGS                                 0
