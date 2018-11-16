BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_3_2_0';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_3_TMP';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

create table RFLOW.RF_S248_E_201809_3_TMP as
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
    ,(case
        when hato.ATC in('R03DA04','R03AC02','R03AL01') then 'SABA'
        when hato.ATC = 'H02AB04' then 'metilprednizolon'
        when hato.ATC = 'R03DC03' then 'montelukaszt'
    else
        hato.TCS
    end) TCS
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
    RFLOW.RF_S248_E_201809_3_TMP
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
    ,(case
        when hato.ATC in('R03DA04','R03AC02','R03AL01') then 'SABA'
        when hato.ATC = 'H02AB04' then 'metilprednizolon'
        when hato.ATC = 'R03DC03' then 'montelukaszt'
    else
        hato.TCS
    end) TCS
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

----------------------------------------------------
insert into
    RFLOW.RF_S248_E_201809_3_TMP
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
    ,(case
        when hato.ATC in('R03DA04','R03AC02','R03AL01') then 'SABA'
        when hato.ATC = 'H02AB04' then 'metilprednizolon'
        when hato.ATC = 'R03DC03' then 'montelukaszt'
    else
        hato.TCS
    end) TCS
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
----------------------------------------------------
create index ix_E_3_HO_TMP_TAJ on RFLOW.RF_S248_E_201809_3_TMP(TAJ);
create index ix_E_3_HO_TMP_BNO on RFLOW.RF_S248_E_201809_3_TMP(BNO);
create index ix_E_3_HO_TMP_TERMEK_CSOP on RFLOW.RF_S248_E_201809_3_TMP(TCS);
create index ix_E_3_HO_TMP_IDOSZAK on RFLOW.RF_S248_E_201809_3_TMP(IDOSZAK);
create index ix_E_3_HO_TMP_NEGYED on RFLOW.RF_S248_E_201809_3_TMP(NEGYEDEV);
create index ix_E_3_HO_TMP_EV on RFLOW.RF_S248_E_201809_3_TMP(EV);
create index ix_E_3_HO_TMP_EKOR on RFLOW.RF_S248_E_201809_3_TMP(ELETKOR);
create index ix_E_3_HO_TMP_ESET on RFLOW.RF_S248_E_201809_3_TMP(eset);
create index ix_E_3_HO_TMP_BRAND on RFLOW.RF_S248_E_201809_3_TMP(BRAND);
create index ix_E_3_HO_TMP_HATO on RFLOW.RF_S248_E_201809_3_TMP(HATOANYAG);

create table RFLOW.RF_S248_E_201809_3_2_0 as
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
        RFLOW.RF_S248_E_201809_3_TMP x
        inner join RFLOW.RF_S248_E_201809_3_TMP y on x.TAJ = y.TAJ
            and  (x.DATUM between (y.DATUM-180) and y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
        left outer join RFLOW.RF_S248_E_201809_3_TMP z on x.TAJ = z.TAJ
            and  (x.DATUM between (z.DATUM-180) and (z.DATUM-1))
            and (x.BNO = z.BNO)
            and x.TCS = z.TCS
    where
        (z.TAJ is NULL)
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
    RFLOW.RF_S248_E_201809_3_2_0
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
        RFLOW.RF_S248_E_201809_3_TMP x
        inner join RFLOW.RF_S248_E_201809_3_TMP y on x.TAJ = y.TAJ
            and  (x.DATUM between (y.DATUM-180) and y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
        left outer join RFLOW.RF_S248_E_201809_3_TMP z on x.TAJ = z.TAJ
            and  (x.DATUM between (z.DATUM-180) and (z.DATUM-1))
            and (x.BNO = z.BNO)
            and x.TCS = z.TCS
    where
        (z.TAJ is NULL)
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
    RFLOW.RF_S248_E_201809_3_2_0
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
        RFLOW.RF_S248_E_201809_3_TMP x
        inner join RFLOW.RF_S248_E_201809_3_TMP y on x.TAJ = y.TAJ
            and  (x.DATUM between (y.DATUM-180) and y.DATUM)
            and (x.BNO = y.BNO)
            and x.TCS <> y.TCS
        left outer join RFLOW.RF_S248_E_201809_3_TMP z on x.TAJ = z.TAJ
            and  (x.DATUM between (z.DATUM-180) and (z.DATUM-1))
            and (x.BNO = z.BNO)
            and x.TCS = z.TCS
    where
        (z.TAJ is NULL)
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
    RFLOW.RF_S248_E_201809_3_2_0
where
   (beteg + eset) = 0
;
commit;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_3_TMP';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;