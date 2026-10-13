-- ═══════════════════════════════════════
-- Source: 00_sys.sql
-- ═══════════════════════════════════════
PROMPT Creating user DOG_MANAGER...

----------------------------------
-- 1. Create user, add grants   --
----------------------------------
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM dba_users t WHERE t.username='DOG_MANAGER';
  IF v_count = 1 THEN 
    EXECUTE IMMEDIATE 'DROP USER dog_manager CASCADE';
  END IF;
END;
/
CREATE USER dog_manager 
  IDENTIFIED BY "12345678" 
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
;

GRANT CREATE SESSION TO dog_manager;
GRANT CREATE TABLE TO dog_manager;
GRANT CREATE VIEW TO dog_manager;
GRANT CREATE SEQUENCE TO dog_manager;
GRANT CREATE PROCEDURE TO dog_manager;

PROMPT Done.

-- ═══════════════════════════════════════
-- Source: 001_sys.sql
-- ═══════════════════════════════════════
----------------------------------
-- 1. Create user, add grants   --
----------------------------------
DECLARE
  l_cnt NUMBER;
BEGIN
  SELECT COUNT(*) INTO l_cnt FROM dba_users t WHERE t.username='DOG_MANAGER';
  IF l_cnt=1 THEN 
    EXECUTE IMMEDIATE 'DROP USER dog_manager CASCADE';
  END IF;
END;
/
CREATE USER dog_manager 
  IDENTIFIED BY 12345678
  DEFAULT TABLESPACE USERS
  QUOTA UNLIMITED ON users;

GRANT CREATE SESSION TO dog_manager;
GRANT CREATE TABLE TO dog_manager;
GRANT CREATE VIEW TO dog_manager;
GRANT CREATE SEQUENCE TO dog_manager;
GRANT CREATE PROCEDURE TO dog_manager;

-- ═══════════════════════════════════════
-- Source: 01_dog_manager.sql
-- ═══════════════════════════════════════
PROMPT Creating table PERSON...

CREATE TABLE person(
  person_id         NUMBER         NOT NULL PRIMARY KEY
 ,first_name        VARCHAR2(40)   NOT NULL
 ,last_name         VARCHAR2(40)   NOT NULL
 ,birth_date        DATE
 ,birth_place_city  VARCHAR2(100)
 ,loc_country_code  VARCHAR2(2)
 ,loc_city          VARCHAR2(100)
 ,loc_address       VARCHAR2(100)
 ,email             VARCHAR2(100)
 ,tel               VARCHAR2(20)
 ,last_modified     DATE           DEFAULT SYSDATE NOT NULL
 ,created           DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;

PROMPT Done.

PROMPT Creating tables...

CREATE TABLE dog(
  dog_id                          NUMBER         NOT NULL PRIMARY KEY
 ,breed_code                      CHAR(3)
 ,dog_name                        VARCHAR2(40)   NOT NULL
 ,father_id                       NUMBER
 ,mother_id                       NUMBER
 ,registration_number             VARCHAR2(40)
 ,birth_date                      DATE NOT NULL 
 ,birth_weight                    NUMBER(5,2)
 ,owner_id                        NUMBER
 ,last_modified                   DATE           DEFAULT SYSDATE NOT NULL
 ,created                         DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;

CREATE TABLE vacc(
  vacc_id                         NUMBER         NOT NULL PRIMARY KEY
 ,dog_id                          NUMBER         NOT NULL
 ,doctor_id                       NUMBER         NOT NULL
 ,type_of_vacc                    VARCHAR2(40)   NOT NULL
 ,date_of_vacc                    DATE           DEFAULT SYSDATE NOT NULL
 ,location_of_vacc                VARCHAR2(100)
 ,created                         DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;

PROMPT Done.

PROMPT Loading tables...
ALTER SESSION SET CURRENT_SCHEMA=dog_manager;

prompt Loading PERSON...
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (10, 'László', 'Tóth', to_date('23-10-1956', 'dd-mm-yyyy'), 'Karakószörcsök', 'HU', 'Veszprém', 'Vasút u. 21.', 'laszlo.toth@tot.hu', '0678123456', to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (2, 'István', 'Kovács', to_date('19-12-1991', 'dd-mm-yyyy'), 'Budapest XXII.', 'HU', 'Pécs', 'Gül Baba tér 19.', 'istvan.kovacs91@ggmmaaiill.com', '06317654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (3, 'Nóra', 'Szabó-Eszterházy', to_date('10-01-2009', 'dd-mm-yyyy'), 'Pécs', 'EN', 'Brighton', null, 'norika2009@enternet.hu', '+4477987654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (5, 'John', 'Smith', to_date('07-07-1967', 'dd-mm-yyyy'), 'Mencseszter sziti', 'HU', 'Mohács', 'Béke tér 1.', 'johny@smith.eu', '06307777777', to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'));

prompt Loading DOG...
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (3, 'PUL', 'Kócos', null, 3, 'tehgb255gre5', to_date('10-10-2010', 'dd-mm-yyyy'), 1, 2, to_date('21-09-2016 15:13:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:13:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (5, 'PUL', 'Bleky', null, 3, 'fdfvksf425kn543', to_date('25-01-2015', 'dd-mm-yyyy'), .99, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (7, 'PUL', 'Jimmy', null, 3, 'fdfvksf425kn544', to_date('25-01-2015', 'dd-mm-yyyy'), 1.03, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (9, 'PUL', 'Jane', null, 3, 'fdfvksf425kn545', to_date('25-01-2015', 'dd-mm-yyyy'), 1.11, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (11, 'GRT', 'Harap', null, 11, 'asd1234', to_date('12-01-2012', 'dd-mm-yyyy'), null, 10, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (13, 'GRT', 'Frici', null, 11, 'z123', to_date('20-02-2161', 'dd-mm-yyyy'), null, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (14, 'GRT', 'Frakk', null, 11, 'z12345', to_date('20-02-2161', 'dd-mm-yyyy'), null, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (15, 'GRT', 'Poci', null, 11, 'z124', to_date('20-02-2161', 'dd-mm-yyyy'), null, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (17, 'GRT', 'Pici', null, 11, 'z125987', to_date('20-02-2161', 'dd-mm-yyyy'), null, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (18, 'PUL', 'Janet', null, 3, 'fdfvksf425kn545', to_date('25-01-2015', 'dd-mm-yyyy'), 1.11, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));


prompt Loading VACC...
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (1, 3, 5, 'A01', to_date('20-01-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (2, 3, 5, 'B01', to_date('20-08-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (3, 7, 10, 'A01', to_date('11-01-2010', 'dd-mm-yyyy'), 'Budapest', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (4, 11, 10, 'B01', to_date('09-09-2009', 'dd-mm-yyyy'), 'Veszprém', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (5, 13, 10, 'C01', to_date('29-02-2012', 'dd-mm-yyyy'), 'Mohács', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (6, 14, 10, 'C01', to_date('29-02-2012', 'dd-mm-yyyy'), 'Mohács', to_date('21-09-2016 15:28:14', 'dd-mm-yyyy hh24:mi:ss'));

prompt Done.

ALTER TABLE vacc
  RENAME COLUMN type_of_vacc TO vacc_type_id;

-- / #13 / -------------------------------------------------------------
-- Létrehozzuk az oltástípusok tábláját
------------------------------------------------------------------------
CREATE TABLE vacc_type
(
  vacc_type_id VARCHAR2(40) NOT NULL,
  vacc_name    VARCHAR2(200)
);

COMMENT ON TABLE vacc_type IS 'Oltások típusai';
COMMENT ON COLUMN vacc_type.vacc_type_id IS 'Oltás típuskódja';
COMMENT ON COLUMN vacc_type.vacc_name IS 'Oltás megnevezése';

-- PL/SQL Developerben húzzuk az egeret a tábla begépelt neve fölé
-- és jobb kattintással válasszuk ki a "Describe" menûpontot.
-- Itt meg tudjuk nézni egy tábla szerkezetét és a kommenteket.


-- / #14 / -------------------------------------------------------------
-- Létrehozunk egy elsõdleges kulcsot
ALTER TABLE vacc_type
  ADD CONSTRAINT vacc_type_pk PRIMARY KEY (vacc_type_id);


-- / #15 / -------------------------------------------------------------
-- Majd az egyedi értékekkel feltöltjük a táblát a meglévõ oltásokból
INSERT INTO vacc_type
(
  vacc_type_id
)
SELECT DISTINCT t.vacc_type_id
FROM   vacc t;

PROMPT Loading tables...

UPDATE vacc_type t
SET    t.vacc_name = 'Veszettség elleni oltás'
WHERE  t.vacc_type_id = 'A01';

UPDATE vacc_type t
SET    t.vacc_name = 'Lyme-kór elleni oltás'
WHERE  t.vacc_type_id = 'B01';

UPDATE vacc_type t
SET    t.vacc_name = 'Kombinált oltás'
WHERE  t.vacc_type_id = 'C01';

UPDATE vacc_type t
SET    t.vacc_name = 'Parovírus elleni oltás'
WHERE  t.vacc_type_id = 'D01';


PROMPT Done.

ALTER TABLE vacc
  ADD CONSTRAINT vacc_type_fk FOREIGN KEY (vacc_type_id) REFERENCES vacc_type(vacc_type_id);

CREATE OR REPLACE VIEW vw_dog_vacc AS
SELECT d.dog_id
      ,d.dog_name
      ,d.registration_number      
      ,v.date_of_vacc
      ,vt.vacc_name
      ,'Dr.' || p.first_name || ' ' || p.last_name AS doctor_name
FROM   dog d
       JOIN vacc v
         ON d.dog_id = v.dog_id
       JOIN vacc_type vt
         ON v.vacc_type_id = vt.vacc_type_id
       JOIN person p
         ON v.doctor_id = p.person_id
WHERE  v.date_of_vacc >= DATE '2016-01-01'
ORDER BY d.dog_id, v.date_of_vacc
;

CREATE OR REPLACE VIEW vw_dogs_with_owners AS
 SELECT p.first_name
      ,p.last_name
      ,d.dog_name
      ,COUNT(*) over(PARTITION BY p.person_id) AS dog_cnt_by_person
      ,row_number() over(PARTITION BY p.person_id ORDER BY d.dog_name DESC) AS dog_rn_by_name_desc
--      ,COUNT(*) over(PARTITION BY p.person_id ORDER BY d.dog_name DESC range between unbounded preceding and unbounded following) as cnt_with_order
  FROM person p
  JOIN dog d
    ON p.person_id = d.owner_id;


CREATE OR REPLACE FUNCTION get_prev_date(p_n NUMBER DEFAULT 1) RETURN DATE IS
BEGIN
  RETURN SYSDATE - p_n;
END;
/

-- ═══════════════════════════════════════
-- Source: 002_dog_manager.sql
-- ═══════════════════════════════════════
----------------------------------
-- 2. Create tables             --
----------------------------------
--ALTER SESSION SET CURRENT_SCHEMA=dog_manager;

CREATE TABLE person(
       ID NUMBER PRIMARY KEY,
       first_name VARCHAR2(40) NOT NULL,
       last_name VARCHAR2(40) NOT NULL,
       birth_date DATE,
       birth_place_city VARCHAR2(100),
       loc_country_code VARCHAR2(2),
       loc_city VARCHAR2(100),
       loc_address VARCHAR2(100),
       email VARCHAR2(100),
       tel VARCHAR2(20),
       last_modified DATE DEFAULT SYSDATE NOT NULL,
       created DATE DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;

CREATE TABLE dog(
       ID NUMBER PRIMARY KEY,
       breed_code CHAR(3), 
       dog_name VARCHAR2(40) NOT NULL,
       father_id NUMBER,
       mother_id NUMBER,
       registration_number VARCHAR2(40),
       birth_date DATE NOT NULL, 
       birth_weight NUMBER(5,2),
       owner_id NUMBER,
       last_modified DATE DEFAULT SYSDATE NOT NULL,
       created DATE DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;

alter table dog
  add constraint dog_owner_fk FOREIGN key (owner_id) REFERENCES person(id);
alter table dog
  add constraint dog_mother_fk FOREIGN key (mother_id) REFERENCES dog(id);
alter table dog
  add constraint dog_father_fk FOREIGN key (father_id) REFERENCES dog(id);

-- ═══════════════════════════════════════
-- Source: 02_view.sql
-- ═══════════════════════════════════════
--------------------------------------------------------------------------------
-- Oracle adatbázis a gyakorlatban
-- 4. gyakorlat
-- Táblák, Nézetek, Indexek, Megszorítások készítése (FK, UK, CK...)
--------------------------------------------------------------------------------

-- / #01 / -------------------------------------------------------------
-- Hozzuk létre a PERSON táblát a 01_dog_manager.sql -el.
------------------------------------------------------------------------


-- / #02 / -------------------------------------------------------------
-- Az elsõdleges kulcshoz az indexet automatikusan létrehozza az Oracle,
-- úgy mint UNIQUE INDEX.
-- Nézzük meg, hogy milyen indexek kapcsolódnak a táblához!
-- Az adatszótárból le tudjuk kérdezni a felhasználói indexeket,
-- a USER_INDEXES nézet segítségével:
------------------------------------------------------------------------

SELECT *
FROM   user_indexes;

------------------------------------------------------------------------
-- Látható, hogy az index (és a megszorítás) neve véletlenszerû lett.
-- Fontos, hogy a kulcsokhoz kapcsolódó indexeket névvel tudjuk
-- azonosítani. Kesõbb, amikor majd elemezni kell egy SQL futtatását így
-- könnyeben fel fogjuk ismerni, hogy mihez tartozik a kulcsban használt
-- index, illetve erre a hintek írásakor is szükség lehet.
------------------------------------------------------------------------


-- / #03 / -------------------------------------------------------------
-- Hozzuk létre külön az elsõdleges kulcsot!
-- De elõbb eldobjuk a táblát.
-- PURGE: a tábla nem kerül be a Recycled Bin-be,
--        hanem visszanonhatatlanul töröljük.
------------------------------------------------------------------------

DROP TABLE person PURGE;

-- / #04 / -------------------------------------------------------------
-- Létrehozzuk a táblát elsõdleges kulcs nélkül.
-- Töröljük a korábbi definícióból a PRIMARY KEY kulcsszavakat,
-- majd hozzuk létre újra a táblát!
------------------------------------------------------------------------

CREATE TABLE person(
  person_id         NUMBER         NOT NULL
 ,first_name        VARCHAR2(40)   NOT NULL
 ,last_name         VARCHAR2(40)   NOT NULL
 ,birth_date        DATE
 ,birth_place_city  VARCHAR2(100)
 ,loc_country_code  VARCHAR2(2)
 ,loc_city          VARCHAR2(100)
 ,loc_address       VARCHAR2(100)
 ,email             VARCHAR2(100)
 ,tel               VARCHAR2(20)
 ,last_modified     DATE           DEFAULT SYSDATE NOT NULL
 ,created           DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;


-- / #05 / -------------------------------------------------------------
-- Adjuk hozzá az elsõdleges kulcsot.
------------------------------------------------------------------------

ALTER TABLE person
  ADD CONSTRAINT person_pk PRIMARY KEY (person_id);
  
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (10, 'László', 'Tóth', to_date('23-10-1956', 'dd-mm-yyyy'), 'Karakószörcsök', 'HU', 'Veszprém', 'Vasút u. 21.', 'laszlo.toth@tot.hu', '0678123456', to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (2, 'István', 'Kovács', to_date('19-12-1991', 'dd-mm-yyyy'), 'Budapest XXII.', 'HU', 'Pécs', 'Gül Baba tér 19.', 'istvan.kovacs91@ggmmaaiill.com', '06317654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (3, 'Nóra', 'Szabó-Eszterházy', to_date('10-01-2009', 'dd-mm-yyyy'), 'Pécs', 'EN', 'Brighton', null, 'norika2009@enternet.hu', '+4477987654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (5, 'John', 'Smith', to_date('07-07-1967', 'dd-mm-yyyy'), 'Mencseszter sziti', 'HU', 'Mohács', 'Béke tér 1.', 'johny@smith.eu', '06307777777', to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'));


-- / #06 / -------------------------------------------------------------
-- Nézzük meg, hogy most milyen indexek kapcsolódnak a táblához
------------------------------------------------------------------------

SELECT *
FROM   user_indexes;

--
-- Az index neve a kulcs nevét követi. PERSON_PK lett.
--


-- / #07 / -------------------------------------------------------------
-- Itt sem volt megadva a PRIMARY KEY neve.
-- Nem szükséges újra létrehozni a táblát, eldohatjuk a megszorítást is.
-- Dobjuk a MEGSZORÍTÁSOKAT és újra hozzuk létre õket névvel.
--   1, DOG  táblában a DOG_ID-ra, DOG_PK néven.
--   2, VACC táblában a VACC_ID-ra, VACC_PK_néven.
------------------------------------------------------------------------

SELECT *
FROM   user_indexes;

-- 1,
ALTER TABLE dog
  DROP CONSTRAINT SYS_C007064; -- lekérdezésbõl

ALTER TABLE dog
  ADD CONSTRAINT dog_pk PRIMARY KEY (dog_id);

-- 2,
ALTER TABLE vacc
  DROP CONSTRAINT SYS_C007057; -- lekérdezésbõl

ALTER TABLE vacc
  ADD CONSTRAINT vacc_pk PRIMARY KEY (vacc_id);


-- / #08 / -------------------------------------------------------------
-- Definiáljuk a táblák közötti kapcsolatokat
--   1, VACC.DOG_ID -> DOG
--   2, VACC.DOCTOR_ID -> person
--   3, DOG.OWNER_ID -> person

-- 1, VACC.DOG_ID -> DOG
ALTER TABLE vacc
  ADD CONSTRAINT vacc_dog_fk FOREIGN KEY (dog_id) REFERENCES dog(dog_id);

-- 2, VACC.DOCTOR_ID -> person
ALTER TABLE vacc
  ADD CONSTRAINT vacc_doctor_fk FOREIGN KEY (doctor_id) REFERENCES person(person_id);

-- 3, DOG.OWNER_ID -> person
ALTER TABLE dog
  ADD CONSTRAINT dog_owner_fk FOREIGN KEY (owner_id) REFERENCES person(person_id);


-- / #09 / -------------------------------------------------------------
-- Hozzunk lére megoszorításokat a kutyák regisztrációs számára!
--   1, a csak egyedi lehet (UNIQE)
--   2, a hossza legalább 5 karakter (LENGTH függvény)
------------------------------------------------------------------------

-- 1,
ALTER TABLE dog
  ADD CONSTRAINT dog_reg_no_uk UNIQUE (registration_number);

-- 2,
ALTER TABLE dog
  ADD CONSTRAINT dog_reg_no_ck CHECK (LENGTH(registration_number) >= 5);


-- / #10 / -----------------------------------------------------------
-- Legyünk elnézõek a hosszt illetõen.
-- A megoszorítások inaktíválhatóak MODIFY CONSTRAINT paranccsal.
------------------------------------------------------------------------
ALTER TABLE dog
  MODIFY CONSTRAINT dog_reg_no_ck DISABLE;


------------------------------------------------------------------------
--
-- II. Bevezetünk egy szótártáblát az oltásokra
--
------------------------------------------------------------------------


-- / #12 / -------------------------------------------------------------
-- Átnevezzük az oltás típusát tároló oszlopot,
-- hogy szerepljen benne az "id".
------------------------------------------------------------------------

ALTER TABLE vacc
  RENAME COLUMN type_of_vacc TO vacc_type_id;

-- / #13 / -------------------------------------------------------------
-- Létrehozzuk az oltástípusok tábláját
------------------------------------------------------------------------
CREATE TABLE vacc_type
(
  vacc_type_id VARCHAR2(40) NOT NULL,
  vacc_name    VARCHAR2(200)
) TABLESPACE users;

COMMENT ON TABLE vacc_type IS 'Oltások típusai';
COMMENT ON COLUMN vacc_type.vacc_type_id IS 'Oltás típuskódja';
COMMENT ON COLUMN vacc_type.vacc_name IS 'Oltás megnevezése';

-- / #14 / -------------------------------------------------------------
-- Létrehozunk egy elsõdleges kulcsot
ALTER TABLE vacc_type
  ADD CONSTRAINT vacc_type_pk PRIMARY KEY (vacc_type_id);


-- / #15 / -------------------------------------------------------------
-- Majd az egyedi értékekkel feltöltjük a táblát a meglévõ oltásokból
INSERT INTO vacc_type
(
  vacc_type_id
)
SELECT DISTINCT vacc_type_id
FROM   vacc;

COMMIT;

SELECT * FROM vacc_type t ORDER BY t.vacc_type_id;


-- / #16 / -------------------------------------------------------------
-- Töltsük fel az oltástípusok mellé a nevüket.
-- Futtassuk le a 03_dog_manager_update.sql -t
-- COMMIT-ról ne feledkezzünk el!
------------------------------------------------------------------------

SELECT * FROM vacc_type t ORDER BY t.vacc_type_id;


-- / #17 / -------------------------------------------------------------
-- Az oltások táblján elhelyezük egy hivatkozást az oltások típusára
-- Ezt követõen nem lehet olyan oltást rögzíteni, amelynek korábban
-- nem rögzítettük volna a típusát.
ALTER TABLE vacc
  ADD CONSTRAINT vacc_type_fk FOREIGN KEY (vacc_type_id) REFERENCES vacc_type(vacc_type_id);


-- / #18 / -------------------------------------------------------------
-- Hozzunk létre egy nézetet, ami tartalmazza a kutya
--   * azonosítóját, nevét és regisztációs számát
--   * mikor volt oltva az adott kutya
--   * és mi az oltás neve
------------------------------------------------------------------------

CREATE VIEW vw_dog_vacc AS
SELECT d.dog_id
      ,d.dog_name
      ,d.registration_number      
      ,v.date_of_vacc
      ,vt.vacc_name
FROM   dog d
       JOIN vacc v
         ON d.dog_id = v.dog_id
       JOIN vacc_type vt
         ON v.vacc_type_id = vt.vacc_type_id
ORDER BY d.dog_id, v.date_of_vacc
;

SELECT * FROM vw_dog_vacc;



-- / #18 / -------------------------------------------------------------
-- Adjuk hozzá a nézethez az orvos nevét
-- Továbbá csak a 2015. utáni oltásokat listázzuk.
--
-- ORA-00955: name is already used by an existing object
-- Kell az "OR REPLACE", hogy le tudjuk cseréni a nézetet
--
CREATE OR REPLACE VIEW vw_dog_vacc AS
SELECT d.dog_id
      ,d.dog_name
      ,d.registration_number      
      ,v.date_of_vacc
      ,vt.vacc_name
      ,'Dr.' || p.first_name || ' ' || p.last_name AS doctor_name
FROM   dog d
       JOIN vacc v
         ON d.dog_id = v.dog_id
       JOIN vacc_type vt
         ON v.vacc_type_id = vt.vacc_type_id
       JOIN person p
         ON v.doctor_id = p.person_id
WHERE  v.date_of_vacc >= DATE '2016-01-01'
ORDER BY d.dog_id, v.date_of_vacc
;

-- / #19 / -------------------------------------------------------------
-- Hozzunk létre indexeket kereséshez a DOG táblában.
-- Indexelt mezők: dog_name, birth_date

CREATE INDEX dog_ix_01 ON dog(dog_name, birth_date);
CREATE INDEX dog_ix_02 ON dog(birth_date);
CREATE INDEX dog_ix_03 ON dog(dog_name);

-- A 3. indexre valójában nincs szükség, mert az Oracle képes az első
-- index "felvezető" mezőit használni.
-- Gyakorat képpen ezért dobjuk ezt az indexet:
DROP INDEX dog_ix_03;

-- ═══════════════════════════════════════
-- Source: 003_selects.sql
-- ═══════════════════════════════════════
SELECT * FROM dog;
SELECT * FROM person;

--RIGHT JOIN
SELECT * FROM dog d RIGHT JOIN person p ON d.owner_id = p.id;

--JOIN
SELECT * FROM person p JOIN dog d ON p.id = d.owner_id;

--CROSS JOIN
SELECT * FROM person p CROSS JOIN dog d;

--FULL JOIN
SELECT * FROM person p FULL JOIN dog d ON p.id = d.owner_id;

--Legnagyobb 'Z%' regisztrációsszámú kutya.
SELECT rownum
      ,t.*
  FROM (SELECT ROWID
              ,d.*
          FROM dog d
         WHERE upper(d.registration_number) LIKE 'Z%'
         ORDER BY d.registration_number DESC) t
 WHERE rownum = 1;
 
--Két évnél idősebb kutyák.
SELECT d.dog_name || ' (' || d.registration_number || ')'
      ,d.birth_date
  FROM dog d
 WHERE 1 = 1
   AND d.birth_date < add_months(SYSDATE, -24);


--'c' karaktert tartalmazó kutyák gazdái.
SELECT p.first_name
      ,p.last_name
      ,COUNT(*) AS dog_cnt
      ,listagg(d.dog_name, '; ') within GROUP(ORDER BY d.dog_name) AS dog_names
      ,SUM(CASE
             WHEN d.dog_name LIKE '%c%' THEN
              1
             ELSE
              0
           END)
  FROM person p
  JOIN dog d
    ON p.id = d.owner_id
 GROUP BY p.first_name
         ,p.last_name
HAVING SUM(CASE
  WHEN d.dog_name LIKE '%c%' THEN
   1
  ELSE
   0
END) > 0;

-- ═══════════════════════════════════════
-- Source: 003_vacc.sql
-- ═══════════════════════════════════════
CREATE TABLE vacc(
       id               NUMBER PRIMARY KEY,
       dog_id           NUMBER NOT NULL,
       doctor_id        NUMBER NOT NULL,
       type_of_vacc     VARCHAR2(40) NOT NULL,
       date_of_vacc     DATE DEFAULT SYSDATE,
       location_of_vacc VARCHAR2(100),
       created          DATE DEFAULT SYSDATE NOT NULL
);

COMMENT ON TABLE vacc IS 'Oltások';
COMMENT ON COLUMN vacc.dog_id IS 'Kutya azonosítója';

ALTER TABLE vacc ADD CONSTRAINT vacc1_fk
    FOREIGN KEY (dog_id) REFERENCES dog(id);
ALTER TABLE vacc ADD CONSTRAINT vacc2_fk
    FOREIGN KEY (doctor_id) REFERENCES person(id);

-- ═══════════════════════════════════════
-- Source: 03_dog_manager_update.sql
-- ═══════════════════════════════════════
UPDATE vacc_type t
SET    t.vacc_name = 'Veszettség elleni oltás'
WHERE  t.vacc_type_id = 'A01';

UPDATE vacc_type t
SET    t.vacc_name = 'Lyme-kór elleni oltás'
WHERE  t.vacc_type_id = 'B01';

UPDATE vacc_type t
SET    t.vacc_name = 'Kombinált oltás'
WHERE  t.vacc_type_id = 'C01';

UPDATE vacc_type t
SET    t.vacc_name = 'Parvovírus elleni oltás'
WHERE  t.vacc_type_id = 'D01';

SELECT * FROM vacc_type;

-- ═══════════════════════════════════════
-- Source: 004_dml_ddl_indulo.sql
-- ═══════════════════════════════════════
---------------------------------------------
--INSERT 1  alap insert mező érték megadással
---------------------------------------------
TRUNCATE TABLE vacc;

SELECT * FROM  vacc;

insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (1, 3, 5, 'A01', to_date('20-01-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (2, 3, 5, 'B01', to_date('20-08-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (3, 7, 10, 'A01', to_date('11-01-2010', 'dd-mm-yyyy'), 'Budapest', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (4, 11, 10, 'B01', to_date('09-09-2009', 'dd-mm-yyyy'), 'Veszprém', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (5, 13, 10, 'C01', to_date('29-02-2012', 'dd-mm-yyyy'), 'Mohács', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
  
SELECT * FROM vacc;
---------------------------------------
--INSERT 2  create table select alapján
---------------------------------------
create table vacc_bck as select * from vacc;

select * from vacc_bck;

drop table vacc_bck;
-------------------------------------------------------------------
--INSERT 3  tábla létrehozása minta alapján + insert select alapján
-------------------------------------------------------------------
create table vacc_bck as select * from vacc t where 1 = 2;

select * from vacc_bck;

INSERT INTO vacc_bck
  (id
  ,dog_id
  ,doctor_id
  ,type_of_vacc
  ,date_of_vacc
  ,location_of_vacc
  ,created)
  SELECT id
        ,dog_id
        ,doctor_id
        ,type_of_vacc
        ,date_of_vacc
        ,location_of_vacc
        ,created
    FROM vacc;

-------------------------------------------------------
--INSERT 4  több sor insertálása egyszerre értékadással
-------------------------------------------------------
TRUNCATE TABLE vacc;

SELECT * FROM  vacc;

insert ALL
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (1, 3, 5, 'A01', to_date('20-01-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (2, 3, 5, 'B01', to_date('20-08-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (3, 7, 10, 'A01', to_date('11-01-2010', 'dd-mm-yyyy'), 'Budapest', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (4, 11, 10, 'B01', to_date('09-09-2009', 'dd-mm-yyyy'), 'Veszprém', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (5, 13, 10, 'C01', to_date('29-02-2012', 'dd-mm-yyyy'), 'Mohács', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
SELECT * FROM dual;

SELECT * FROM vacc;

------------------------------
--INSERT 5 insert több táblába
------------------------------
CREATE TABLE VACC_PECS AS SELECT * FROM VACC WHERE 1 = 2;
CREATE TABLE VACC_BUDAPEST AS SELECT * FROM VACC WHERE 1 = 2;
CREATE TABLE VACC_VESZPREM AS SELECT * FROM VACC WHERE 1 = 2;
CREATE TABLE VACC_MASHOL AS SELECT * FROM VACC WHERE 1 = 2;

SELECT * FROM VACC_PECS;
SELECT * FROM VACC_BUDAPEST;
SELECT * FROM VACC_VESZPREM;
SELECT * FROM VACC_MASHOL;

INSERT FIRST
	 WHEN LOCATION_OF_VACC = 'Pécs'
	 THEN INTO VACC_PECS (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	   VALUES (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	 WHEN LOCATION_OF_VACC = 'Budapest'
	 THEN INTO VACC_BUDAPEST (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	   VALUES (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	 WHEN LOCATION_OF_VACC = 'Veszprém'
	 THEN INTO VACC_VESZPREM (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	   VALUES (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	 ELSE INTO VACC_MASHOL (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	   VALUES (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
SELECT * FROM VACC;
  
SELECT * FROM VACC_PECS;
SELECT * FROM VACC_BUDAPEST;
SELECT * FROM VACC_VESZPREM;
SELECT * FROM VACC_MASHOL;
SELECT * FROM VACC;

------------------------------------------------
--INSERT 6 insert több táblába FIRST
------------------------------------------------
CREATE TABLE VACC_BCK_A AS SELECT * FROM VACC WHERE 1 = 2;
CREATE TABLE VACC_BCK_B AS SELECT * FROM VACC WHERE 1 = 2;

SELECT * FROM VACC_BCK_A;
SELECT * FROM VACC_BCK_B;

SELECT SUBSTR(TYPE_OF_VACC, 1, 1), a.* FROM VACC a;

INSERT FIRST
	 WHEN SUBSTR(TYPE_OF_VACC, 1, 1) <= 'B'
	 THEN INTO VACC_BCK_B (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	   VALUES (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	 WHEN SUBSTR(TYPE_OF_VACC, 1, 1) <= 'A'
	 THEN INTO VACC_BCK_A (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	   VALUES (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
SELECT * FROM VACC;
  
SELECT * FROM VACC_BCK_A;
SELECT * FROM VACC_BCK_B;

SELECT SUBSTR(TYPE_OF_VACC, 1, 1), a.* FROM VACC a;

-----------------------------------------------
--INSERT 7 insert több táblába ALL értékadásokkal
-----------------------------------------------
DELETE VACC_BCK_A;
DELETE VACC_BCK_B;

INSERT ALL
	 WHEN SUBSTR(TYPE_OF_VACC, 1, 1) <= 'B'
	 THEN INTO VACC_BCK_B (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	   VALUES (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	 WHEN SUBSTR(TYPE_OF_VACC, 1, 1) <= 'A'
	 THEN INTO VACC_BCK_A (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
	   VALUES (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
SELECT * FROM VACC;

SELECT * FROM VACC_BCK_A;
SELECT * FROM VACC_BCK_B;

SELECT SUBSTR(TYPE_OF_VACC, 1, 1), a.* FROM VACC a;

---------------------------------------------------
--INSERT 8 insert több táblába ALL selectből
---------------------------------------------------
DELETE VACC_BCK_A;
DELETE VACC_BCK_B;

INSERT ALL
	 WHEN SUBSTR(TYPE_OF_VACC, 1, 1) <= 'B'
	 THEN INTO VACC_BCK_B
	 WHEN SUBSTR(TYPE_OF_VACC, 1, 1) <= 'A'
	 THEN INTO VACC_BCK_A
SELECT * FROM VACC a;

SELECT * FROM VACC_BCK_A;
SELECT * FROM VACC_BCK_B;

--------------------------------------
--INSERT 9 MERGE
--------------------------------------
create table vacc_bck AS SELECT * FROM vacc WHERE 1 = 2;
SELECT * FROM vacc;
SELECT * FROM vacc_bck;

INSERT INTO vacc_bck SELECT * FROM vacc;

DELETE FROM vacc WHERE ID = 5;

SELECT * FROM vacc;
SELECT * FROM vacc_bck;

-- merge
MERGE INTO vacc a
USING vacc_bck b
ON (a.id = b.id)
WHEN NOT MATCHED THEN
  INSERT
    (id
    ,dog_id
    ,doctor_id
    ,type_of_vacc
    ,date_of_vacc
    ,location_of_vacc
    ,created)
  VALUES
    (b.id
    ,b.dog_id
    ,b.doctor_id
    ,b.type_of_vacc
    ,b.date_of_vacc
    ,b.location_of_vacc
    ,b.created);

-------------------------------------
--UPDATE 1 alap
-------------------------------------
SELECT * FROM vacc;

-------------------------------------
--UPDATE 2 módosítás másik tábla alpján
-------------------------------------
UPDATE vacc a SET a.type_of_vacc = 
       (SELECT b.type_of_vacc FROM vacc_bck b WHERE a.id = b.id);

--merge into equivalent
MERGE INTO vacc v
USING vacc_bck vbck
ON (v.id = vbck.id)
WHEN MATCHED THEN
  UPDATE SET v.type_of_vacc = vbck.type_of_vacc || ' merge';

SELECT * FROM vacc;

-----------------------------------------------
--UPDATE 3  Mi történik? Mely sorok módosulnak?
-----------------------------------------------
ALTER TABLE vacc MODIFY (type_of_vacc NULL);

UPDATE vacc a SET a.type_of_vacc = 
       (SELECT b.type_of_vacc FROM vacc_bck b 
         WHERE a.id = b.id AND b.id < 4);

SELECT * FROM vacc;

-----------------------------------------------
--UPDATE 4  Mi történik? Mely sorok módosulnak?
-----------------------------------------------
UPDATE vacc a SET a.type_of_vacc = 
       (SELECT b.type_of_vacc FROM vacc_bck b WHERE a.id = b.id);

SELECT * FROM vacc;

UPDATE vacc a SET a.type_of_vacc = NULL WHERE ID < 4;
	   
SELECT * FROM vacc;

UPDATE vacc a SET a.type_of_vacc = 
       (SELECT b.type_of_vacc FROM vacc_bck b WHERE a.id = b.id)
WHERE EXISTS (SELECT 1 FROM vacc_bck b WHERE a.id = b.id AND b.id < 4);
	   
SELECT * FROM vacc;

UPDATE vacc a SET a.type_of_vacc = NULL WHERE ID < 4;
	   
SELECT * FROM vacc;

UPDATE vacc a SET a.type_of_vacc = 
(SELECT b.type_of_vacc FROM vacc_bck b WHERE a.id = b.id)
WHERE a.id < 4;

--merge into equivalent
--merge
	   
SELECT * FROM vacc;

-----------------------------------------------
--UPDATE 5 MERGE INTO
-----------------------------------------------
UPDATE vacc a SET a.type_of_vacc = NULL WHERE ID < 4;

SELECT * FROM vacc;

MERGE INTO vacc a
USING vacc_bck b
   ON (a.id = b.id)
WHEN MATCHED THEN 
  UPDATE SET type_of_vacc = b.type_of_vacc WHERE ID < 4;

SELECT * FROM vacc;
------------------------------
-- UPDATE 6 FOR UPDATE
------------------------------
SELECT * FROM vacc FOR UPDATE;

------------------------------
-- UPDATE 7 ROWID
------------------------------
SELECT ROWID, t.* FROM vacc t;

------------------------------
--DELETE 1 alap törlés
------------------------------
SELECT * FROM vacc;

DELETE FROM vacc WHERE ID = 5;

SELECT * FROM vacc;
------------------------------
--DELETE 2 alap tranzakció-kezeléssel
------------------------------
DELETE FROM vacc; 

INSERT INTO vacc SELECT * FROM vacc_bck;

SELECT * FROM vacc;
  
  DELETE FROM vacc;
  SELECT * FROM vacc;
  ROLLBACK;
  SELECT * FROM vacc;
  
  DELETE FROM vacc;
  SELECT * FROM vacc;
  COMMIT;
  SELECT * FROM vacc;

------------------------------
--DELETE 3 TRUNCATE
------------------------------
  
DELETE FROM vacc; 
INSERT INTO vacc SELECT * FROM vacc_bck; 

  SELECT * FROM vacc;
  TRUNCATE TABLE vacc;
  ROLLBACK;
  SELECT * FROM vacc;

-- ═══════════════════════════════════════
-- Source: 004_dog_manager_insert_data.sql
-- ═══════════════════════════════════════
prompt Loading PERSON...
insert into PERSON (ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (10, 'L�szl�', 'T�th', to_date('23-10-1956', 'dd-mm-yyyy'), 'Karak�sz�rcs�k', 'HU', 'Veszpr�m', 'Vas�t u. 21.', 'laszlo.toth@tot.hu', '0678123456', to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (2, 'Istv�n', 'Kov�cs', to_date('19-12-1991', 'dd-mm-yyyy'), 'Budapest XXII.', 'HU', 'P�cs', 'G�l Baba t�r 19.', 'istvan.kovacs91@ggmmaaiill.com', '06317654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (3, 'N�ra', 'Szab�-Eszterh�zy', to_date('10-01-2009', 'dd-mm-yyyy'), 'P�cs', 'EN', 'Brighton', null, 'norika2009@enternet.hu', '+4477987654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (5, 'John', 'Smith', to_date('07-07-1967', 'dd-mm-yyyy'), 'Mencseszter sziti', 'HU', 'Moh�cs', 'B�ke t�r 1.', 'johny@smith.eu', '06307777777', to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'));
prompt Loading DOG...
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (3, 'PUL', 'K�cos', null, 3, 'tehgb255gre5', to_date('10-10-2010', 'dd-mm-yyyy'), 1, 2, to_date('21-09-2016 15:13:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:13:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (5, 'PUL', 'Bleky', null, 3, 'fdfvksf425kn543', to_date('25-01-2015', 'dd-mm-yyyy'), .99, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (7, 'PUL', 'Jimmy', null, 3, 'fdfvksf425kn544', to_date('25-01-2015', 'dd-mm-yyyy'), 1.03, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (9, 'PUL', 'Jane', null, 3, 'fdfvksf425kn545', to_date('25-01-2015', 'dd-mm-yyyy'), 1.11, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (11, 'GRT', 'Harap', null, 11, 'asd1234', to_date('12-01-2012', 'dd-mm-yyyy'), null, 10, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (13, 'GRT', 'Frici', null, 11, 'z123', to_date('20-02-2161', 'dd-mm-yyyy'), null, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (15, 'GRT', 'Poci', null, 11, 'z124', to_date('20-02-2161', 'dd-mm-yyyy'), null, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (17, 'GRT', 'Pici', null, 11, 'z125', to_date('20-02-2161', 'dd-mm-yyyy'), null, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
prompt Loading VACC...
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (1, 3, 5, 'A01', to_date('20-01-2016', 'dd-mm-yyyy'), 'P�cs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (2, 3, 5, 'B01', to_date('20-08-2016', 'dd-mm-yyyy'), 'P�cs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (3, 7, 10, 'A01', to_date('11-01-2010', 'dd-mm-yyyy'), 'Budapest', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (4, 11, 10, 'B01', to_date('09-09-2009', 'dd-mm-yyyy'), 'Veszpr�m', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (5, 13, 10, 'C01', to_date('29-02-2012', 'dd-mm-yyyy'), 'Moh�cs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));

commit;

prompt Done.

-- ═══════════════════════════════════════
-- Source: 04_select_view.sql
-- ═══════════════════════════════════════
--------------------------------------------------------------------------------
-- PARTITION BY
-- Ugyanaz a logika mint a GROUP BY (közös jellemző alapján csoportosít) – de egy hatalmas különbséggel: nem olvasztja össze a sorokat egyetlen eredménysorrá!
-- Az over kulcsszó megmondja az adatbázisnak, hogy nem egy egyszerű számolást kell végezni, hanem egy analitikus (ablakozó) műveletet.
--------------------------------------------------------------------------------

CREATE VIEW vw_dogs_with_owners AS
 SELECT p.first_name
      ,p.last_name
      ,d.dog_name
      ,COUNT(*) over(PARTITION BY p.person_id) as count
      ,row_number() over(PARTITION BY p.person_id ORDER BY d.dog_name DESC) as rownumber
  FROM person p
  JOIN dog d
    ON p.person_id = d.owner_id;

-- ═══════════════════════════════════════
-- Source: 005_selects.sql
-- ═══════════════════════════════════════
SELECT * FROM DUAL;

SELECT 1 + 5 FROM dual;

SELECT SYSDATE
      ,trunc(SYSDATE)
      ,to_char(SYSDATE - 2, 'YYYY-MM-DD')
  FROM dual;
