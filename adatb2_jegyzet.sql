--1
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM dba_users t WHERE t.username = 'TERMEK';
  IF v_count = 1 THEN 
    EXECUTE IMMEDIATE 'DROP USER termek CASCADE';
  END IF;
END;
/

CREATE USER termek 
  IDENTIFIED BY simplePassword
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users;

GRANT CREATE SESSION TO termek;
GRANT CREATE TABLE TO termek;
GRANT CREATE VIEW TO termek;
GRANT CREATE SEQUENCE TO termek;
GRANT CREATE PROCEDURE TO termek;

ALTER SESSION SET CURRENT_SCHEMA = termek;


--2
CREATE TABLE kategoria(
   kategoria_id         NUMBER         NOT NULL
  ,megnevezes           VARCHAR2(100)  NOT NULL
  ,leiras               VARCHAR2(500)
  ,last_modified        DATE           DEFAULT SYSDATE NOT NULL
  ,created              DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;


CREATE TABLE termek(
   termek_id            NUMBER         NOT NULL
  ,nev                  VARCHAR2(100)  NOT NULL
  ,ar                   NUMBER(10,2)
  ,reg_datum            DATE           NOT NULL
  ,kategoria_id         NUMBER
  ,last_modified        DATE           DEFAULT SYSDATE NOT NULL
  ,created              DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;


--3
ALTER TABLE kategoria ADD CONSTRAINT kategoria_pk PRIMARY KEY (kategoria_id);
ALTER TABLE termek ADD CONSTRAINT termek_pk PRIMARY KEY (termek_id);

ALTER TABLE termek ADD CONSTRAINT termek_kategoria_fk 
  FOREIGN KEY (kategoria_id) REFERENCES kategoria(kategoria_id);

ALTER TABLE termek ADD CONSTRAINT termek_nev_uk UNIQUE (nev);

ALTER TABLE termek ADD CONSTRAINT termek_ar_ck CHECK (ar > 0);


--4
INSERT ALL
  INTO kategoria (kategoria_id, megnevezes, leiras) VALUES (1, 'Elektronika', 'Műszaki cikkek')
  INTO kategoria (kategoria_id, megnevezes, leiras) VALUES (2, 'Ruházat', 'Divat')
  INTO kategoria (kategoria_id, megnevezes, leiras) VALUES (3, 'Könyv', 'Irodalom')
  INTO kategoria (kategoria_id, megnevezes, leiras) VALUES (4, 'Sport', 'Sporteszközök')
  INTO kategoria (kategoria_id, megnevezes, leiras) VALUES (5, 'Játék', 'Játékok és hobbik')
SELECT * FROM dual;

INSERT ALL
  INTO termek (termek_id, nev, ar, reg_datum, kategoria_id) VALUES (1, 'Okostelefon', 150000, TO_DATE('10-01-2025', 'dd-mm-yyyy'), 1)
  INTO termek (termek_id, nev, ar, reg_datum, kategoria_id) VALUES (2, 'Kabát', 25000, TO_DATE('15-05-2024', 'dd-mm-yyyy'), 2)
  INTO termek (termek_id, nev, ar, reg_datum, kategoria_id) VALUES (3, 'Regény', 4500, TO_DATE('01-02-2026', 'dd-mm-yyyy'), 3)
  INTO termek (termek_id, nev, ar, reg_datum, kategoria_id) VALUES (4, 'Foci labda', 8000, TO_DATE('20-11-2023', 'dd-mm-yyyy'), 4)
  INTO termek (termek_id, nev, ar, reg_datum, kategoria_id) VALUES (5, 'Társasjáték', 12000, TO_DATE('05-12-2025', 'dd-mm-yyyy'), 5)
SELECT * FROM dual;

COMMIT;


--5
CREATE TABLE kategoria_masolat AS 
SELECT * FROM kategoria WHERE 1 = 2;

ALTER TABLE kategoria_masolat ADD CONSTRAINT kategoria_masolat_pk PRIMARY KEY (kategoria_id);

MERGE INTO kategoria_masolat dest
USING kategoria src
ON (dest.kategoria_id = src.kategoria_id)
WHEN NOT MATCHED THEN
  INSERT (kategoria_id, megnevezes, leiras, last_modified, created)
  VALUES (src.kategoria_id, src.megnevezes, src.leiras, src.last_modified, src.created);

COMMIT;


--6
CREATE TABLE regi_termek AS SELECT * FROM termek WHERE 1 = 2;
CREATE TABLE uj_termek AS SELECT * FROM termek WHERE 1 = 2;

INSERT ALL
  WHEN reg_datum < ADD_MONTHS(SYSDATE, -6) THEN
    INTO regi_termek
  ELSE
    INTO uj_termek
SELECT * FROM termek;

COMMIT;


--7
CREATE OR REPLACE VIEW vw_kategoria_statisztika AS
SELECT 
   k.kategoria_id
  ,k.megnevezes
  ,COUNT(t.termek_id) AS termek_db
  ,LISTAGG(t.nev, ' | ') WITHIN GROUP (ORDER BY t.nev) AS termekek_neve
FROM 
   kategoria k
JOIN 
   termek t ON k.kategoria_id = t.kategoria_id
GROUP BY 
   k.kategoria_id
  ,k.megnevezes;


--8
SELECT 
   k.kategoria_id
  ,k.megnevezes AS kategoria_nev
  ,k.leiras
  ,t.termek_id
  ,t.nev AS termek_nev
  ,t.ar
  ,t.reg_datum
FROM 
  kategoria k
LEFT JOIN 
  termek t ON k.kategoria_id = t.kategoria_id
WHERE 
  k.kategoria_id = (
    SELECT kategoria_id
    FROM (
      SELECT kategoria_id
      FROM kategoria
      WHERE UPPER(megnevezes) LIKE '%A%'
      ORDER BY megnevezes DESC
    )
    WHERE ROWNUM = 1
  );
