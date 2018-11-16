BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMP1';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPA';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPB';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPC';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPD';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMP2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_DOBOZ';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;


create table RFLOW.RF_S248_E_201809_1_0_TMP1 as
SELECT distinct
    (to_char(DATUM,'YYYY')||'EV') EV
    ,(to_char(DATUM,'YYYY')|| (case when
        extract(month from DATUM) < 4
    then
        'N1'
    else
        (case when (extract(month from DATUM) between 4 and 6)
        then
            'N2'
        else
            (case when (extract(month from DATUM) between 7 and 9)
            then
                'N3'
            else
                'N4'
            end)
        end)
    end)
    ) NEGYEDEV
    ,to_char(DATUM,'YYYYMM') IDOSZAK
    ,x.TAJ
    ,x.MEGYE
    ,floor((x.DATUM - dem.SZULETES_DATUM) / 365.242199) ELETKOR
    ,(case
        when substr(BNOKOD,1,3) = 'J44' then 'J44'
        when substr(BNOKOD,1,3) = 'J45' then 'J45'
    else
        'Egyéb'
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
    ,x.TTT
    ,hato.NEV
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
    RFLOW.RF_S248_E_201809_1_0_TMP1
SELECT distinct
    (to_char(DATUM,'YYYY')||'EV') EV
    ,(to_char(DATUM,'YYYY')|| (case when
        extract(month from DATUM) < 4
    then
        'N1'
    else
        (case when (extract(month from DATUM) between 4 and 6)
        then
            'N2'
        else
            (case when (extract(month from DATUM) between 7 and 9)
            then
                'N3'
            else
                'N4'
            end)
        end)
    end)
    ) NEGYEDEV
    ,to_char(DATUM,'YYYYMM') IDOSZAK
    ,x.TAJO TAJ
    ,'XX' MEGYE
    ,floor((x.DATUM - dem.SZULETES_DATUM) / 365.242199) ELETKOR
    ,(case
        when substr(BNOKOD,1,3) = 'J44' then 'J44'
        when substr(BNOKOD,1,3) = 'J45' then 'J45'
    else
        'Egyéb'
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
    ,x.TTT
    ,hato.NEV
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

----------------------------------------
insert into
    RFLOW.RF_S248_E_201809_1_0_TMP1
SELECT distinct
    (to_char(DATUM,'YYYY')||'EV') EV
    ,(to_char(DATUM,'YYYY')|| (case when
        extract(month from DATUM) < 4
    then
        'N1'
    else
        (case when (extract(month from DATUM) between 4 and 6)
        then
            'N2'
        else
            (case when (extract(month from DATUM) between 7 and 9)
            then
                'N3'
            else
                'N4'
            end)
        end)
    end)
    ) NEGYEDEV
    ,to_char(DATUM,'YYYYMM') IDOSZAK
    ,x.TAJ
    ,x.MEGYE
    ,floor((x.DATUM - dem.SZULETES_DATUM) / 365.242199) ELETKOR
    ,(case
        when substr(BNOKOD,1,3) = 'J44' then 'J44'
        when substr(BNOKOD,1,3) = 'J45' then 'J45'
    else
        'Egyéb'
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
    ,x.TTT
    ,hato.NEV
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
----------------------------------------
    
create index RF_S248_E_201809_1_0_TMP1_TAJ on RFLOW.RF_S248_E_201809_1_0_TMP1(TAJ);
create index RF_S248_E_201809_1_0_TMP1_KOR on RFLOW.RF_S248_E_201809_1_0_TMP1(ELETKOR);
create index RF_S248_E_201809_1_0_TMP1_BNO on RFLOW.RF_S248_E_201809_1_0_TMP1(BNO);
create index RF_S248_E_201809_1_0_TMP1_TCS on RFLOW.RF_S248_E_201809_1_0_TMP1(TCS);
create index RF_S248_E_201809_1_0_TMP1_DAT on RFLOW.RF_S248_E_201809_1_0_TMP1(DATUM);
create index RF_S248_E_201809_1_0_TMP1_M on RFLOW.RF_S248_E_201809_1_0_TMP1(MEGYE);

create table RFLOW.RF_S248_E_201809_1_0_TMP2 as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.MEGYE
    ,alap.TCS
    ,alap.eletkor
    ,0 UJ6
    ,0 ELHAGY
    ,0 UJ12_MOD1
    ,0 UJ12_MOD2
from
    RFLOW.RF_S248_E_201809_1_0_TMP1 alap
;

create index RF_S248_E_201809_1_0_TMP2_X on RFLOW.RF_S248_E_201809_1_0_TMP2(TAJ,TCS,BNO,DATUM,MEGYE,eletkor);
create index RF_S248_E_201809_1_0_TMP2_TAJ on RFLOW.RF_S248_E_201809_1_0_TMP2(TAJ);
create index RF_S248_E_201809_1_0_TMP2_M on RFLOW.RF_S248_E_201809_1_0_TMP2(MEGYE);
create index RF_S248_E_201809_1_0_TMP2_KOR on RFLOW.RF_S248_E_201809_1_0_TMP2(ELETKOR);
create index RF_S248_E_201809_1_0_TMP2_BNO on RFLOW.RF_S248_E_201809_1_0_TMP2(BNO);
create index RF_S248_E_201809_1_0_TMP2_TCS on RFLOW.RF_S248_E_201809_1_0_TMP2(TCS);
create index RF_S248_E_201809_1_0_TMP2_DAT on RFLOW.RF_S248_E_201809_1_0_TMP2(DATUM);

--Alapok
create table RFLOW.RF_S248_E_201809_1_0_TMPA as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.MEGYE
    ,alap.TCS
    ,alap.eletkor
    ,(case when (ujbeteg6.TAJ is NULL) then 1 else 0 end) uj6
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    left outer join RFLOW.RF_S248_E_201809_1_0_TMP2 ujbeteg6 on
        alap.TAJ = ujbeteg6.TAJ
        and alap.TCS = ujbeteg6.TCS
        and alap.BNO = ujbeteg6.BNO
        and (ujbeteg6.datum between (alap.DATUM-180) and (alap.datum-1))        
;

create index RF_S248_E_201809_1_0_TMPA_X on RFLOW.RF_S248_E_201809_1_0_TMPA(TAJ,TCS,BNO,DATUM,MEGYE,eletkor);

merge into
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
using
    (select * from RFLOW.RF_S248_E_201809_1_0_TMPA) tmp on (alap.TAJ = tmp.TAJ and alap.TCS = tmp.TCS and alap.BNO = tmp.BNO and alap.DATUM = tmp.DATUM and alap.MEGYE = tmp.MEGYE and alap.eletkor = tmp.eletkor)
when matched then
update
    set alap.UJ6 = tmp.uj6;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPA PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

create table RFLOW.RF_S248_E_201809_1_0_TMPB as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.MEGYE
    ,alap.TCS
    ,alap.eletkor
    ,(case when (elhagy.TAJ is NULL) then 1 else 0 end) elhagy
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    left outer join RFLOW.RF_S248_E_201809_1_0_TMP2 elhagy on
        (elhagy.TCS <> 'SABA')
        and alap.TAJ = elhagy.TAJ
        and alap.BNO = elhagy.BNO
        and (elhagy.datum between (alap.DATUM+1) and add_months(alap.datum,6))
;

create index RF_S248_E_201809_1_0_TMPB_X on RFLOW.RF_S248_E_201809_1_0_TMPB(TAJ,TCS,BNO,DATUM,MEGYE,eletkor);

merge into
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
using
    (select * from RFLOW.RF_S248_E_201809_1_0_TMPB) tmp on (alap.TAJ = tmp.TAJ and alap.TCS = tmp.TCS and alap.BNO = tmp.BNO and alap.DATUM = tmp.DATUM and alap.MEGYE = tmp.MEGYE and alap.eletkor = tmp.eletkor)
when matched then
update
    set alap.ELHAGY = tmp.elhagy;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPB PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

create table RFLOW.RF_S248_E_201809_1_0_TMPC as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.MEGYE
    ,alap.TCS
    ,alap.eletkor
    ,(case when (ujbeteg12_mod1.TAJ is NULL) then 1 else 0 end) uj12m1
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    left outer join RFLOW.RF_S248_E_201809_1_0_TMP2 ujbeteg12_mod1 on
        alap.TAJ = ujbeteg12_mod1.TAJ
        and alap.TCS = ujbeteg12_mod1.TCS
        and alap.BNO = ujbeteg12_mod1.BNO
        and (ujbeteg12_mod1.datum between (alap.DATUM-365) and (alap.datum-1))
;

create index RF_S248_E_201809_1_0_TMPC_X on RFLOW.RF_S248_E_201809_1_0_TMPC(TAJ,TCS,BNO,DATUM,MEGYE,eletkor);

merge into
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
using
    (select * from RFLOW.RF_S248_E_201809_1_0_TMPC) tmp on (alap.TAJ = tmp.TAJ and alap.TCS = tmp.TCS and alap.BNO = tmp.BNO and alap.DATUM = tmp.DATUM and alap.MEGYE = tmp.MEGYE and alap.eletkor = tmp.eletkor)
when matched then
update
    set alap.UJ12_MOD1 = tmp.uj12m1;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPC PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

create table RFLOW.RF_S248_E_201809_1_0_TMPD as
select distinct
    alap.BNO
    ,alap.DATUM
    ,alap.TAJ
    ,alap.MEGYE
    ,alap.TCS
    ,alap.eletkor
    ,(case when (ujbeteg12_mod2.TAJ is NULL) then 1 else 0 end) uj12m2
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    left outer join RFLOW.RF_S248_E_201809_1_0_TMP2 ujbeteg12_mod2 on
        (ujbeteg12_mod2.TCS <> 'SABA')
        and  alap.TAJ = ujbeteg12_mod2.TAJ
        and alap.BNO = ujbeteg12_mod2.BNO
        and (ujbeteg12_mod2.datum between (alap.DATUM-180) and (alap.datum-1))
;

create index RF_S248_E_201809_1_0_TMPD_X on RFLOW.RF_S248_E_201809_1_0_TMPD(TAJ,TCS,BNO,DATUM,MEGYE,eletkor);

merge into
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
using
    (select * from RFLOW.RF_S248_E_201809_1_0_TMPD) tmp on (alap.TAJ = tmp.TAJ and alap.TCS = tmp.TCS and alap.BNO = tmp.BNO and alap.DATUM = tmp.DATUM and alap.MEGYE = tmp.MEGYE and alap.eletkor = tmp.eletkor)
when matched then
update
    set alap.UJ12_MOD2 = tmp.uj12m2;
commit; 

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPD PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

create table RFLOW.RF_S248_E_201809_1_0_DOBOZ as
select
    alap.TAJ
    ,alap.DATUM
    ,veny12.TTT
    ,nvl(count(distinct veny12.eset),0) DOBOZ
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny12 on (alap.TAJ = veny12.TAJ) and (veny12.DATUM between alap.DATUM and (alap.DATUM+365)) and (alap.uj6 = 1)
group by
    alap.TAJ
    ,alap.DATUM
    ,veny12.TTT
;

create index RF_S248_E_201809_1_0_DOBOZ_X on RFLOW.RF_S248_E_201809_1_0_DOBOZ(TAJ,DATUM,TTT);

---Feldolgozás
create table RFLOW.RF_S248_E_201809_1_0 as
select
    'Országos' TER_TIP
    ,'Mind' MEGYE
    ,cast('Összesen' as varchar2(50)) MEGYE_NEV
    ,alap.BNO
    ,cast('Havi' as varchar2(10)) IDO_TIP
    ,veny.IDOSZAK
    ,cast('Összes' as varchar2(20)) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p  
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho  
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2 
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
     alap.BNO
    ,veny.IDOSZAK
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    BNO
    ,IDOSZAK
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;

insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Országos' TER_TIP
    ,'Mind' MEGYE
    ,cast('Összesen' as varchar2(50)) MEGYE_NEV
    ,alap.BNO
    ,cast('Negyedéves' as varchar2(10)) IDO_TIP
    ,veny.NEGYEDEV IDOSZAK
    ,cast('Összes' as varchar2(20)) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
     alap.BNO
    ,veny.NEGYEDEV
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    BNO
    ,IDOSZAK
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Országos' TER_TIP
    ,'Mind' MEGYE
    ,cast('Összesen' as varchar2(50)) MEGYE_NEV
    ,alap.BNO
    ,cast('Éves' as varchar2(10)) IDO_TIP
    ,veny.EV IDOSZAK
    ,cast('Összes' as varchar2(20)) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
     alap.BNO
    ,veny.EV
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    BNO
    ,IDOSZAK
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

--Életkorcsop
insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Országos' TER_TIP
    ,'Mind' MEGYE
    ,cast('Összesen' as varchar2(50)) MEGYE_NEV
    ,alap.BNO
    ,cast('Havi' as varchar2(10)) IDO_TIP
    ,veny.IDOSZAK
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
     alap.BNO
    ,veny.IDOSZAK
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end)
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    BNO
    ,IDOSZAK
    ,KORCSOPORT
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Országos' TER_TIP
    ,'Mind' MEGYE
    ,cast('Összesen' as varchar2(50)) MEGYE_NEV
    ,alap.BNO
    ,cast('Negyedéves' as varchar2(10)) IDO_TIP
    ,veny.NEGYEDEV IDOSZAK
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
     alap.BNO
    ,veny.NEGYEDEV
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end)
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    BNO
    ,IDOSZAK
    ,KORCSOPORT
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Országos' TER_TIP
    ,'Mind' MEGYE
    ,cast('Összesen' as varchar2(50)) MEGYE_NEV
    ,alap.BNO
    ,cast('Éves' as varchar2(10)) IDO_TIP
    ,veny.EV IDOSZAK
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
     alap.BNO
    ,veny.EV
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end)
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    BNO
    ,IDOSZAK
    ,KORCSOPORT
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

--Megye
---Feldolgozás
insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Megye' TER_TIP
    ,alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40') MEGYE_NEV
    ,alap.BNO
    ,cast('Havi' as varchar2(10)) IDO_TIP
    ,veny.IDOSZAK
    ,cast('Összes' as varchar2(20)) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p  
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_MEGYE_TORZS mt on alap.MEGYE = mt.MEGYE_KOD
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
    alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40')
    ,alap.BNO
    ,veny.IDOSZAK
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    MEGYE
    ,BNO
    ,IDOSZAK
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Megye' TER_TIP
    ,alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40') MEGYE_NEV
    ,alap.BNO
    ,cast('Negyedéves' as varchar2(10)) IDO_TIP
    ,veny.NEGYEDEV IDOSZAK
    ,cast('Összes' as varchar2(20)) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_MEGYE_TORZS mt on alap.MEGYE = mt.MEGYE_KOD
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
    alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40')
    ,alap.BNO
    ,veny.NEGYEDEV
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    MEGYE
    ,BNO
    ,IDOSZAK
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Megye' TER_TIP
    ,alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40') MEGYE_NEV
    ,alap.BNO
    ,cast('Éves' as varchar2(10)) IDO_TIP
    ,veny.EV IDOSZAK
    ,cast('Összes' as varchar2(20)) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_MEGYE_TORZS mt on alap.MEGYE = mt.MEGYE_KOD
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
    alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40')
    ,alap.BNO
    ,veny.EV
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    MEGYE
    ,BNO
    ,IDOSZAK
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

--Életkorcsop
insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Megye' TER_TIP
    ,alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40') MEGYE_NEV
    ,alap.BNO
    ,cast('Havi' as varchar2(10)) IDO_TIP
    ,veny.IDOSZAK
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_MEGYE_TORZS mt on alap.MEGYE = mt.MEGYE_KOD
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
    alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40')
    ,alap.BNO
    ,veny.IDOSZAK
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end)
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    MEGYE
    ,BNO
    ,IDOSZAK
    ,KORCSOPORT
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Megye' TER_TIP
    ,alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40') MEGYE_NEV
    ,alap.BNO
    ,cast('Negyedéves' as varchar2(10)) IDO_TIP
    ,veny.NEGYEDEV IDOSZAK
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_MEGYE_TORZS mt on alap.MEGYE = mt.MEGYE_KOD
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
    alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40')
    ,alap.BNO
    ,veny.NEGYEDEV
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end)
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    MEGYE
    ,BNO
    ,IDOSZAK
    ,KORCSOPORT
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

insert into
    RFLOW.RF_S248_E_201809_1_0
select
    'Megye' TER_TIP
    ,alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40') MEGYE_NEV
    ,alap.BNO
    ,cast('Éves' as varchar2(10)) IDO_TIP
    ,veny.EV IDOSZAK
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end) KORCSOPORT
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
    ,count(distinct alap.TAJ) Beteg_Mind
    ,nvl(count(distinct case when alap.eletkor > 18 then alap.TAJ else NULL end),0) Beteg_Mind_18p
    ,count(distinct veny.eset) Doboz
    ,nvl(count(distinct case when alap.eletkor > 18 then veny.eset else NULL end),0) Doboz_18p
    ,nvl(count(distinct case when (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj6 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p
    ,sum(nvl(veny12.DOBOZ,0)) Doboz_12ho
    ,sum((case when alap.eletkor > 18 then nvl(veny12.DOBOZ,0) else 0 end)) Doboz_18p_12ho
    ,nvl(count(distinct case when (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo
    ,nvl(count(distinct case when (alap.eletkor > 18) and (elhagy = 1) then alap.TAJ else NULL end),0) Beteg_Elhagyo_18p
    ,nvl(count(distinct case when (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod1
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod1 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod1
    ,nvl(count(distinct case when (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_mod2
    ,nvl(count(distinct case when (alap.eletkor > 18) and (uj12_mod2 = 1) then alap.TAJ else NULL end),0) Beteg_Uj_18p_mod2
    
from
    RFLOW.RF_S248_E_201809_1_0_TMP2 alap
    inner join RFLOW.RF_S248_E_201809_1_0_TMP1 veny on alap.TAJ = veny.TAJ and alap.BNO = veny.BNO and alap.DATUM = veny.DATUM and alap.TCS = veny.TCS
    left outer join RFLOW.RF_S248_MEGYE_TORZS mt on alap.MEGYE = mt.MEGYE_KOD
    left outer join RFLOW.RF_S248_E_201809_1_0_DOBOZ veny12 on (veny.TAJ = veny12.TAJ) and (veny.DATUM = veny12.DATUM) and (veny.TTT = veny12.TTT)
group by
    alap.MEGYE
    ,nvl(MEGYE_NEV,'ismeretlen/S40')
    ,alap.BNO
    ,veny.EV
    ,(case
        when alap.eletkor between 0 and 6 then '0-6'
        when alap.eletkor between 7 and 14 then '7-14'
        when alap.eletkor between 15 and 24 then '15-24'
        when alap.eletkor between 25 and 44 then '25-44'
        when alap.eletkor between 45 and 64 then '45-64'
     else
        '65 és felett'
     end)
    ,alap.TCS
    ,veny.ATC
    ,veny.HATOANYAG
    ,veny.BRAND
    ,veny.TTT
    ,veny.NEV
order by
    MEGYE
    ,BNO
    ,IDOSZAK
    ,KORCSOPORT
    ,TCS
    ,ATC
    ,BRAND
    ,TTT
;
commit;

update
    RFLOW.RF_S248_E_201809_1_0
set
    Beteg_Mind = (case when Beteg_Mind < 10 then 0 else Beteg_Mind end)
    ,Beteg_Mind_18p = (case when Beteg_Mind_18p < 10 then 0 else Beteg_Mind_18p end)
    ,Doboz = (case when Doboz < 10 then 0 else Doboz end)
    ,Doboz_18p = (case when Doboz_18p < 10 then 0 else Doboz_18p end)
    ,Beteg_Uj = (case when Beteg_Uj < 10 then 0 else Beteg_Uj end)
    ,Beteg_Uj_18p = (case when Beteg_Uj_18p < 10 then 0 else Beteg_Uj_18p end)
    ,Doboz_12ho = (case when Doboz_12ho < 10 then 0 else Doboz_12ho end)
    ,Doboz_18p_12ho = (case when Doboz_18p_12ho < 10 then 0 else Doboz_18p_12ho end)
    ,Beteg_Elhagyo = (case when Beteg_Elhagyo < 10 then 0 else Beteg_Elhagyo end)
    ,Beteg_Elhagyo_18p = (case when Beteg_Elhagyo_18p < 10 then 0 else Beteg_Elhagyo_18p end)
    ,Beteg_Uj_mod1 = (case when Beteg_Uj_mod1 < 10 then 0 else Beteg_Uj_mod1 end)
    ,Beteg_Uj_18p_mod1 = (case when Beteg_Uj_18p_mod1 < 10 then 0 else Beteg_Uj_18p_mod1 end)
    ,Beteg_Uj_mod2 = (case when Beteg_Uj_mod2 < 10 then 0 else Beteg_Uj_mod2 end)
    ,Beteg_Uj_18p_mod2 = (case when Beteg_Uj_18p_mod2 < 10 then 0 else Beteg_Uj_18p_mod2 end)
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_1_0
where
    (Beteg_Mind + Beteg_Mind_18p + Doboz + Doboz_18p + Beteg_Uj + Beteg_Uj_18p + Doboz_12ho + Doboz_18p_12ho + Beteg_Elhagyo + Beteg_Elhagyo_18p + Beteg_Uj_mod1 + Beteg_Uj_18p_mod1 + Beteg_Uj_mod2 + Beteg_Uj_18p_mod2) = 0
;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMP1';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPA';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPB';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPC';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMPD';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_TMP2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_1_0_DOBOZ';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;