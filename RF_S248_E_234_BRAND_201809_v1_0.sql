BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_2_1_0_BRAND';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_3_1_0_BRAND';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_4_1_0_BRAND';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_2_TMP';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;  

create table RFLOW.RF_S248_E_201809_2_TMP as
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
    ,floor((x.DATUM - dem.SZULETES_DATUM) / 365.242199) ELETKOR
    ,TCS
    ,(case
        when substr(BNOKOD,1,3) = 'J44' then 'J44'
        when substr(BNOKOD,1,3) = 'J45' then 'J45'
    else
        'Egyéb'
    end) BNO
    ,hato.HATOANYAG
    ,hato.BRAND
    ,x.TTT
    ,x.DATUM
    ,(x.TAJ||to_char(x.DATUM,'YYYYMMDD')) eset
FROM
    RFLOW.RF_S248_VENY x
    inner join RFLOW.RF_S248_DEM dem on x.TAJ = dem.TAJ
    inner join RFLOW.RF_S248_TTT hato on x.TTT = hato.TTT
where
    x.TAJ <> '900000007'
    and (DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2017/12/31','yyyy/mm/dd'))
;
    
insert into
    RFLOW.RF_S248_E_201809_2_TMP
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
    ,floor((x.DATUM - dem.SZULETES_DATUM) / 365.242199) ELETKOR
    ,TCS
    ,(case
        when substr(BNOKOD,1,3) = 'J44' then 'J44'
        when substr(BNOKOD,1,3) = 'J45' then 'J45'
    else
        'Egyéb'
    end) BNO
    ,hato.HATOANYAG
    ,hato.BRAND
    ,x.TTT
    ,x.DATUM
    ,(x.TAJO||to_char(x.DATUM,'YYYYMMDD')) eset
FROM
    RFLOW.RF_S40_VENY x
    inner join RFLOW.RF_S40_DEM dem on x.TAJO = dem.TAJ
    inner join RFLOW.RF_S248_TTT hato on x.TTT = hato.TTT
where
    x.TAJO <> '900000007'
    and (DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2017/12/31','yyyy/mm/dd'))
;
commit;

----------------------------------------------
insert into
    RFLOW.RF_S248_E_201809_2_TMP
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
    ,floor((x.DATUM - dem.SZULETES_DATUM) / 365.242199) ELETKOR
    ,TCS
    ,(case
        when substr(BNOKOD,1,3) = 'J44' then 'J44'
        when substr(BNOKOD,1,3) = 'J45' then 'J45'
    else
        'Egyéb'
    end) BNO
    ,hato.HATOANYAG
    ,hato.BRAND
    ,x.TTT
    ,x.DATUM
    ,(x.TAJ||to_char(x.DATUM,'YYYYMMDD')) eset
FROM
    RFLOW.RF_S248_VENY_201809 x
    inner join RFLOW.RF_S248_DEM_201809 dem on x.TAJ = dem.TAJ
    inner join RFLOW.RF_S248_TTT hato on x.TTT = hato.TTT
where
    x.TAJ <> '900000007'
    and (DATUM between to_date('2018/01/01','yyyy/mm/dd') and to_date('2018/12/31','yyyy/mm/dd'))
;
commit;
----------------------------------------------
    
create index ix_E_2_HO_TMP_TAJ on RFLOW.RF_S248_E_201809_2_TMP(TAJ);
create index ix_E_2_HO_TMP_BNO on RFLOW.RF_S248_E_201809_2_TMP(BNO);
create index ix_E_2_HO_TMP_TERMEK_CSOP on RFLOW.RF_S248_E_201809_2_TMP(TCS);
create index ix_E_2_HO_TMP_IDOSZAK on RFLOW.RF_S248_E_201809_2_TMP(IDOSZAK);
create index ix_E_2_HO_TMP_NEGYED on RFLOW.RF_S248_E_201809_2_TMP(NEGYEDEV);
create index ix_E_2_HO_TMP_EV on RFLOW.RF_S248_E_201809_2_TMP(EV);
create index ix_E_2_HO_TMP_EKOR on RFLOW.RF_S248_E_201809_2_TMP(ELETKOR);
create index ix_E_2_HO_TMP_ESET on RFLOW.RF_S248_E_201809_2_TMP(eset);
create index ix_E_2_HO_TMP_BRAND on RFLOW.RF_S248_E_201809_2_TMP(BRAND);
create index ix_E_2_HO_TMP_HATO on RFLOW.RF_S248_E_201809_2_TMP(HATOANYAG);


--Feladat 2
create table RFLOW.RF_S248_E_201809_2_1_0_BRAND as
select
    cast('Éves' as varchar2(10)) IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.EV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and x.BRAND <> y.BRAND
            and  (x.DATUM between (y.DATUM-180) and y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS = y.TCS
    group by
        x.EV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;

insert into
    RFLOW.RF_S248_E_201809_2_1_0_BRAND
select
    'Évhó' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and x.BRAND <> y.BRAND
            and  (x.DATUM between (y.DATUM-180) and y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS = y.TCS
    group by
        x.IDOSZAK
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

insert into
    RFLOW.RF_S248_E_201809_2_1_0_BRAND
select
    'Negyedév' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.NEGYEDEV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and x.BRAND <> y.BRAND
            and  (x.DATUM between (y.DATUM-180) and y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS = y.TCS
    group by
        x.NEGYEDEV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_2_1_0_BRAND
where
   (beteg + eset) = 0
;
commit;

--Feladat 3
create table RFLOW.RF_S248_E_201809_3_1_0_BRAND as
select
    cast('Éves' as varchar2(10)) IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.EV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and  (x.DATUM between (y.DATUM-180) and y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.EV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;

insert into
    RFLOW.RF_S248_E_201809_3_1_0_BRAND
select
    'Évhó' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and  (x.DATUM between (y.DATUM-180) and y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.IDOSZAK
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

insert into
    RFLOW.RF_S248_E_201809_3_1_0_BRAND
select
    'Negyedév' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.NEGYEDEV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and  (x.DATUM between (y.DATUM-180) and y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.NEGYEDEV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_3_1_0_BRAND
where
   (beteg + eset) = 0
;
commit;

--Feladat 4
create table RFLOW.RF_S248_E_201809_4_1_0_BRAND as
select
    '0 nap - 2 hónap' KATEG
    ,cast('Éves' as varchar2(10)) IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.EV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and (x.DATUM between y.DATUM and (y.DATUM+60))
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.EV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;

insert into
    RFLOW.RF_S248_E_201809_4_1_0_BRAND
select
    '0 nap - 2 hónap' KATEG
    ,'Évhó' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and (x.DATUM between y.DATUM and (y.DATUM+60))
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.IDOSZAK
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

insert into
    RFLOW.RF_S248_E_201809_4_1_0_BRAND
select
    '0 nap - 2 hónap' KATEG
    ,'Negyedév' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.NEGYEDEV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and (x.DATUM between y.DATUM and (y.DATUM+60))
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.NEGYEDEV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

insert into
    RFLOW.RF_S248_E_201809_4_1_0_BRAND
select
    '0 nap' KATEG
    ,cast('Éves' as varchar2(10)) IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.EV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and (x.DATUM = y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.EV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

insert into
    RFLOW.RF_S248_E_201809_4_1_0_BRAND
select
    '0 nap' KATEG
    ,'Évhó' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and (x.DATUM = y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.IDOSZAK
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

insert into
    RFLOW.RF_S248_E_201809_4_1_0_BRAND
select
    '0 nap' KATEG
    ,'Negyedév' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.NEGYEDEV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and (x.DATUM = y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.NEGYEDEV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

insert into
    RFLOW.RF_S248_E_201809_4_1_0_BRAND
select
    '1 nap - 2 hónap' KATEG
    ,cast('Éves' as varchar2(10)) IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.EV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and (x.DATUM between (y.DATUM+1) and (y.DATUM+60))
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.EV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

insert into
    RFLOW.RF_S248_E_201809_4_1_0_BRAND
select
    '1 nap - 2 hónap' KATEG
    ,'Évhó' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and (x.DATUM between (y.DATUM+1) and (y.DATUM+60))
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.IDOSZAK
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

insert into
    RFLOW.RF_S248_E_201809_4_1_0_BRAND
select
    '1 nap - 2 hónap' KATEG
    ,'Negyedév' IDO_TIP
    ,IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
    ,(case when beteg < 10 then 0 else beteg end) beteg
    ,(case when eset < 10 then 0 else eset end) eset
    ,(case when beteg_18p < 10 then 0 else beteg_18p end) beteg_18p
    ,(case when eset_18p < 10 then 0 else eset_18p end) eset_18p
from
    (select
        x.NEGYEDEV IDOSZAK
        ,x.BNO
        ,x.TCS A_TCS
        ,x.HATOANYAG A_HATOANYAG
        ,x.BRAND A_BRAND
        ,y.TCS B_TCS
        ,y.HATOANYAG B_HATOANYAG
        ,y.BRAND B_BRAND
        ,count(distinct x.TAJ) beteg
        ,count(distinct y.eset) eset
        ,nvl(count(distinct case when x.ELETKOR > 18 then x.TAJ else NULL end),0) beteg_18p
        ,nvl(count(distinct case when x.ELETKOR > 18 then y.eset else NULL end),0) eset_18p
    from
        RFLOW.RF_S248_E_201809_2_TMP x
        inner join RFLOW.RF_S248_E_201809_2_TMP y on x.TAJ = y.TAJ
            and (x.DATUM between (y.DATUM+1) and (y.DATUM+60))
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
    group by
        x.NEGYEDEV
        ,x.BNO
        ,x.TCS
        ,x.HATOANYAG
        ,x.BRAND
        ,y.TCS
        ,y.HATOANYAG
        ,y.BRAND
    ) precalc
order by
    IDOSZAK
    ,BNO
    ,A_TCS
    ,A_HATOANYAG
    ,A_BRAND
    ,B_TCS
    ,B_HATOANYAG
    ,B_BRAND
;
commit;

delete
from
    RFLOW.RF_S248_E_201809_4_1_0_BRAND
where
   (beteg + eset) = 0
;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_2_TMP';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;