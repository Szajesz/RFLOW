BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMP1';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMP2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX1';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX3';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX4';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_TMP_TAJ';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_TMP_PRE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

--Alapok
create table RFLOW.RF_S248_E_201809_8_0_TMP1 as
SELECT distinct  
    x.TAJ
    ,(case
        when substr(BNOKOD,1,3) = 'J44' then 'J44'
    else
        'J45'
    end) BNO
    ,(case
        when hato.ATC in('R03DA04','R03AC02','R03AL01') then 'SABA'
        when hato.ATC = 'H02AB04' then 'metilprednizolon'
        when hato.ATC = 'R03DC03' then 'montelukaszt'
    else
        hato.TCS
    end) TCS     
    ,hato.ATC
    ,hato.HATOANYAG
    ,hato.BRAND
    ,(case
        when x.TTT in('210228725','210299734') then 100
        when x.TTT = '210724886' then 200
    else
        0
    end) BRAND_SAJAT
    ,x.DATUM
    ,(x.TAJ||to_char(x.DATUM,'YYYYMMDD')) eset
FROM
    RFLOW.RF_S248_VENY x
    inner join RFLOW.RF_S248_DEM dem on x.TAJ = dem.TAJ
    inner join RFLOW.RF_S248_TTT hato on x.TTT = hato.TTT
where
    x.TAJ <> '900000007'
    and (DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2017/12/31','yyyy/mm/dd'))
    and (upper(BNOKOD) between 'J4400' and 'J45XX')
;
    
insert into
    RFLOW.RF_S248_E_201809_8_0_TMP1
SELECT distinct 
    x.TAJO TAJ
    ,(case
        when substr(BNOKOD,1,3) = 'J44' then 'J44'
    else
        'J45'
    end) BNO
    ,(case
        when hato.ATC in('R03DA04','R03AC02','R03AL01') then 'SABA'
        when hato.ATC = 'H02AB04' then 'metilprednizolon'
        when hato.ATC = 'R03DC03' then 'montelukaszt'
    else
        hato.TCS
    end) TCS
    ,hato.ATC
    ,hato.HATOANYAG
    ,hato.BRAND
    ,(case
        when x.TTT in('210228725','210299734') then 100
        when x.TTT = '210724886' then 200
    else
        0
    end) BRAND_SAJAT
    ,x.DATUM
    ,(x.TAJO||to_char(x.DATUM,'YYYYMMDD')) eset
FROM
    RFLOW.RF_S40_VENY x
    inner join RFLOW.RF_S40_DEM dem on x.TAJO = dem.TAJ
    inner join RFLOW.RF_S248_TTT hato on x.TTT = hato.TTT
where
    x.TAJO <> '900000007'
    and (DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2017/12/31','yyyy/mm/dd'))
    and (upper(BNOKOD) between 'J4400' and 'J45XX')
;
commit;

-------------------------------------------------
insert into
    RFLOW.RF_S248_E_201809_8_0_TMP1
SELECT distinct  
    x.TAJ
    ,(case
        when substr(BNOKOD,1,3) = 'J44' then 'J44'
    else
        'J45'
    end) BNO
    ,(case
        when hato.ATC in('R03DA04','R03AC02','R03AL01') then 'SABA'
        when hato.ATC = 'H02AB04' then 'metilprednizolon'
        when hato.ATC = 'R03DC03' then 'montelukaszt'
    else
        hato.TCS
    end) TCS     
    ,hato.ATC
    ,hato.HATOANYAG
    ,hato.BRAND
    ,(case
        when x.TTT in('210228725','210299734') then 100
        when x.TTT = '210724886' then 200
    else
        0
    end) BRAND_SAJAT
    ,x.DATUM
    ,(x.TAJ||to_char(x.DATUM,'YYYYMMDD')) eset
FROM
    RFLOW.RF_S248_VENY_201809 x
    inner join RFLOW.RF_S248_DEM_201809 dem on x.TAJ = dem.TAJ
    inner join RFLOW.RF_S248_TTT hato on x.TTT = hato.TTT
where
    x.TAJ <> '900000007'
    and (DATUM between to_date('2018/01/01','yyyy/mm/dd') and to_date('2018/12/31','yyyy/mm/dd'))
    and (upper(BNOKOD) between 'J4400' and 'J45XX')
;
commit;
-------------------------------------------------
    
create index RF_S248_E_201809_8_0_TMP1_TAJ on RFLOW.RF_S248_E_201809_8_0_TMP1(TAJ);
create index RF_S248_E_201809_8_0_TMP1_BNO on RFLOW.RF_S248_E_201809_8_0_TMP1(BNO);
create index RF_S248_E_201809_8_0_TMP1_TCS on RFLOW.RF_S248_E_201809_8_0_TMP1(TCS);
create index RF_S248_E_201809_8_0_TMP1_B on RFLOW.RF_S248_E_201809_8_0_TMP1(BRAND);
create index RF_S248_E_201809_8_0_TMP1_S_B on RFLOW.RF_S248_E_201809_8_0_TMP1(BRAND_SAJAT);
create index RF_S248_E_201809_8_0_TMP1_DAT on RFLOW.RF_S248_E_201809_8_0_TMP1(DATUM);

--Uj beteg
create table RFLOW.RF_S248_E_201809_8_0_TMP2 as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.TCS
    ,alap.BRAND
    ,alap.BRAND_SAJAT
    ,(case when (ujbeteg.TAJ is NULL) then 1 else 0 end) uj_mind
    ,0 uj_Foster100
    ,0 uj_nemFoster100
    ,0 uj_Foster200
    ,0 uj_Symbicort
    ,0 uj_Bufomix
    ,count(distinct alap.eset) menny
from
    RFLOW.RF_S248_E_201809_8_0_TMP1 alap
    left outer join RFLOW.RF_S248_E_201809_8_0_TMP1 ujbeteg on
        alap.TAJ = ujbeteg.TAJ
        and alap.BRAND = ujbeteg.BRAND
        and alap.TCS = ujbeteg.TCS
        and alap.BNO = ujbeteg.BNO
        and (ujbeteg.datum between (alap.DATUM-180) and (alap.datum-1))
where
    (alap.TAJ <> '900000007')
    and (alap.DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2018/12/31','yyyy/mm/dd'))
group by
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.TCS
    ,alap.BRAND
    ,alap.BRAND_SAJAT
    ,(case when (ujbeteg.TAJ is NULL) then 1 else 0 end)
order by
    BNO
    ,TCS
    ,TAJ
    ,DATUM
    ,BRAND
;

create index RF_S248_E_201809_8_0_TMP2_TAJ on RFLOW.RF_S248_E_201809_8_0_TMP2(TAJ);
create index RF_S248_E_201809_8_0_TMP2_BNO on RFLOW.RF_S248_E_201809_8_0_TMP2(BNO);
create index RF_S248_E_201809_8_0_TMP2_TCS on RFLOW.RF_S248_E_201809_8_0_TMP2(TCS);
create index RF_S248_E_201809_8_0_TMP2_B on RFLOW.RF_S248_E_201809_8_0_TMP2(BRAND);
create index RF_S248_E_201809_8_0_TMP2_S_B on RFLOW.RF_S248_E_201809_8_0_TMP2(BRAND_SAJAT);
create index RF_S248_E_201809_8_0_TMP2_DAT on RFLOW.RF_S248_E_201809_8_0_TMP2(DATUM);

--uj_Foster100
create table RFLOW.RF_S248_E_201809_8_0_TMPX as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.TCS
    ,alap.BRAND_SAJAT
    ,(case when (uj_Foster100.TAJ is NULL) then 1 else 0 end) uj_Foster100
from
    RFLOW.RF_S248_E_201809_8_0_TMP1 alap
    left outer join RFLOW.RF_S248_E_201809_8_0_TMP1 uj_Foster100 on
        alap.TAJ = uj_Foster100.TAJ
        and alap.BRAND_SAJAT = uj_Foster100.BRAND_SAJAT
        and alap.TCS = uj_Foster100.TCS
        and alap.BNO = uj_Foster100.BNO
        and (uj_Foster100.datum between (alap.DATUM-180) and (alap.datum-1))
where
    (alap.DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2018/12/31','yyyy/mm/dd'))
    and (alap.BRAND_SAJAT = 100)
;

create index RF_S248_E_201809_8_0_TMPX on RFLOW.RF_S248_E_201809_8_0_TMPX(TAJ,TCS,BNO,DATUM,BRAND_SAJAT);

merge into
    RFLOW.RF_S248_E_201809_8_0_TMP2 alap
using
    (select * from RFLOW.RF_S248_E_201809_8_0_TMPX) tmp on (alap.TAJ = tmp.TAJ and alap.TCS = tmp.TCS and alap.BNO = tmp.BNO and alap.DATUM = tmp.DATUM and alap.BRAND_SAJAT = tmp.BRAND_SAJAT)
when matched then
update
    set alap.uj_Foster100 = tmp.uj_Foster100;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

--uj_nemFoster100
create table RFLOW.RF_S248_E_201809_8_0_TMPX1 as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.TCS
    ,alap.BRAND
    ,(case when (uj_nemFoster100.TAJ is NULL) then 1 else 0 end) uj_nemFoster100
from
    RFLOW.RF_S248_E_201809_8_0_TMP1 alap
    left outer join RFLOW.RF_S248_E_201809_8_0_TMP1 uj_nemFoster100 on
        alap.TAJ = uj_nemFoster100.TAJ
        and alap.BRAND = uj_nemFoster100.BRAND
        and alap.TCS = uj_nemFoster100.TCS
        and alap.BNO = uj_nemFoster100.BNO
        and (uj_nemFoster100.datum between (alap.DATUM-180) and (alap.datum-1))
where
    (alap.DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2018/12/31','yyyy/mm/dd'))
    and (alap.BRAND_SAJAT <> 100)
;

create index RF_S248_E_201809_8_0_TMPX1 on RFLOW.RF_S248_E_201809_8_0_TMPX1(TAJ,TCS,BNO,DATUM,BRAND);

merge into
    RFLOW.RF_S248_E_201809_8_0_TMP2 alap
using
    (select * from RFLOW.RF_S248_E_201809_8_0_TMPX1) tmp on (alap.TAJ = tmp.TAJ and alap.TCS = tmp.TCS and alap.BNO = tmp.BNO and alap.DATUM = tmp.DATUM and alap.BRAND = tmp.BRAND)
when matched then
update
    set alap.uj_nemFoster100 = tmp.uj_nemFoster100;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX1 PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

--uj_Foster200
create table RFLOW.RF_S248_E_201809_8_0_TMPX2 as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.TCS
    ,alap.BRAND_SAJAT
    ,(case when (uj_Foster200.TAJ is NULL) then 1 else 0 end) uj_Foster200
from
    RFLOW.RF_S248_E_201809_8_0_TMP1 alap
    left outer join RFLOW.RF_S248_E_201809_8_0_TMP1 uj_Foster200 on
        alap.TAJ = uj_Foster200.TAJ
        and alap.BRAND_SAJAT = uj_Foster200.BRAND_SAJAT
        and alap.TCS = uj_Foster200.TCS
        and alap.BNO = uj_Foster200.BNO
        and (uj_Foster200.datum between (alap.DATUM-180) and (alap.datum-1))
where
    (alap.DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2018/12/31','yyyy/mm/dd'))
    and (alap.BRAND_SAJAT = 200)
;

create index RF_S248_E_201809_8_0_TMPX2 on RFLOW.RF_S248_E_201809_8_0_TMPX2(TAJ,TCS,BNO,DATUM,BRAND_SAJAT);

merge into
    RFLOW.RF_S248_E_201809_8_0_TMP2 alap
using
    (select * from RFLOW.RF_S248_E_201809_8_0_TMPX2) tmp on (alap.TAJ = tmp.TAJ and alap.TCS = tmp.TCS and alap.BNO = tmp.BNO and alap.DATUM = tmp.DATUM and alap.BRAND_SAJAT = tmp.BRAND_SAJAT)
when matched then
update
    set alap.uj_Foster200 = tmp.uj_Foster200;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX2 PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

--uj_Symbicort
create table RFLOW.RF_S248_E_201809_8_0_TMPX3 as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.TCS
    ,alap.BRAND
    ,(case when (uj_Symbicort.TAJ is NULL) then 1 else 0 end) uj_Symbicort
from
    RFLOW.RF_S248_E_201809_8_0_TMP1 alap
    left outer join RFLOW.RF_S248_E_201809_8_0_TMP1 uj_Symbicort on
        alap.TAJ = uj_Symbicort.TAJ
        and alap.BRAND = uj_Symbicort.BRAND
        and alap.TCS = uj_Symbicort.TCS
        and alap.BNO = uj_Symbicort.BNO
        and (uj_Symbicort.datum between (alap.DATUM-180) and (alap.datum-1))
where
    (alap.DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2018/12/31','yyyy/mm/dd'))
    and (alap.BRAND = 'Symbicort')
;

create index RF_S248_E_201809_8_0_TMPX3 on RFLOW.RF_S248_E_201809_8_0_TMPX3(TAJ,TCS,BNO,DATUM,BRAND);

merge into
    RFLOW.RF_S248_E_201809_8_0_TMP2 alap
using
    (select * from RFLOW.RF_S248_E_201809_8_0_TMPX3) tmp on (alap.TAJ = tmp.TAJ and alap.TCS = tmp.TCS and alap.BNO = tmp.BNO and alap.DATUM = tmp.DATUM and alap.BRAND = tmp.BRAND)
when matched then
update
    set alap.uj_Symbicort = tmp.uj_Symbicort;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX3 PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

--uj_Bufomix
create table RFLOW.RF_S248_E_201809_8_0_TMPX4 as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.TCS
    ,alap.BRAND
    ,(case when (uj_Bufomix.TAJ is NULL) then 1 else 0 end) uj_Bufomix
from
    RFLOW.RF_S248_E_201809_8_0_TMP1 alap
    left outer join RFLOW.RF_S248_E_201809_8_0_TMP1 uj_Bufomix on
        alap.TAJ = uj_Bufomix.TAJ
        and alap.BRAND = uj_Bufomix.BRAND
        and alap.TCS = uj_Bufomix.TCS
        and alap.BNO = uj_Bufomix.BNO
        and (uj_Bufomix.datum between (alap.DATUM-180) and (alap.datum-1))
where
    (alap.DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2018/12/31','yyyy/mm/dd'))
    and (alap.BRAND = 'Bufomix Easyhaler')
;

create index RF_S248_E_201809_8_0_TMPX4 on RFLOW.RF_S248_E_201809_8_0_TMPX4(TAJ,TCS,BNO,DATUM,BRAND);

merge into
    RFLOW.RF_S248_E_201809_8_0_TMP2 alap
using
    (select * from RFLOW.RF_S248_E_201809_8_0_TMPX4) tmp on (alap.TAJ = tmp.TAJ and alap.TCS = tmp.TCS and alap.BNO = tmp.BNO and alap.DATUM = tmp.DATUM and alap.BRAND = tmp.BRAND)
when matched then
update
    set alap.uj_Bufomix = tmp.uj_Bufomix;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMPX4';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMP1';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

----------Feldolgozas--------------
create table RFLOW.RF_S248_E_201809_8_TMP_PRE
(
    Kateg varchar2(20)
    ,TAJ varchar2(9)
    ,BRAND varchar2(128)
    ,HO_201606 number(8,4)
    ,HO_201607 number(8,4)
    ,HO_201608 number(8,4)
    ,HO_201609 number(8,4)
    ,HO_201610 number(8,4)
    ,HO_201611 number(8,4)
    ,HO_201612 number(8,4)
    ,HO_201701 number(8,4)
    ,HO_201702 number(8,4)
    ,HO_201703 number(8,4)
    ,HO_201704 number(8,4)
    ,HO_201705 number(8,4)
    ,HO_201706 number(8,4)
    ,HO_201707 number(8,4)
    ,HO_201708 number(8,4)
    ,HO_201709 number(8,4)
    ,HO_201710 number(8,4)
    ,HO_201711 number(8,4)
    ,HO_201712 number(8,4)
    ,HO_201801 number(8,4)
    ,HO_201802 number(8,4)
    ,HO_201803 number(8,4)
    ,HO_201804 number(8,4)
    ,HO_201805 number(8,4)
    ,HO_201806 number(8,4)
    ,HO_201807 number(8,4)
    ,HO_201808 number(8,4)
    ,HO_201809 number(8,4)
    ,HO_201810 number(8,4)
    ,HO_201811 number(8,4)
    ,HO_201812 number(8,4)
    ,mintazat char(31)
    ,MIND numeric(8,4)
    ,kezdoidoszak integer
);

ALTER SESSION SET CURRENT_SCHEMA = RFLOW;

CREATE OR REPLACE PROCEDURE RF_S248_8_ALAP (Kateg varchar2)
IS
    alap201606 number(8,4);
    alap201607 number(8,4);
    alap201608 number(8,4);
    alap201609 number(8,4);
    alap201610 number(8,4);
    alap201611 number(8,4);
    alap201612 number(8,4);
    alap201701 number(8,4);
    alap201702 number(8,4);
    alap201703 number(8,4);
    alap201704 number(8,4);
    alap201705 number(8,4);
    alap201706 number(8,4); 
    alap201707 number(8,4);
    alap201708 number(8,4);
    alap201709 number(8,4);
    alap201710 number(8,4);
    alap201711 number(8,4);
    alap201712 number(8,4);
    alap201801 number(8,4);
    alap201802 number(8,4);
    alap201803 number(8,4);
    alap201804 number(8,4);
    alap201805 number(8,4);
    alap201806 number(8,4); 
    alap201807 number(8,4);
    alap201808 number(8,4);
    alap201809 number(8,4);
    alap201810 number(8,4);
    alap201811 number(8,4);
    alap201812 number(8,4);
    AKTTAJ varchar2(9);
    BRANDNEV varchar2(128);
    aktbeteg integer;
    maxbeteg integer;
BEGIN
    select min(sorsz) into aktbeteg from RFLOW.RF_S248_E_201809_8_TMP_TAJ;
    select max(sorsz) into maxbeteg from RFLOW.RF_S248_E_201809_8_TMP_TAJ;
    
    while aktbeteg <= maxbeteg
    loop
        select TAJ into AKTTAJ from RFLOW.RF_S248_E_201809_8_TMP_TAJ where sorsz = aktbeteg;
        select BRAND into BRANDNEV from RFLOW.RF_S248_E_201809_8_TMP_TAJ where sorsz = aktbeteg;
        
        
        select sum(menny) into alap201606 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2016/06/01','YYYY/MM/DD') and to_date('2016/06/30','YYYY/MM/DD'));                      
        select sum(menny) into alap201607 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2016/07/01','YYYY/MM/DD') and to_date('2016/07/31','YYYY/MM/DD'));                      
        select sum(menny) into alap201608 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2016/08/01','YYYY/MM/DD') and to_date('2016/08/31','YYYY/MM/DD'));
        select sum(menny) into alap201609 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2016/09/01','YYYY/MM/DD') and to_date('2016/09/30','YYYY/MM/DD'));
        select sum(menny) into alap201610 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2016/10/01','YYYY/MM/DD') and to_date('2016/10/31','YYYY/MM/DD'));
        select sum(menny) into alap201611 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2016/11/01','YYYY/MM/DD') and to_date('2016/11/30','YYYY/MM/DD')); 
        select sum(menny) into alap201612 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2016/12/01','YYYY/MM/DD') and to_date('2016/12/31','YYYY/MM/DD'));   
        select sum(menny) into alap201701 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/01/01','YYYY/MM/DD') and to_date('2017/01/31','YYYY/MM/DD')); 
        select sum(menny) into alap201702 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/02/01','YYYY/MM/DD') and to_date('2017/02/28','YYYY/MM/DD'));
        select sum(menny) into alap201703 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/03/01','YYYY/MM/DD') and to_date('2017/03/31','YYYY/MM/DD'));
        select sum(menny) into alap201704 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/04/01','YYYY/MM/DD') and to_date('2017/04/30','YYYY/MM/DD')); 
        select sum(menny) into alap201705 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/05/01','YYYY/MM/DD') and to_date('2017/05/31','YYYY/MM/DD'));
        select sum(menny) into alap201706 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/06/01','YYYY/MM/DD') and to_date('2017/06/30','YYYY/MM/DD'));
        select sum(menny) into alap201707 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/07/01','YYYY/MM/DD') and to_date('2017/07/31','YYYY/MM/DD'));                      
        select sum(menny) into alap201708 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/08/01','YYYY/MM/DD') and to_date('2017/08/31','YYYY/MM/DD'));
        select sum(menny) into alap201709 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/09/01','YYYY/MM/DD') and to_date('2017/09/30','YYYY/MM/DD'));
        select sum(menny) into alap201710 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/10/01','YYYY/MM/DD') and to_date('2017/10/31','YYYY/MM/DD'));
        select sum(menny) into alap201711 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/11/01','YYYY/MM/DD') and to_date('2017/11/30','YYYY/MM/DD')); 
        select sum(menny) into alap201712 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2017/12/01','YYYY/MM/DD') and to_date('2017/12/31','YYYY/MM/DD'));        
        select sum(menny) into alap201801 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/01/01','YYYY/MM/DD') and to_date('2018/01/31','YYYY/MM/DD')); 
        select sum(menny) into alap201802 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/02/01','YYYY/MM/DD') and to_date('2018/02/28','YYYY/MM/DD'));
        select sum(menny) into alap201803 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/03/01','YYYY/MM/DD') and to_date('2018/03/31','YYYY/MM/DD'));      
        select sum(menny) into alap201804 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/04/01','YYYY/MM/DD') and to_date('2018/04/30','YYYY/MM/DD')); 
        select sum(menny) into alap201805 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/05/01','YYYY/MM/DD') and to_date('2018/05/31','YYYY/MM/DD'));
        select sum(menny) into alap201806 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/06/01','YYYY/MM/DD') and to_date('2018/06/30','YYYY/MM/DD'));
        select sum(menny) into alap201807 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/07/01','YYYY/MM/DD') and to_date('2018/07/31','YYYY/MM/DD'));                      
        select sum(menny) into alap201808 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/08/01','YYYY/MM/DD') and to_date('2018/08/31','YYYY/MM/DD'));
        select sum(menny) into alap201809 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/09/01','YYYY/MM/DD') and to_date('2018/09/30','YYYY/MM/DD'));
        select sum(menny) into alap201810 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/10/01','YYYY/MM/DD') and to_date('2018/10/31','YYYY/MM/DD'));
        select sum(menny) into alap201811 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/11/01','YYYY/MM/DD') and to_date('2018/11/30','YYYY/MM/DD')); 
        select sum(menny) into alap201812 from RFLOW.RF_S248_E_201809_8_0_TMP2 where (TAJ = AKTTAJ) and (DATUM between to_date('2018/12/01','YYYY/MM/DD') and to_date('2018/12/31','YYYY/MM/DD'));                  
        
        insert into RFLOW.RF_S248_E_201809_8_TMP_PRE values(Kateg,AKTTAJ,BRANDNEV,nvl(alap201606,0),nvl(alap201607,0),nvl(alap201608,0),nvl(alap201609,0),nvl(alap201610,0),nvl(alap201611,0),nvl(alap201612,0),nvl(alap201701,0),nvl(alap201702,0),nvl(alap201703,0),nvl(alap201704,0),nvl(alap201705,0),nvl(alap201706,0)
        ,nvl(alap201707,0),nvl(alap201708,0),nvl(alap201709,0),nvl(alap201710,0),nvl(alap201711,0),nvl(alap201712,0),nvl(alap201801,0),nvl(alap201802,0),nvl(alap201803,0),nvl(alap201804,0),nvl(alap201805,0),nvl(alap201806,0),nvl(alap201807,0),nvl(alap201808,0),nvl(alap201809,0),nvl(alap201810,0)
        ,nvl(alap201811,0),nvl(alap201812,0),'0000000000000000000000000000000',0,0);
        
        aktbeteg := aktbeteg + 1;
    end loop;
    
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  INSERT INTO RFLOW.RF_S248_E_201809_8_TMP_PRE values(Kateg,'1','Nincs adat',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0000000000000000000000000000000',0,0);
END RF_S248_8_ALAP;

----------J44ICSLABA30--------------
--2016.06-2017.03
create table RFLOW.RF_S248_E_201809_8_TMP_TAJ as
select
    ROW_NUMBER() over(order by TAJ) SORSZ
    ,TAJ
    ,BRAND
from
    (select distinct
        TAJ
        ,BRAND
    from
        RFLOW.RF_S248_E_201809_8_0_TMP2
    where
        (uj_nemFoster100 > 0)
        and (BRAND_SAJAT <> 100)
        and (DATUM between to_date('2016/06/01','yyyy/mm/dd') and to_date('2017/03/31','yyyy/mm/dd'))
        and (TCS = 'ICS+LABA')
        and (BNO = 'J44')
    ) alap
order by
    TAJ
    ,BRAND
;

create index E_8_TMPTAJ_SORSZ on RFLOW.RF_S248_E_201809_8_TMP_TAJ(SORSZ);

BEGIN
  RFLOW.RF_S248_8_ALAP('J44ICSLABA30');
  commit;
END;

--30 napos grace
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 123.9999
where
    HO_201811 > 0 and HO_201812 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 123.9999
where
    HO_201810 > 0 and HO_201811 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 123.9999
where
    HO_201809 > 0 and HO_201810 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 123.9999
where
    HO_201808 > 0 and HO_201809 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 123.9999
where
    HO_201807 > 0 and HO_201808 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 123.9999
where
    HO_201806 > 0 and HO_201807 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 123.9999
where
    HO_201805 > 0 and HO_201806 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 123.9999
where
    HO_201804 > 0 and HO_201805 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 123.9999
where
    HO_201803 > 0 and HO_201804 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 123.9999
where
    HO_201802 > 0 and HO_201803 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 123.9999
where
    HO_201801 > 0 and HO_201802 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 123.9999
where
    HO_201712 > 0 and HO_201801 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 123.9999
where
    HO_201711 > 0 and HO_201712 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 123.9999
where
    HO_201710 > 0 and HO_201711 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 123.9999
where
    HO_201709 > 0 and HO_201710 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 123.9999
where
    HO_201708 > 0 and HO_201709 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 123.9999
where
    HO_201707 > 0 and HO_201708 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 123.9999
where
    HO_201706 > 0 and HO_201707 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 123.9999
where
    HO_201705 > 0 and HO_201706 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 123.9999
where
    HO_201704 > 0 and HO_201705 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 123.9999
where
    HO_201703 > 0 and HO_201704 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 123.9999
where
    HO_201702 > 0 and HO_201703 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 123.9999
where
    HO_201701 > 0 and HO_201702 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 123.9999
where
    HO_201612 > 0 and HO_201701 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 123.9999
where
    HO_201611 > 0 and HO_201612 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 123.9999
where
    HO_201610 > 0 and HO_201611 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 123.9999
where
    HO_201609 > 0 and HO_201610 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 123.9999
where
    HO_201608 > 0 and HO_201609 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 123.9999
where
    HO_201607 > 0 and HO_201608 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 123.9999
where
    HO_201606 > 0 and HO_201607 = 0
    and Kateg = 'J44ICSLABA30'
;
commit;
--grace end

--perzisztencia
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    mintazat = (case when HO_201606 = 0 then '0' else '1' end)
    ||(case when HO_201607 = 0 then '0' else '1' end)
    ||(case when HO_201608 = 0 then '0' else '1' end)
    ||(case when HO_201609 = 0 then '0' else '1' end)
    ||(case when HO_201610 = 0 then '0' else '1' end)
    ||(case when HO_201611 = 0 then '0' else '1' end)
    ||(case when HO_201612 = 0 then '0' else '1' end)
    ||(case when HO_201701 = 0 then '0' else '1' end)
    ||(case when HO_201702 = 0 then '0' else '1' end)
    ||(case when HO_201703 = 0 then '0' else '1' end)
    ||(case when HO_201704 = 0 then '0' else '1' end)
    ||(case when HO_201705 = 0 then '0' else '1' end)
    ||(case when HO_201706 = 0 then '0' else '1' end) 
    ||(case when HO_201707 = 0 then '0' else '1' end)
    ||(case when HO_201708 = 0 then '0' else '1' end)
    ||(case when HO_201709 = 0 then '0' else '1' end)
    ||(case when HO_201710 = 0 then '0' else '1' end)
    ||(case when HO_201711 = 0 then '0' else '1' end)
    ||(case when HO_201712 = 0 then '0' else '1' end)
    ||(case when HO_201801 = 0 then '0' else '1' end)
    ||(case when HO_201802 = 0 then '0' else '1' end)
    ||(case when HO_201803 = 0 then '0' else '1' end)  
    ||(case when HO_201803 = 0 then '0' else '1' end)
    ||(case when HO_201804 = 0 then '0' else '1' end)
    ||(case when HO_201805 = 0 then '0' else '1' end)
    ||(case when HO_201806 = 0 then '0' else '1' end) 
    ||(case when HO_201807 = 0 then '0' else '1' end)
    ||(case when HO_201808 = 0 then '0' else '1' end)
    ||(case when HO_201809 = 0 then '0' else '1' end)
    ||(case when HO_201810 = 0 then '0' else '1' end)
    ||(case when HO_201811 = 0 then '0' else '1' end)
    ||(case when HO_201812 = 0 then '0' else '1' end)
where
    Kateg = 'J44ICSLABA30'
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_PRE
where
    mintazat not like '%111111111111%'
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    kezdoidoszak = instr(mintazat,'111111111111',1)
where
    Kateg = 'J44ICSLABA30'
;
commit;
--perzisztencia end

--menny ertek takarit
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 0
where
    HO_201812 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 0
where
    HO_201811 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 0
where
    HO_201810 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 0
where
    HO_201809 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 0
where
    HO_201808 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 0
where
    HO_201807 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 0
where
    HO_201806 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 0
where
    HO_201805 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 0
where
    HO_201804 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 0
where
    HO_201803 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 0
where
    HO_201802 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 0
where
    HO_201801 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 0
where
    HO_201712 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 0
where
    HO_201711 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 0
where
    HO_201710 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 0
where
    HO_201709 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 0
where
    HO_201708 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 0
where
    HO_201707 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 0
where
    HO_201706 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 0
where
    HO_201705 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 0
where
    HO_201704 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 0
where
    HO_201703 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 0
where
    HO_201702 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 0
where
    HO_201701 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 0
where
    HO_201612 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 0
where
    HO_201611 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 0
where
    HO_201610 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 0
where
    HO_201609 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 0
where
    HO_201608 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 0
where
    HO_201607 = 123.9999
    and Kateg = 'J44ICSLABA30'
;
commit;
--menny ertek takarit end

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    MIND = (case
        when kezdoidoszak = 1 then (HO_201606+HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705)
        when kezdoidoszak = 2 then (HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706)
        when kezdoidoszak = 3 then (HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707)
        when kezdoidoszak = 4 then (HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708)
        when kezdoidoszak = 5 then (HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709)
        when kezdoidoszak = 6 then (HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710)
        when kezdoidoszak = 7 then (HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711)       
        when kezdoidoszak = 8 then (HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712)
        when kezdoidoszak = 9 then (HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801)
        when kezdoidoszak = 10 then (HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802)
        when kezdoidoszak = 11 then (HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803)
        when kezdoidoszak = 12 then (HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804)
        when kezdoidoszak = 13 then (HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805)
        when kezdoidoszak = 14 then (HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806)
        when kezdoidoszak = 15 then (HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807)
        when kezdoidoszak = 16 then (HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808)
        when kezdoidoszak = 17 then (HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809)
        when kezdoidoszak = 18 then (HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810)
        when kezdoidoszak = 19 then (HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811)
        when kezdoidoszak = 20 then (HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811+HO_201812)
    end)
where
    Kateg = 'J44ICSLABA30'  
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
;
commit;
----------J44ICSLABA30 end--------------
----------J44ICSLABA45--------------
--2016.06-2018.12
insert into
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
select
    ROW_NUMBER() over(order by TAJ) SORSZ
    ,TAJ
    ,BRAND
from
    (select distinct
        TAJ
        ,BRAND
    from
        RFLOW.RF_S248_E_201809_8_0_TMP2
    where
        (uj_mind > 0)
        and (DATUM between to_date('2016/06/01','yyyy/mm/dd') and to_date('2017/03/31','yyyy/mm/dd'))
        and (TCS = 'ICS+LABA')
        and (BNO = 'J44')
    ) alap
order by
    TAJ
    ,BRAND
;
commit;

BEGIN
  RFLOW.RF_S248_8_ALAP('J44ICSLABA45');
  commit;
END;

--45 napos grace
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 123.9999
where
    (HO_201810 > 0 or HO_201811 > 0) and HO_201812 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 123.9999
where
    (HO_201809 > 0 or HO_201810 > 0) and HO_201811 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 123.9999
where
    (HO_201808 > 0 or HO_201809 > 0) and HO_201810 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 123.9999
where
    (HO_201807 > 0 or HO_201808 > 0) and HO_201809 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 123.9999
where
    (HO_201806 > 0 or HO_201807 > 0) and HO_201808 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 123.9999
where
    (HO_201805 > 0 or HO_201806 > 0) and HO_201807 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 123.9999
where
    (HO_201804 > 0 or HO_201805 > 0)and HO_201806 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 123.9999
where
    (HO_201803 > 0 or HO_201804 > 0) and HO_201805 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 123.9999
where
    (HO_201802 > 0 or HO_201803 > 0) and HO_201804 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 123.9999
where
    (HO_201801 > 0 or HO_201802 > 0) and HO_201803 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 123.9999
where
    (HO_201712 > 0 or HO_201801 > 0) and HO_201802 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 123.9999
where
    (HO_201711 > 0 or HO_201712 > 0) and HO_201801 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 123.9999
where
    (HO_201710 > 0 or HO_201711 > 0) and HO_201712 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 123.9999
where
    (HO_201709 > 0 or HO_201710 > 0) and HO_201711 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 123.9999
where
    (HO_201708 > 0 or HO_201709 > 0) and HO_201710 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 123.9999
where
    (HO_201707 > 0 or HO_201708 > 0) and HO_201709 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 123.9999
where
    (HO_201706 > 0 or HO_201707 > 0) and HO_201708 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 123.9999
where
    (HO_201705 > 0 or HO_201706 > 0) and HO_201707 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 123.9999
where
    (HO_201704 > 0 or HO_201705 > 0)and HO_201706 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 123.9999
where
    (HO_201703 > 0 or HO_201704 > 0) and HO_201705 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 123.9999
where
    (HO_201702 > 0 or HO_201703 > 0) and HO_201704 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 123.9999
where
    (HO_201701 > 0 or HO_201702 > 0) and HO_201703 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 123.9999
where
    (HO_201612 > 0 or HO_201701 > 0) and HO_201702 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 123.9999
where
    (HO_201611 > 0 or HO_201612 > 0) and HO_201701 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 123.9999
where
    (HO_201610 > 0 or HO_201611 > 0) and HO_201612 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 123.9999
where
    (HO_201609 > 0 or HO_201610 > 0) and HO_201611 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 123.9999
where
    (HO_201608 > 0 or HO_201609 > 0) and HO_201610 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 123.9999
where
    (HO_201607 > 0 or HO_201608 > 0) and HO_201609 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 123.9999
where
    (HO_201606 > 0 or HO_201607 > 0) and HO_201608 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 123.9999
where
    HO_201606 > 0 and HO_201607 = 0
    and Kateg = 'J44ICSLABA45'
;
commit;
--grace end

--perzisztencia
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    mintazat = (case when HO_201606 = 0 then '0' else '1' end)
    ||(case when HO_201607 = 0 then '0' else '1' end)
    ||(case when HO_201608 = 0 then '0' else '1' end)
    ||(case when HO_201609 = 0 then '0' else '1' end)
    ||(case when HO_201610 = 0 then '0' else '1' end)
    ||(case when HO_201611 = 0 then '0' else '1' end)
    ||(case when HO_201612 = 0 then '0' else '1' end)
    ||(case when HO_201701 = 0 then '0' else '1' end)
    ||(case when HO_201702 = 0 then '0' else '1' end)
    ||(case when HO_201703 = 0 then '0' else '1' end)
    ||(case when HO_201704 = 0 then '0' else '1' end)
    ||(case when HO_201705 = 0 then '0' else '1' end)
    ||(case when HO_201706 = 0 then '0' else '1' end) 
    ||(case when HO_201707 = 0 then '0' else '1' end)
    ||(case when HO_201708 = 0 then '0' else '1' end)
    ||(case when HO_201709 = 0 then '0' else '1' end)
    ||(case when HO_201710 = 0 then '0' else '1' end)
    ||(case when HO_201711 = 0 then '0' else '1' end)
    ||(case when HO_201712 = 0 then '0' else '1' end)
    ||(case when HO_201801 = 0 then '0' else '1' end)
    ||(case when HO_201802 = 0 then '0' else '1' end)
    ||(case when HO_201803 = 0 then '0' else '1' end)
    ||(case when HO_201804 = 0 then '0' else '1' end)
    ||(case when HO_201805 = 0 then '0' else '1' end)
    ||(case when HO_201806 = 0 then '0' else '1' end) 
    ||(case when HO_201807 = 0 then '0' else '1' end)
    ||(case when HO_201808 = 0 then '0' else '1' end)
    ||(case when HO_201809 = 0 then '0' else '1' end)
    ||(case when HO_201810 = 0 then '0' else '1' end)
    ||(case when HO_201811 = 0 then '0' else '1' end)
    ||(case when HO_201812 = 0 then '0' else '1' end)
where
    Kateg = 'J44ICSLABA45'
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_PRE
where
    mintazat not like '%111111111111%'
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    kezdoidoszak = instr(mintazat,'111111111111',1)
where
    Kateg = 'J44ICSLABA45'
;
commit;
--perzisztencia end

--menny ertek takarit
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 0
where
    HO_201812 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 0
where
    HO_201811 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 0
where
    HO_201810 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 0
where
    HO_201809 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 0
where
    HO_201808 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 0
where
    HO_201807 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 0
where
    HO_201806 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 0
where
    HO_201805 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 0
where
    HO_201804 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 0
where
    HO_201803 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 0
where
    HO_201802 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 0
where
    HO_201801 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 0
where
    HO_201712 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 0
where
    HO_201711 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 0
where
    HO_201710 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 0
where
    HO_201709 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 0
where
    HO_201708 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 0
where
    HO_201707 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 0
where
    HO_201706 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 0
where
    HO_201705 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 0
where
    HO_201704 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 0
where
    HO_201703 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 0
where
    HO_201702 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 0
where
    HO_201701 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 0
where
    HO_201612 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 0
where
    HO_201611 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 0
where
    HO_201610 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 0
where
    HO_201609 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 0
where
    HO_201608 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 0
where
    HO_201607 = 123.9999
    and Kateg = 'J44ICSLABA45'
;
commit;
--menny ertek takarit end

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    MIND = (case
        when kezdoidoszak = 1 then (HO_201606+HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705)
        when kezdoidoszak = 2 then (HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706)
        when kezdoidoszak = 3 then (HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707)
        when kezdoidoszak = 4 then (HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708)
        when kezdoidoszak = 5 then (HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709)
        when kezdoidoszak = 6 then (HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710)
        when kezdoidoszak = 7 then (HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711)       
        when kezdoidoszak = 8 then (HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712)
        when kezdoidoszak = 9 then (HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801)
        when kezdoidoszak = 10 then (HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802)
        when kezdoidoszak = 11 then (HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803)       
        when kezdoidoszak = 12 then (HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804)
        when kezdoidoszak = 13 then (HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805)
        when kezdoidoszak = 14 then (HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806)
        when kezdoidoszak = 15 then (HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807)
        when kezdoidoszak = 16 then (HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808)
        when kezdoidoszak = 17 then (HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809)
        when kezdoidoszak = 18 then (HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810)
        when kezdoidoszak = 19 then (HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811)
        when kezdoidoszak = 20 then (HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811+HO_201812)
    end)
where
    Kateg = 'J44ICSLABA45'  
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
;
commit;
----------J44ICSLABA45 end--------------
----------J44FOSTER--------------
--2016.06-2018.12
insert into
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
select
    ROW_NUMBER() over(order by TAJ) SORSZ
    ,TAJ
    ,BRAND
from
    (select distinct
        TAJ
        ,BRAND
    from
        RFLOW.RF_S248_E_201809_8_0_TMP2
    where
        (uj_Foster100 > 0)
        and (DATUM between to_date('2016/06/01','yyyy/mm/dd') and to_date('2017/01/31','yyyy/mm/dd'))
        and (BNO = 'J44')
        and (BRAND_SAJAT = 100)
    ) alap
order by
    TAJ
    ,BRAND
;
commit;

BEGIN
  RFLOW.RF_S248_8_ALAP('J44FOSTER');
  commit;
END;

--60 napos grace
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 123.9999
where
    (HO_201810 > 0 or HO_201811 > 0) and HO_201812 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 123.9999
where
    (HO_201809 > 0 or HO_201810 > 0) and HO_201811 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 123.9999
where
    (HO_201808 > 0 or HO_201809 > 0) and HO_201810 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 123.9999
where
    (HO_201807 > 0 or HO_201808 > 0) and HO_201809 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 123.9999
where
    (HO_201806 > 0 or HO_201807 > 0) and HO_201808 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 123.9999
where
    (HO_201805 > 0 or HO_201806 > 0) and HO_201807 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 123.9999
where
    (HO_201804 > 0 or HO_201805 > 0)and HO_201806 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 123.9999
where
    (HO_201801 > 0 or HO_201802 > 0) and HO_201803 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 123.9999
where
    (HO_201712 > 0 or HO_201801 > 0) and HO_201802 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 123.9999
where
    (HO_201711 > 0 or HO_201712 > 0) and HO_201801 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 123.9999
where
    (HO_201710 > 0 or HO_201711 > 0) and HO_201712 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 123.9999
where
    (HO_201709 > 0 or HO_201710 > 0) and HO_201711 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 123.9999
where
    (HO_201708 > 0 or HO_201709 > 0) and HO_201710 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 123.9999
where
    (HO_201707 > 0 or HO_201708 > 0) and HO_201709 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 123.9999
where
    (HO_201706 > 0 or HO_201707 > 0) and HO_201708 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 123.9999
where
    (HO_201705 > 0 or HO_201706 > 0) and HO_201707 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 123.9999
where
    (HO_201704 > 0 or HO_201705 > 0)and HO_201706 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 123.9999
where
    (HO_201703 > 0 or HO_201704 > 0) and HO_201705 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 123.9999
where
    (HO_201702 > 0 or HO_201703 > 0) and HO_201704 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 123.9999
where
    (HO_201701 > 0 or HO_201702 > 0) and HO_201703 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 123.9999
where
    (HO_201612 > 0 or HO_201701 > 0) and HO_201702 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 123.9999
where
    (HO_201611 > 0 or HO_201612 > 0) and HO_201701 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 123.9999
where
    (HO_201610 > 0 or HO_201611 > 0) and HO_201612 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 123.9999
where
    (HO_201609 > 0 or HO_201610 > 0) and HO_201611 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 123.9999
where
    (HO_201608 > 0 or HO_201609 > 0) and HO_201610 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 123.9999
where
    (HO_201607 > 0 or HO_201608 > 0) and HO_201609 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 123.9999
where
    (HO_201606 > 0 or HO_201607 > 0) and HO_201608 = 0
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 123.9999
where
    HO_201606 > 0 and HO_201607 = 0
    and Kateg = 'J44FOSTER'
;
commit;
--grace end

--perzisztencia
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    mintazat = (case when HO_201606 = 0 then '0' else '1' end)
    ||(case when HO_201607 = 0 then '0' else '1' end)
    ||(case when HO_201608 = 0 then '0' else '1' end)
    ||(case when HO_201609 = 0 then '0' else '1' end)
    ||(case when HO_201610 = 0 then '0' else '1' end)
    ||(case when HO_201611 = 0 then '0' else '1' end)
    ||(case when HO_201612 = 0 then '0' else '1' end)
    ||(case when HO_201701 = 0 then '0' else '1' end)
    ||(case when HO_201702 = 0 then '0' else '1' end)
    ||(case when HO_201703 = 0 then '0' else '1' end)
    ||(case when HO_201704 = 0 then '0' else '1' end)
    ||(case when HO_201705 = 0 then '0' else '1' end)
    ||(case when HO_201706 = 0 then '0' else '1' end) 
    ||(case when HO_201707 = 0 then '0' else '1' end)
    ||(case when HO_201708 = 0 then '0' else '1' end)
    ||(case when HO_201709 = 0 then '0' else '1' end)
    ||(case when HO_201710 = 0 then '0' else '1' end)
    ||(case when HO_201711 = 0 then '0' else '1' end)
    ||(case when HO_201712 = 0 then '0' else '1' end)
    ||(case when HO_201801 = 0 then '0' else '1' end)
    ||(case when HO_201802 = 0 then '0' else '1' end)
    ||(case when HO_201803 = 0 then '0' else '1' end) 
    ||(case when HO_201804 = 0 then '0' else '1' end)
    ||(case when HO_201805 = 0 then '0' else '1' end)
    ||(case when HO_201806 = 0 then '0' else '1' end) 
    ||(case when HO_201807 = 0 then '0' else '1' end)
    ||(case when HO_201808 = 0 then '0' else '1' end)
    ||(case when HO_201809 = 0 then '0' else '1' end)
    ||(case when HO_201810 = 0 then '0' else '1' end)
    ||(case when HO_201811 = 0 then '0' else '1' end)
    ||(case when HO_201812 = 0 then '0' else '1' end)
where
    Kateg = 'J44FOSTER'
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_PRE
where
    mintazat not like '%111111111111%'
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    kezdoidoszak = instr(mintazat,'111111111111',1)
where
    Kateg = 'J44FOSTER'
;
commit;
--perzisztencia end

--menny ertek takarit
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 0
where
    HO_201812 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 0
where
    HO_201811 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 0
where
    HO_201810 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 0
where
    HO_201809 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 0
where
    HO_201808 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 0
where
    HO_201807 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 0
where
    HO_201806 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 0
where
    HO_201805 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 0
where
    HO_201804 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 0
where
    HO_201803 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 0
where
    HO_201802 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 0
where
    HO_201801 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 0
where
    HO_201712 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 0
where
    HO_201711 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 0
where
    HO_201710 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 0
where
    HO_201709 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 0
where
    HO_201708 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 0
where
    HO_201707 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 0
where
    HO_201706 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 0
where
    HO_201705 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 0
where
    HO_201704 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 0
where
    HO_201703 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 0
where
    HO_201702 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 0
where
    HO_201701 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 0
where
    HO_201612 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 0
where
    HO_201611 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 0
where
    HO_201610 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 0
where
    HO_201609 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 0
where
    HO_201608 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 0
where
    HO_201607 = 123.9999
    and Kateg = 'J44FOSTER'
;
commit;
--menny ertek takarit end

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    MIND = (case
        when kezdoidoszak = 1 then (HO_201606+HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705)
        when kezdoidoszak = 2 then (HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706)
        when kezdoidoszak = 3 then (HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707)
        when kezdoidoszak = 4 then (HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708)
        when kezdoidoszak = 5 then (HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709)
        when kezdoidoszak = 6 then (HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710)
        when kezdoidoszak = 7 then (HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711)       
        when kezdoidoszak = 8 then (HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712)
        when kezdoidoszak = 9 then (HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801)
        when kezdoidoszak = 10 then (HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802)
        when kezdoidoszak = 11 then (HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803)       
        when kezdoidoszak = 12 then (HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804)
        when kezdoidoszak = 13 then (HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805)
        when kezdoidoszak = 14 then (HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806)
        when kezdoidoszak = 15 then (HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807)
        when kezdoidoszak = 16 then (HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808)
        when kezdoidoszak = 17 then (HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809)
        when kezdoidoszak = 18 then (HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810)
        when kezdoidoszak = 19 then (HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811)
        when kezdoidoszak = 20 then (HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811+HO_201812)
    end)
where
    Kateg = 'J44FOSTER'  
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
;
commit;
----------J44FOSTER end--------------
----------J45SYMB--------------
--2016.06-2018.12
insert into
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
select
    ROW_NUMBER() over(order by TAJ) SORSZ
    ,TAJ
    ,BRAND
from
    (select distinct
        TAJ
        ,BRAND
    from
        RFLOW.RF_S248_E_201809_8_0_TMP2
    where
        (uj_Symbicort > 0)
        and (DATUM between to_date('2016/06/01','yyyy/mm/dd') and to_date('2017/01/31','yyyy/mm/dd'))
        and (BNO = 'J45')
        and BRAND = 'Symbicort'
    ) alap
order by
    TAJ
    ,BRAND
;
commit;

BEGIN
  RFLOW.RF_S248_8_ALAP('J45SYMB');
  commit;
END;

--60 napos grace
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 123.9999
where
    (HO_201810 > 0 or HO_201811 > 0) and HO_201812 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 123.9999
where
    (HO_201809 > 0 or HO_201810 > 0) and HO_201811 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 123.9999
where
    (HO_201808 > 0 or HO_201809 > 0) and HO_201810 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 123.9999
where
    (HO_201807 > 0 or HO_201808 > 0) and HO_201809 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 123.9999
where
    (HO_201806 > 0 or HO_201807 > 0) and HO_201808 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 123.9999
where
    (HO_201805 > 0 or HO_201806 > 0) and HO_201807 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 123.9999
where
    (HO_201804 > 0 or HO_201805 > 0)and HO_201806 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 123.9999
where
    (HO_201803 > 0 or HO_201804 > 0) and HO_201805 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 123.9999
where
    (HO_201802 > 0 or HO_201803 > 0) and HO_201804 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 123.9999
where
    (HO_201801 > 0 or HO_201802 > 0) and HO_201803 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 123.9999
where
    (HO_201712 > 0 or HO_201801 > 0) and HO_201802 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 123.9999
where
    (HO_201711 > 0 or HO_201712 > 0) and HO_201801 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 123.9999
where
    (HO_201710 > 0 or HO_201711 > 0) and HO_201712 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 123.9999
where
    (HO_201709 > 0 or HO_201710 > 0) and HO_201711 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 123.9999
where
    (HO_201708 > 0 or HO_201709 > 0) and HO_201710 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 123.9999
where
    (HO_201707 > 0 or HO_201708 > 0) and HO_201709 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 123.9999
where
    (HO_201706 > 0 or HO_201707 > 0) and HO_201708 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 123.9999
where
    (HO_201705 > 0 or HO_201706 > 0) and HO_201707 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 123.9999
where
    (HO_201704 > 0 or HO_201705 > 0)and HO_201706 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 123.9999
where
    (HO_201703 > 0 or HO_201704 > 0) and HO_201705 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 123.9999
where
    (HO_201702 > 0 or HO_201703 > 0) and HO_201704 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 123.9999
where
    (HO_201701 > 0 or HO_201702 > 0) and HO_201703 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 123.9999
where
    (HO_201612 > 0 or HO_201701 > 0) and HO_201702 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 123.9999
where
    (HO_201611 > 0 or HO_201612 > 0) and HO_201701 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 123.9999
where
    (HO_201610 > 0 or HO_201611 > 0) and HO_201612 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 123.9999
where
    (HO_201609 > 0 or HO_201610 > 0) and HO_201611 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 123.9999
where
    (HO_201608 > 0 or HO_201609 > 0) and HO_201610 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 123.9999
where
    (HO_201607 > 0 or HO_201608 > 0) and HO_201609 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 123.9999
where
    (HO_201606 > 0 or HO_201607 > 0) and HO_201608 = 0
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 123.9999
where
    HO_201606 > 0 and HO_201607 = 0
    and Kateg = 'J45SYMB'
;
commit;
--grace end

--perzisztencia
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    mintazat = (case when HO_201606 = 0 then '0' else '1' end)
    ||(case when HO_201607 = 0 then '0' else '1' end)
    ||(case when HO_201608 = 0 then '0' else '1' end)
    ||(case when HO_201609 = 0 then '0' else '1' end)
    ||(case when HO_201610 = 0 then '0' else '1' end)
    ||(case when HO_201611 = 0 then '0' else '1' end)
    ||(case when HO_201612 = 0 then '0' else '1' end)
    ||(case when HO_201701 = 0 then '0' else '1' end)
    ||(case when HO_201702 = 0 then '0' else '1' end)
    ||(case when HO_201703 = 0 then '0' else '1' end)
    ||(case when HO_201704 = 0 then '0' else '1' end)
    ||(case when HO_201705 = 0 then '0' else '1' end)
    ||(case when HO_201706 = 0 then '0' else '1' end) 
    ||(case when HO_201707 = 0 then '0' else '1' end)
    ||(case when HO_201708 = 0 then '0' else '1' end)
    ||(case when HO_201709 = 0 then '0' else '1' end)
    ||(case when HO_201710 = 0 then '0' else '1' end)
    ||(case when HO_201711 = 0 then '0' else '1' end)
    ||(case when HO_201712 = 0 then '0' else '1' end)
    ||(case when HO_201801 = 0 then '0' else '1' end)
    ||(case when HO_201802 = 0 then '0' else '1' end)
    ||(case when HO_201803 = 0 then '0' else '1' end)
    ||(case when HO_201804 = 0 then '0' else '1' end)
    ||(case when HO_201805 = 0 then '0' else '1' end)
    ||(case when HO_201806 = 0 then '0' else '1' end) 
    ||(case when HO_201807 = 0 then '0' else '1' end)
    ||(case when HO_201808 = 0 then '0' else '1' end)
    ||(case when HO_201809 = 0 then '0' else '1' end)
    ||(case when HO_201810 = 0 then '0' else '1' end)
    ||(case when HO_201811 = 0 then '0' else '1' end)
    ||(case when HO_201812 = 0 then '0' else '1' end)
where
    Kateg = 'J45SYMB'
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_PRE
where
    mintazat not like '%111111111111%'
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    kezdoidoszak = instr(mintazat,'111111111111',1)
where
    Kateg = 'J45SYMB'
;
commit;
--perzisztencia end

--menny ertek takarit
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 0
where
    HO_201812 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 0
where
    HO_201811 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 0
where
    HO_201810 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 0
where
    HO_201809 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 0
where
    HO_201808 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 0
where
    HO_201807 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 0
where
    HO_201806 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 0
where
    HO_201805 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 0
where
    HO_201804 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 0
where
    HO_201803 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 0
where
    HO_201802 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 0
where
    HO_201801 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 0
where
    HO_201712 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 0
where
    HO_201711 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 0
where
    HO_201710 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 0
where
    HO_201709 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 0
where
    HO_201708 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 0
where
    HO_201707 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 0
where
    HO_201706 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 0
where
    HO_201705 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 0
where
    HO_201704 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 0
where
    HO_201703 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 0
where
    HO_201702 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 0
where
    HO_201701 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 0
where
    HO_201612 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 0
where
    HO_201611 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 0
where
    HO_201610 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 0
where
    HO_201609 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 0
where
    HO_201608 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 0
where
    HO_201607 = 123.9999
    and Kateg = 'J45SYMB'
;
commit;
--menny ertek takarit end

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    MIND = (case
        when kezdoidoszak = 1 then (HO_201606+HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705)
        when kezdoidoszak = 2 then (HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706)
        when kezdoidoszak = 3 then (HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707)
        when kezdoidoszak = 4 then (HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708)
        when kezdoidoszak = 5 then (HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709)
        when kezdoidoszak = 6 then (HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710)
        when kezdoidoszak = 7 then (HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711)       
        when kezdoidoszak = 8 then (HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712)
        when kezdoidoszak = 9 then (HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801)
        when kezdoidoszak = 10 then (HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802)
        when kezdoidoszak = 11 then (HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803)       
        when kezdoidoszak = 12 then (HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804)
        when kezdoidoszak = 13 then (HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805)
        when kezdoidoszak = 14 then (HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806)
        when kezdoidoszak = 15 then (HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807)
        when kezdoidoszak = 16 then (HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808)
        when kezdoidoszak = 17 then (HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809)
        when kezdoidoszak = 18 then (HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810)
        when kezdoidoszak = 19 then (HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811)
        when kezdoidoszak = 20 then (HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811+HO_201812)
    end)
where
    Kateg = 'J45SYMB'  
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
;
commit;
----------J45SYMB end--------------
----------J45BUF--------------
--2016.06-2018.12
insert into
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
select
    ROW_NUMBER() over(order by TAJ) SORSZ
    ,TAJ
    ,BRAND
from
    (select distinct
        TAJ
        ,BRAND
    from
        RFLOW.RF_S248_E_201809_8_0_TMP2
    where
        (uj_Bufomix > 0)
        and (DATUM between to_date('2016/06/01','yyyy/mm/dd') and to_date('2017/01/31','yyyy/mm/dd'))
        and (BNO = 'J45')
        and BRAND = 'Bufomix Easyhaler'
    ) alap
order by
    TAJ
    ,BRAND
;
commit;

BEGIN
  RFLOW.RF_S248_8_ALAP('J45BUF');
  commit;
END;

--60 napos grace
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 123.9999
where
    (HO_201810 > 0 or HO_201811 > 0) and HO_201812 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 123.9999
where
    (HO_201809 > 0 or HO_201810 > 0) and HO_201811 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 123.9999
where
    (HO_201808 > 0 or HO_201809 > 0) and HO_201810 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 123.9999
where
    (HO_201807 > 0 or HO_201808 > 0) and HO_201809 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 123.9999
where
    (HO_201806 > 0 or HO_201807 > 0) and HO_201808 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 123.9999
where
    (HO_201805 > 0 or HO_201806 > 0) and HO_201807 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 123.9999
where
    (HO_201804 > 0 or HO_201805 > 0)and HO_201806 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 123.9999
where
    (HO_201803 > 0 or HO_201804 > 0) and HO_201805 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 123.9999
where
    (HO_201802 > 0 or HO_201803 > 0) and HO_201804 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 123.9999
where
    (HO_201801 > 0 or HO_201802 > 0) and HO_201803 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 123.9999
where
    (HO_201712 > 0 or HO_201801 > 0) and HO_201802 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 123.9999
where
    (HO_201711 > 0 or HO_201712 > 0) and HO_201801 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 123.9999
where
    (HO_201710 > 0 or HO_201711 > 0) and HO_201712 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 123.9999
where
    (HO_201709 > 0 or HO_201710 > 0) and HO_201711 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 123.9999
where
    (HO_201708 > 0 or HO_201709 > 0) and HO_201710 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 123.9999
where
    (HO_201707 > 0 or HO_201708 > 0) and HO_201709 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 123.9999
where
    (HO_201706 > 0 or HO_201707 > 0) and HO_201708 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 123.9999
where
    (HO_201705 > 0 or HO_201706 > 0) and HO_201707 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 123.9999
where
    (HO_201704 > 0 or HO_201705 > 0)and HO_201706 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 123.9999
where
    (HO_201703 > 0 or HO_201704 > 0) and HO_201705 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 123.9999
where
    (HO_201702 > 0 or HO_201703 > 0) and HO_201704 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 123.9999
where
    (HO_201701 > 0 or HO_201702 > 0) and HO_201703 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 123.9999
where
    (HO_201612 > 0 or HO_201701 > 0) and HO_201702 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 123.9999
where
    (HO_201611 > 0 or HO_201612 > 0) and HO_201701 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 123.9999
where
    (HO_201610 > 0 or HO_201611 > 0) and HO_201612 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 123.9999
where
    (HO_201609 > 0 or HO_201610 > 0) and HO_201611 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 123.9999
where
    (HO_201608 > 0 or HO_201609 > 0) and HO_201610 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 123.9999
where
    (HO_201607 > 0 or HO_201608 > 0) and HO_201609 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 123.9999
where
    (HO_201606 > 0 or HO_201607 > 0) and HO_201608 = 0
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 123.9999
where
    HO_201606 > 0 and HO_201607 = 0
    and Kateg = 'J45BUF'
;
commit;
--grace end

--perzisztencia
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    mintazat = (case when HO_201606 = 0 then '0' else '1' end)
    ||(case when HO_201607 = 0 then '0' else '1' end)
    ||(case when HO_201608 = 0 then '0' else '1' end)
    ||(case when HO_201609 = 0 then '0' else '1' end)
    ||(case when HO_201610 = 0 then '0' else '1' end)
    ||(case when HO_201611 = 0 then '0' else '1' end)
    ||(case when HO_201612 = 0 then '0' else '1' end)
    ||(case when HO_201701 = 0 then '0' else '1' end)
    ||(case when HO_201702 = 0 then '0' else '1' end)
    ||(case when HO_201703 = 0 then '0' else '1' end)
    ||(case when HO_201704 = 0 then '0' else '1' end)
    ||(case when HO_201705 = 0 then '0' else '1' end)
    ||(case when HO_201706 = 0 then '0' else '1' end) 
    ||(case when HO_201707 = 0 then '0' else '1' end)
    ||(case when HO_201708 = 0 then '0' else '1' end)
    ||(case when HO_201709 = 0 then '0' else '1' end)
    ||(case when HO_201710 = 0 then '0' else '1' end)
    ||(case when HO_201711 = 0 then '0' else '1' end)
    ||(case when HO_201712 = 0 then '0' else '1' end)
    ||(case when HO_201801 = 0 then '0' else '1' end)
    ||(case when HO_201802 = 0 then '0' else '1' end)
    ||(case when HO_201803 = 0 then '0' else '1' end) 
    ||(case when HO_201804 = 0 then '0' else '1' end)
    ||(case when HO_201805 = 0 then '0' else '1' end)
    ||(case when HO_201806 = 0 then '0' else '1' end) 
    ||(case when HO_201807 = 0 then '0' else '1' end)
    ||(case when HO_201808 = 0 then '0' else '1' end)
    ||(case when HO_201809 = 0 then '0' else '1' end)
    ||(case when HO_201810 = 0 then '0' else '1' end)
    ||(case when HO_201811 = 0 then '0' else '1' end)
    ||(case when HO_201812 = 0 then '0' else '1' end)
where
    Kateg = 'J45BUF'
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_PRE
where
    mintazat not like '%111111111111%'
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    kezdoidoszak = instr(mintazat,'111111111111',1)
where
    Kateg = 'J45BUF'
;
commit;
--perzisztencia end

--menny ertek takarit
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 0
where
    HO_201812 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 0
where
    HO_201811 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 0
where
    HO_201810 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 0
where
    HO_201809 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 0
where
    HO_201808 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 0
where
    HO_201807 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 0
where
    HO_201806 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 0
where
    HO_201805 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 0
where
    HO_201804 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 0
where
    HO_201803 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 0
where
    HO_201802 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 0
where
    HO_201801 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 0
where
    HO_201712 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 0
where
    HO_201711 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 0
where
    HO_201710 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 0
where
    HO_201709 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 0
where
    HO_201708 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 0
where
    HO_201707 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 0
where
    HO_201706 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 0
where
    HO_201705 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 0
where
    HO_201704 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 0
where
    HO_201703 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 0
where
    HO_201702 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 0
where
    HO_201701 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 0
where
    HO_201612 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 0
where
    HO_201611 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 0
where
    HO_201610 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 0
where
    HO_201609 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 0
where
    HO_201608 = 123.9999
    and Kateg = 'J45BUF'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 0
where
    HO_201607 = 123.9999
    and Kateg = 'J45BUF'
;
commit;
--menny ertek takarit end

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    MIND = (case
        when kezdoidoszak = 1 then (HO_201606+HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705)
        when kezdoidoszak = 2 then (HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706)
        when kezdoidoszak = 3 then (HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707)
        when kezdoidoszak = 4 then (HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708)
        when kezdoidoszak = 5 then (HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709)
        when kezdoidoszak = 6 then (HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710)
        when kezdoidoszak = 7 then (HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711)       
        when kezdoidoszak = 8 then (HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712)
        when kezdoidoszak = 9 then (HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801)
        when kezdoidoszak = 10 then (HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802)
        when kezdoidoszak = 11 then (HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803)      
        when kezdoidoszak = 12 then (HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804)
        when kezdoidoszak = 13 then (HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805)
        when kezdoidoszak = 14 then (HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806)
        when kezdoidoszak = 15 then (HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807)
        when kezdoidoszak = 16 then (HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808)
        when kezdoidoszak = 17 then (HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809)
        when kezdoidoszak = 18 then (HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810)
        when kezdoidoszak = 19 then (HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811)
        when kezdoidoszak = 20 then (HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811+HO_201812)
    end)
where
    Kateg = 'J45BUF'  
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
;
commit;
----------J45BUF end--------------
----------J45Foster200--------------
--2016.06-2018.12
insert into
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
select
    ROW_NUMBER() over(order by TAJ) SORSZ
    ,TAJ
    ,BRAND
from
    (select distinct
        TAJ
        ,BRAND
    from
        RFLOW.RF_S248_E_201809_8_0_TMP2
    where
        (uj_Foster200 > 0)
        and (DATUM between to_date('2016/06/01','yyyy/mm/dd') and to_date('2017/01/31','yyyy/mm/dd'))
        and (BNO = 'J45')
        and BRAND_SAJAT = 200
    ) alap
order by
    TAJ
    ,BRAND
;
commit;

BEGIN
  RFLOW.RF_S248_8_ALAP('J45Foster200');
  commit;
END;

--60 napos grace
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 123.9999
where
    (HO_201810 > 0 or HO_201811 > 0) and HO_201812 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 123.9999
where
    (HO_201809 > 0 or HO_201810 > 0) and HO_201811 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 123.9999
where
    (HO_201808 > 0 or HO_201809 > 0) and HO_201810 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 123.9999
where
    (HO_201807 > 0 or HO_201808 > 0) and HO_201809 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 123.9999
where
    (HO_201806 > 0 or HO_201807 > 0) and HO_201808 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 123.9999
where
    (HO_201805 > 0 or HO_201806 > 0) and HO_201807 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 123.9999
where
    (HO_201804 > 0 or HO_201805 > 0)and HO_201806 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 123.9999
where
    (HO_201803 > 0 or HO_201804 > 0) and HO_201805 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 123.9999
where
    (HO_201802 > 0 or HO_201803 > 0) and HO_201804 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 123.9999
where
    (HO_201801 > 0 or HO_201802 > 0) and HO_201803 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 123.9999
where
    (HO_201712 > 0 or HO_201801 > 0) and HO_201802 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 123.9999
where
    (HO_201711 > 0 or HO_201712 > 0) and HO_201801 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 123.9999
where
    (HO_201710 > 0 or HO_201711 > 0) and HO_201712 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 123.9999
where
    (HO_201709 > 0 or HO_201710 > 0) and HO_201711 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 123.9999
where
    (HO_201708 > 0 or HO_201709 > 0) and HO_201710 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 123.9999
where
    (HO_201707 > 0 or HO_201708 > 0) and HO_201709 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 123.9999
where
    (HO_201706 > 0 or HO_201707 > 0) and HO_201708 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 123.9999
where
    (HO_201705 > 0 or HO_201706 > 0) and HO_201707 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 123.9999
where
    (HO_201704 > 0 or HO_201705 > 0)and HO_201706 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 123.9999
where
    (HO_201703 > 0 or HO_201704 > 0) and HO_201705 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 123.9999
where
    (HO_201702 > 0 or HO_201703 > 0) and HO_201704 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 123.9999
where
    (HO_201701 > 0 or HO_201702 > 0) and HO_201703 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 123.9999
where
    (HO_201612 > 0 or HO_201701 > 0) and HO_201702 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 123.9999
where
    (HO_201611 > 0 or HO_201612 > 0) and HO_201701 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 123.9999
where
    (HO_201610 > 0 or HO_201611 > 0) and HO_201612 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 123.9999
where
    (HO_201609 > 0 or HO_201610 > 0) and HO_201611 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 123.9999
where
    (HO_201608 > 0 or HO_201609 > 0) and HO_201610 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 123.9999
where
    (HO_201607 > 0 or HO_201608 > 0) and HO_201609 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 123.9999
where
    (HO_201606 > 0 or HO_201607 > 0) and HO_201608 = 0
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 123.9999
where
    HO_201606 > 0 and HO_201607 = 0
    and Kateg = 'J45Foster200'
;
commit;
--grace end

--perzisztencia
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    mintazat = (case when HO_201606 = 0 then '0' else '1' end)
    ||(case when HO_201607 = 0 then '0' else '1' end)
    ||(case when HO_201608 = 0 then '0' else '1' end)
    ||(case when HO_201609 = 0 then '0' else '1' end)
    ||(case when HO_201610 = 0 then '0' else '1' end)
    ||(case when HO_201611 = 0 then '0' else '1' end)
    ||(case when HO_201612 = 0 then '0' else '1' end)
    ||(case when HO_201701 = 0 then '0' else '1' end)
    ||(case when HO_201702 = 0 then '0' else '1' end)
    ||(case when HO_201703 = 0 then '0' else '1' end)
    ||(case when HO_201704 = 0 then '0' else '1' end)
    ||(case when HO_201705 = 0 then '0' else '1' end)
    ||(case when HO_201706 = 0 then '0' else '1' end) 
    ||(case when HO_201707 = 0 then '0' else '1' end)
    ||(case when HO_201708 = 0 then '0' else '1' end)
    ||(case when HO_201709 = 0 then '0' else '1' end)
    ||(case when HO_201710 = 0 then '0' else '1' end)
    ||(case when HO_201711 = 0 then '0' else '1' end)
    ||(case when HO_201712 = 0 then '0' else '1' end)
    ||(case when HO_201801 = 0 then '0' else '1' end)
    ||(case when HO_201802 = 0 then '0' else '1' end)
    ||(case when HO_201803 = 0 then '0' else '1' end) 
    ||(case when HO_201804 = 0 then '0' else '1' end)
    ||(case when HO_201805 = 0 then '0' else '1' end)
    ||(case when HO_201806 = 0 then '0' else '1' end) 
    ||(case when HO_201807 = 0 then '0' else '1' end)
    ||(case when HO_201808 = 0 then '0' else '1' end)
    ||(case when HO_201809 = 0 then '0' else '1' end)
    ||(case when HO_201810 = 0 then '0' else '1' end)
    ||(case when HO_201811 = 0 then '0' else '1' end)
    ||(case when HO_201812 = 0 then '0' else '1' end)
where
    Kateg = 'J45Foster200'
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_PRE
where
    mintazat not like '%111111111111%'
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    kezdoidoszak = instr(mintazat,'111111111111',1)
where
    Kateg = 'J45Foster200'
;
commit;
--perzisztencia end

--menny ertek takarit
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 0
where
    HO_201812 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 0
where
    HO_201811 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 0
where
    HO_201810 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 0
where
    HO_201809 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 0
where
    HO_201808 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 0
where
    HO_201807 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 0
where
    HO_201806 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 0
where
    HO_201805 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 0
where
    HO_201804 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 0
where
    HO_201803 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 0
where
    HO_201802 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 0
where
    HO_201801 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 0
where
    HO_201712 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 0
where
    HO_201711 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 0
where
    HO_201710 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 0
where
    HO_201709 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 0
where
    HO_201708 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 0
where
    HO_201707 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 0
where
    HO_201706 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 0
where
    HO_201705 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 0
where
    HO_201704 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 0
where
    HO_201703 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 0
where
    HO_201702 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 0
where
    HO_201701 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 0
where
    HO_201612 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 0
where
    HO_201611 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 0
where
    HO_201610 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 0
where
    HO_201609 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 0
where
    HO_201608 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 0
where
    HO_201607 = 123.9999
    and Kateg = 'J45Foster200'
;
commit;
--menny ertek takarit end

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    MIND = (case
        when kezdoidoszak = 1 then (HO_201606+HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705)
        when kezdoidoszak = 2 then (HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706)
        when kezdoidoszak = 3 then (HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707)
        when kezdoidoszak = 4 then (HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708)
        when kezdoidoszak = 5 then (HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709)
        when kezdoidoszak = 6 then (HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710)
        when kezdoidoszak = 7 then (HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711)       
        when kezdoidoszak = 8 then (HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712)
        when kezdoidoszak = 9 then (HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801)
        when kezdoidoszak = 10 then (HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802)
        when kezdoidoszak = 11 then (HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803)
        when kezdoidoszak = 12 then (HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804)
        when kezdoidoszak = 13 then (HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805)
        when kezdoidoszak = 14 then (HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806)
        when kezdoidoszak = 15 then (HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807)
        when kezdoidoszak = 16 then (HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808)
        when kezdoidoszak = 17 then (HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809)
        when kezdoidoszak = 18 then (HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810)
        when kezdoidoszak = 19 then (HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811)
        when kezdoidoszak = 20 then (HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811+HO_201812)
    end)
where
    Kateg = 'J45Foster200'  
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
;
commit;
----------J45Foster200 end--------------
----------J45Foster100--------------
--2016.06-2018.12
insert into
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
select
    ROW_NUMBER() over(order by TAJ) SORSZ
    ,TAJ
    ,BRAND
from
    (select distinct
        TAJ
        ,BRAND
    from
        RFLOW.RF_S248_E_201809_8_0_TMP2
    where
        (uj_Foster100 > 0)
        and (DATUM between to_date('2016/06/01','yyyy/mm/dd') and to_date('2017/01/31','yyyy/mm/dd'))
        and (BNO = 'J45')
        and BRAND_SAJAT = 100
    ) alap
order by
    TAJ
    ,BRAND
;
commit;

BEGIN
  RFLOW.RF_S248_8_ALAP('J45Foster100');
  commit;
END;

--90 napos grace
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 123.9999
where
    (HO_201809 > 0 or HO_201810 > 0 or HO_201811 > 0) and HO_201812 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 123.9999
where
    (HO_201808 > 0 or HO_201809 > 0 or HO_201810 > 0) and HO_201811 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 123.9999
where
    (HO_201807 > 0 or HO_201808 > 0 or HO_201809 > 0) and HO_201810 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 123.9999
where
    (HO_201806 > 0 or HO_201807 > 0 or HO_201808 > 0) and HO_201809 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 123.9999
where
    (HO_201805 > 0 or HO_201806 > 0 or HO_201807 > 0) and HO_201808 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 123.9999
where
    (HO_201804 > 0 or HO_201805 > 0 or HO_201806 > 0) and HO_201807 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 123.9999
where
    (HO_201803 > 0 or HO_201804 > 0 or HO_201805 > 0)and HO_201806 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 123.9999
where
    (HO_201802 > 0 or HO_201803 > 0 or HO_201804 > 0) and HO_201805 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 123.9999
where
    (HO_201801 > 0 or HO_201802 > 0 or HO_201803 > 0) and HO_201804 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 123.9999
where
    (HO_201712 > 0 or HO_201801 > 0 or HO_201802 > 0) and HO_201803 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 123.9999
where
    (HO_201711 > 0 or HO_201712 > 0 or HO_201801 > 0) and HO_201802 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 123.9999
where
    (HO_201710 > 0 or HO_201711 > 0 or HO_201712 > 0) and HO_201801 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 123.9999
where
    (HO_201709 > 0 or HO_201710 > 0 or HO_201711 > 0) and HO_201712 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 123.9999
where
    (HO_201708 > 0 or HO_201709 > 0 or HO_201710 > 0) and HO_201711 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 123.9999
where
    (HO_201707 > 0 or HO_201708 > 0 or HO_201709 > 0) and HO_201710 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 123.9999
where
    (HO_201706 > 0 or HO_201707 > 0 or HO_201708 > 0) and HO_201709 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 123.9999
where
    (HO_201705 > 0 or HO_201706 > 0 or HO_201707 > 0) and HO_201708 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 123.9999
where
    (HO_201704 > 0 or HO_201705 > 0 or HO_201706 > 0) and HO_201707 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 123.9999
where
    (HO_201703 > 0 or HO_201704 > 0 or HO_201705 > 0)and HO_201706 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 123.9999
where
    (HO_201702 > 0 or HO_201703 > 0 or HO_201704 > 0) and HO_201705 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 123.9999
where
    (HO_201701 > 0 or HO_201702 > 0 or HO_201703 > 0) and HO_201704 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 123.9999
where
    (HO_201612 > 0 or HO_201701 > 0 or HO_201702 > 0) and HO_201703 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 123.9999
where
    (HO_201611 > 0 or HO_201612 > 0 or HO_201701 > 0) and HO_201702 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 123.9999
where
    (HO_201610 > 0 or HO_201611 > 0 or HO_201612 > 0) and HO_201701 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 123.9999
where
    (HO_201609 > 0 or HO_201610 > 0 or HO_201611 > 0) and HO_201612 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 123.9999
where
    (HO_201608 > 0 or HO_201609 > 0 or HO_201610 > 0) and HO_201611 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 123.9999
where
    (HO_201607 > 0 or HO_201608 > 0 or HO_201609 > 0) and HO_201610 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 123.9999
where
    (HO_201606 > 0 or HO_201607 > 0 or HO_201608 > 0) and HO_201609 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 123.9999
where
    (HO_201606 > 0 or HO_201607 > 0) and HO_201608 = 0
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 123.9999
where
    HO_201606 > 0 and HO_201607 = 0
    and Kateg = 'J45Foster100'
;
commit;
--grace end

--perzisztencia
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    mintazat = (case when HO_201606 = 0 then '0' else '1' end)
    ||(case when HO_201607 = 0 then '0' else '1' end)
    ||(case when HO_201608 = 0 then '0' else '1' end)
    ||(case when HO_201609 = 0 then '0' else '1' end)
    ||(case when HO_201610 = 0 then '0' else '1' end)
    ||(case when HO_201611 = 0 then '0' else '1' end)
    ||(case when HO_201612 = 0 then '0' else '1' end)
    ||(case when HO_201701 = 0 then '0' else '1' end)
    ||(case when HO_201702 = 0 then '0' else '1' end)
    ||(case when HO_201703 = 0 then '0' else '1' end)
    ||(case when HO_201704 = 0 then '0' else '1' end)
    ||(case when HO_201705 = 0 then '0' else '1' end)
    ||(case when HO_201706 = 0 then '0' else '1' end) 
    ||(case when HO_201707 = 0 then '0' else '1' end)
    ||(case when HO_201708 = 0 then '0' else '1' end)
    ||(case when HO_201709 = 0 then '0' else '1' end)
    ||(case when HO_201710 = 0 then '0' else '1' end)
    ||(case when HO_201711 = 0 then '0' else '1' end)
    ||(case when HO_201712 = 0 then '0' else '1' end)
    ||(case when HO_201801 = 0 then '0' else '1' end)
    ||(case when HO_201802 = 0 then '0' else '1' end)
    ||(case when HO_201803 = 0 then '0' else '1' end)  
    ||(case when HO_201804 = 0 then '0' else '1' end)
    ||(case when HO_201805 = 0 then '0' else '1' end)
    ||(case when HO_201806 = 0 then '0' else '1' end) 
    ||(case when HO_201807 = 0 then '0' else '1' end)
    ||(case when HO_201808 = 0 then '0' else '1' end)
    ||(case when HO_201809 = 0 then '0' else '1' end)
    ||(case when HO_201810 = 0 then '0' else '1' end)
    ||(case when HO_201811 = 0 then '0' else '1' end)
    ||(case when HO_201812 = 0 then '0' else '1' end)
where
    Kateg = 'J45Foster100'
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_PRE
where
    mintazat not like '%111111111111%'
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    kezdoidoszak = instr(mintazat,'111111111111',1)
where
    Kateg = 'J45Foster100'
;
commit;
--perzisztencia end

--menny ertek takarit
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 0
where
    HO_201812 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 0
where
    HO_201811 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 0
where
    HO_201810 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 0
where
    HO_201809 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 0
where
    HO_201808 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 0
where
    HO_201807 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 0
where
    HO_201806 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 0
where
    HO_201805 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 0
where
    HO_201804 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 0
where
    HO_201803 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 0
where
    HO_201802 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 0
where
    HO_201801 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 0
where
    HO_201712 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 0
where
    HO_201711 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 0
where
    HO_201710 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 0
where
    HO_201709 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 0
where
    HO_201708 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 0
where
    HO_201707 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 0
where
    HO_201706 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 0
where
    HO_201705 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 0
where
    HO_201704 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 0
where
    HO_201703 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 0
where
    HO_201702 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 0
where
    HO_201701 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 0
where
    HO_201612 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 0
where
    HO_201611 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 0
where
    HO_201610 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 0
where
    HO_201609 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 0
where
    HO_201608 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 0
where
    HO_201607 = 123.9999
    and Kateg = 'J45Foster100'
;
commit;
--menny ertek takarit end

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    MIND = (case
        when kezdoidoszak = 1 then (HO_201606+HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705)
        when kezdoidoszak = 2 then (HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706)
        when kezdoidoszak = 3 then (HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707)
        when kezdoidoszak = 4 then (HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708)
        when kezdoidoszak = 5 then (HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709)
        when kezdoidoszak = 6 then (HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710)
        when kezdoidoszak = 7 then (HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711)       
        when kezdoidoszak = 8 then (HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712)
        when kezdoidoszak = 9 then (HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801)
        when kezdoidoszak = 10 then (HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802)
        when kezdoidoszak = 11 then (HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803)
        when kezdoidoszak = 12 then (HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804)
        when kezdoidoszak = 13 then (HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805)
        when kezdoidoszak = 14 then (HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806)
        when kezdoidoszak = 15 then (HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807)
        when kezdoidoszak = 16 then (HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808)
        when kezdoidoszak = 17 then (HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809)
        when kezdoidoszak = 18 then (HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810)
        when kezdoidoszak = 19 then (HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811)
        when kezdoidoszak = 20 then (HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811+HO_201812)
    end)
where
    Kateg = 'J45Foster100'  
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
;
commit;
----------J45Foster100 end--------------
----------J45Foster20045--------------
--2016.06-2018.12
insert into
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
select
    ROW_NUMBER() over(order by TAJ) SORSZ
    ,TAJ
    ,BRAND
from
    (select distinct
        TAJ
        ,BRAND
    from
        RFLOW.RF_S248_E_201809_8_0_TMP2
    where
        (uj_Foster200 > 0)
        and (DATUM between to_date('2016/06/01','yyyy/mm/dd') and to_date('2017/03/31','yyyy/mm/dd'))
        and (BNO = 'J45')
        and BRAND_SAJAT = 200
    ) alap
order by
    TAJ
    ,BRAND
;
commit;

BEGIN
  RFLOW.RF_S248_8_ALAP('J45Foster20045');
  commit;
END;

--45 napos grace
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 123.9999
where
    (HO_201810 > 0 or HO_201811 > 0) and HO_201812 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 123.9999
where
    (HO_201809 > 0 or HO_201810 > 0) and HO_201811 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 123.9999
where
    (HO_201808 > 0 or HO_201809 > 0) and HO_201810 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 123.9999
where
    (HO_201807 > 0 or HO_201808 > 0) and HO_201809 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 123.9999
where
    (HO_201806 > 0 or HO_201807 > 0) and HO_201808 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 123.9999
where
    (HO_201805 > 0 or HO_201806 > 0) and HO_201807 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 123.9999
where
    (HO_201804 > 0 or HO_201805 > 0)and HO_201806 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 123.9999
where
    (HO_201803 > 0 or HO_201804 > 0) and HO_201805 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 123.9999
where
    (HO_201802 > 0 or HO_201803 > 0) and HO_201804 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 123.9999
where
    (HO_201801 > 0 or HO_201802 > 0) and HO_201803 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 123.9999
where
    (HO_201712 > 0 or HO_201801 > 0) and HO_201802 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 123.9999
where
    (HO_201711 > 0 or HO_201712 > 0) and HO_201801 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 123.9999
where
    (HO_201710 > 0 or HO_201711 > 0) and HO_201712 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 123.9999
where
    (HO_201709 > 0 or HO_201710 > 0) and HO_201711 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 123.9999
where
    (HO_201708 > 0 or HO_201709 > 0) and HO_201710 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 123.9999
where
    (HO_201707 > 0 or HO_201708 > 0) and HO_201709 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 123.9999
where
    (HO_201706 > 0 or HO_201707 > 0) and HO_201708 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 123.9999
where
    (HO_201705 > 0 or HO_201706 > 0) and HO_201707 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 123.9999
where
    (HO_201704 > 0 or HO_201705 > 0)and HO_201706 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 123.9999
where
    (HO_201703 > 0 or HO_201704 > 0) and HO_201705 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 123.9999
where
    (HO_201702 > 0 or HO_201703 > 0) and HO_201704 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 123.9999
where
    (HO_201701 > 0 or HO_201702 > 0) and HO_201703 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 123.9999
where
    (HO_201612 > 0 or HO_201701 > 0) and HO_201702 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 123.9999
where
    (HO_201611 > 0 or HO_201612 > 0) and HO_201701 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 123.9999
where
    (HO_201610 > 0 or HO_201611 > 0) and HO_201612 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 123.9999
where
    (HO_201609 > 0 or HO_201610 > 0) and HO_201611 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 123.9999
where
    (HO_201608 > 0 or HO_201609 > 0) and HO_201610 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 123.9999
where
    (HO_201607 > 0 or HO_201608 > 0) and HO_201609 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 123.9999
where
    (HO_201606 > 0 or HO_201607 > 0) and HO_201608 = 0
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 123.9999
where
    HO_201606 > 0 and HO_201607 = 0
    and Kateg = 'J45Foster20045'
;
commit;
--grace end

--perzisztencia
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    mintazat = (case when HO_201606 = 0 then '0' else '1' end)
    ||(case when HO_201607 = 0 then '0' else '1' end)
    ||(case when HO_201608 = 0 then '0' else '1' end)
    ||(case when HO_201609 = 0 then '0' else '1' end)
    ||(case when HO_201610 = 0 then '0' else '1' end)
    ||(case when HO_201611 = 0 then '0' else '1' end)
    ||(case when HO_201612 = 0 then '0' else '1' end)
    ||(case when HO_201701 = 0 then '0' else '1' end)
    ||(case when HO_201702 = 0 then '0' else '1' end)
    ||(case when HO_201703 = 0 then '0' else '1' end)
    ||(case when HO_201704 = 0 then '0' else '1' end)
    ||(case when HO_201705 = 0 then '0' else '1' end)
    ||(case when HO_201706 = 0 then '0' else '1' end) 
    ||(case when HO_201707 = 0 then '0' else '1' end)
    ||(case when HO_201708 = 0 then '0' else '1' end)
    ||(case when HO_201709 = 0 then '0' else '1' end)
    ||(case when HO_201710 = 0 then '0' else '1' end)
    ||(case when HO_201711 = 0 then '0' else '1' end)
    ||(case when HO_201712 = 0 then '0' else '1' end)
    ||(case when HO_201801 = 0 then '0' else '1' end)
    ||(case when HO_201802 = 0 then '0' else '1' end)
    ||(case when HO_201803 = 0 then '0' else '1' end)  
    ||(case when HO_201804 = 0 then '0' else '1' end)
    ||(case when HO_201805 = 0 then '0' else '1' end)
    ||(case when HO_201806 = 0 then '0' else '1' end) 
    ||(case when HO_201807 = 0 then '0' else '1' end)
    ||(case when HO_201808 = 0 then '0' else '1' end)
    ||(case when HO_201809 = 0 then '0' else '1' end)
    ||(case when HO_201810 = 0 then '0' else '1' end)
    ||(case when HO_201811 = 0 then '0' else '1' end)
    ||(case when HO_201812 = 0 then '0' else '1' end)
where
    Kateg = 'J45Foster20045'
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_PRE
where
    mintazat not like '%111111111111%'
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    kezdoidoszak = instr(mintazat,'111111111111',1)
where
    Kateg = 'J45Foster20045'
;
commit;
--perzisztencia end

--menny ertek takarit
update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201812 = 0
where
    HO_201812 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201811 = 0
where
    HO_201811 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201810 = 0
where
    HO_201810 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201809 = 0
where
    HO_201809 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201808 = 0
where
    HO_201808 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201807 = 0
where
    HO_201807 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201806 = 0
where
    HO_201806 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201805 = 0
where
    HO_201805 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201804 = 0
where
    HO_201804 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201803 = 0
where
    HO_201803 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201802 = 0
where
    HO_201802 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201801 = 0
where
    HO_201801 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201712 = 0
where
    HO_201712 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201711 = 0
where
    HO_201711 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201710 = 0
where
    HO_201710 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201709 = 0
where
    HO_201709 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201708 = 0
where
    HO_201708 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201707 = 0
where
    HO_201707 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201706 = 0
where
    HO_201706 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201705 = 0
where
    HO_201705 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201704 = 0
where
    HO_201704 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201703 = 0
where
    HO_201703 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201702 = 0
where
    HO_201702 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201701 = 0
where
    HO_201701 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201612 = 0
where
    HO_201612 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201611 = 0
where
    HO_201611 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201610 = 0
where
    HO_201610 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201609 = 0
where
    HO_201609 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201608 = 0
where
    HO_201608 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    HO_201607 = 0
where
    HO_201607 = 123.9999
    and Kateg = 'J45Foster20045'
;
commit;
--menny ertek takarit end

update
    RFLOW.RF_S248_E_201809_8_TMP_PRE
set
    MIND = (case
        when kezdoidoszak = 1 then (HO_201606+HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705)
        when kezdoidoszak = 2 then (HO_201607+HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706)
        when kezdoidoszak = 3 then (HO_201608+HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707)
        when kezdoidoszak = 4 then (HO_201609+HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708)
        when kezdoidoszak = 5 then (HO_201610+HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709)
        when kezdoidoszak = 6 then (HO_201611+HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710)
        when kezdoidoszak = 7 then (HO_201612+HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711)       
        when kezdoidoszak = 8 then (HO_201701+HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712)
        when kezdoidoszak = 9 then (HO_201702+HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801)
        when kezdoidoszak = 10 then (HO_201703+HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802)
        when kezdoidoszak = 11 then (HO_201704+HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803)
        when kezdoidoszak = 12 then (HO_201705+HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804)
        when kezdoidoszak = 13 then (HO_201706+HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805)
        when kezdoidoszak = 14 then (HO_201707+HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806)
        when kezdoidoszak = 15 then (HO_201708+HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807)
        when kezdoidoszak = 16 then (HO_201709+HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808)
        when kezdoidoszak = 17 then (HO_201710+HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809)
        when kezdoidoszak = 18 then (HO_201711+HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810)
        when kezdoidoszak = 19 then (HO_201712+HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811)
        when kezdoidoszak = 20 then (HO_201801+HO_201802+HO_201803+HO_201804+HO_201805+HO_201806+HO_201807+HO_201808+HO_201809+HO_201810+HO_201811+HO_201812)
    end)
where
    Kateg = 'J45Foster20045'  
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_8_TMP_TAJ
;
commit;
----------J45Foster20045 end--------------

--Finish
delete
from
    RFLOW.RF_S248_E_201809_8_TMP_PRE
where
    MIND < 1
;
commit;

create table RFLOW.RF_S248_E_201809_8_0 as
select
    Kateg
    ,BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when doboz < 10 then 0 else doboz end) doboz
from
    (select
        Kateg
        ,BRAND
        ,count(distinct TAJ) beteg
        ,sum(MIND) doboz
    from
        RFLOW.RF_S248_E_201809_8_TMP_PRE
    group by
        Kateg
        ,BRAND
    ) alap
order by
    Kateg
    ,BRAND
;

delete
from
    RFLOW.RF_S248_E_201809_8_0
where
    (beteg + doboz) = 0
;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP PROCEDURE RFLOW.RF_S248_8_ALAP';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
----------Feldolgozas end--------------

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_TMP_PRE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_TMP_TAJ';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_8_0_TMP2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;