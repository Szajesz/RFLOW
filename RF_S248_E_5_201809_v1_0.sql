BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_5_1_0';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_5_TMP';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

create table RFLOW.RF_S248_E_201809_5_TMP as
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
    ,hato.TCS
    ,x.TTT
    ,x.DATUM
    ,x.TAJ
    ,x.MENNY
FROM
    RFLOW.RF_S248_VENY x
    inner join RFLOW.RF_S248_TTT hato on x.TTT = hato.TTT
where
    x.TAJ <> '900000007'
    and (DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2017/12/31','yyyy/mm/dd'))
;
    
insert into
    RFLOW.RF_S248_E_201809_5_TMP
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
    ,hato.TCS
    ,x.TTT
    ,x.DATUM
    ,x.TAJO TAJ
    ,1 MENNY
FROM
    RFLOW.RF_S40_VENY x
    inner join RFLOW.RF_S248_TTT hato on x.TTT = hato.TTT
where
    x.TAJO <> '900000007'
    and (DATUM between to_date('2016/01/01','yyyy/mm/dd') and to_date('2017/12/31','yyyy/mm/dd'))
;
commit;

-----------------------------------------------------------
insert into
    RFLOW.RF_S248_E_201809_5_TMP
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
    ,hato.TCS
    ,x.TTT
    ,x.DATUM
    ,x.TAJ
    ,x.MENNY
FROM
    RFLOW.RF_S248_VENY_201809 x
    inner join RFLOW.RF_S248_TTT hato on x.TTT = hato.TTT
where
    x.TAJ <> '900000007'
    and (DATUM between to_date('2018/01/01','yyyy/mm/dd') and to_date('2018/12/31','yyyy/mm/dd'))
;
commit;
-----------------------------------------------------------

create index ix_E_5_TMP_TAJ on RFLOW.RF_S248_E_201809_5_TMP(TAJ);
create index ix_E_5_TMP_DAT on RFLOW.RF_S248_E_201809_5_TMP(DATUM);
create index ix_E_5_TMP_TTT on RFLOW.RF_S248_E_201809_5_TMP(TTT);
create index ix_E_5_TMP_TCS on RFLOW.RF_S248_E_201809_5_TMP(TCS);
create index ix_E_5_TMP_NEGYED on RFLOW.RF_S248_E_201809_5_TMP(NEGYEDEV);
create index ix_E_5_TMP_EV on RFLOW.RF_S248_E_201809_5_TMP(EV);
    
--Brand
create table RFLOW.RF_S248_E_201809_5_1_0 as
select
    '5/A' KATEG
    ,Aalap.NEGYEDEV IDOSZAK
    ,Aalap.TCS A_TCS
    ,hato1.ATC A_ATC
    ,hato1.HATOANYAG A_HATOANYAG
    ,hato1.BRAND A_BRAND
    ,Balap.TCS B_TCS
    ,hato2.ATC B_ATC
    ,hato2.HATOANYAG B_HATOANYAG
    ,hato2.BRAND B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.NEGYEDEV
    ,Aalap.TCS
    ,hato1.ATC
    ,hato1.HATOANYAG
    ,hato1.BRAND
    ,Balap.TCS
    ,hato2.ATC
    ,hato2.HATOANYAG
    ,hato2.BRAND
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,A_ATC
    ,A_BRAND
    ,B_TCS
    ,B_ATC
    ,B_BRAND 
;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/A' KATEG
    ,Aalap.EV IDOSZAK
    ,Aalap.TCS A_TCS
    ,hato1.ATC A_ATC
    ,hato1.HATOANYAG A_HATOANYAG
    ,hato1.BRAND A_BRAND
    ,Balap.TCS B_TCS
    ,hato2.ATC B_ATC
    ,hato2.HATOANYAG B_HATOANYAG
    ,hato2.BRAND B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.EV
    ,Aalap.TCS
    ,hato1.ATC
    ,hato1.HATOANYAG
    ,hato1.BRAND
    ,Balap.TCS
    ,hato2.ATC
    ,hato2.HATOANYAG
    ,hato2.BRAND
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,A_ATC
    ,A_BRAND
    ,B_TCS
    ,B_ATC
    ,B_BRAND 
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/B' KATEG
    ,Aalap.NEGYEDEV IDOSZAK
    ,Aalap.TCS A_TCS
    ,hato1.ATC A_ATC
    ,hato1.HATOANYAG A_HATOANYAG
    ,hato1.BRAND A_BRAND
    ,Balap.TCS B_TCS
    ,hato2.ATC B_ATC
    ,hato2.HATOANYAG B_HATOANYAG
    ,hato2.BRAND B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_E_201809_5_TMP Calap on (Aalap.TAJ = Calap.TAJ) and (Calap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TTT = Calap.TTT)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.NEGYEDEV
    ,Aalap.TCS
    ,hato1.ATC
    ,hato1.HATOANYAG
    ,hato1.BRAND
    ,Balap.TCS
    ,hato2.ATC
    ,hato2.HATOANYAG
    ,hato2.BRAND
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,A_ATC
    ,A_BRAND
    ,B_TCS
    ,B_ATC
    ,B_BRAND 
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/B' KATEG
    ,Aalap.EV IDOSZAK
    ,Aalap.TCS A_TCS
    ,hato1.ATC A_ATC
    ,hato1.HATOANYAG A_HATOANYAG
    ,hato1.BRAND A_BRAND
    ,Balap.TCS B_TCS
    ,hato2.ATC B_ATC
    ,hato2.HATOANYAG B_HATOANYAG
    ,hato2.BRAND B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_E_201809_5_TMP Calap on (Aalap.TAJ = Calap.TAJ) and (Calap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TTT = Calap.TTT)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.EV
    ,Aalap.TCS
    ,hato1.ATC
    ,hato1.HATOANYAG
    ,hato1.BRAND
    ,Balap.TCS
    ,hato2.ATC
    ,hato2.HATOANYAG
    ,hato2.BRAND
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,A_ATC
    ,A_BRAND
    ,B_TCS
    ,B_ATC
    ,B_BRAND 
;
commit;

--ATC
insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/A' KATEG
    ,Aalap.NEGYEDEV IDOSZAK
    ,Aalap.TCS A_TCS
    ,hato1.ATC A_ATC
    ,hato1.HATOANYAG A_HATOANYAG
    ,'Mind' A_BRAND
    ,Balap.TCS B_TCS
    ,hato2.ATC B_ATC
    ,hato2.HATOANYAG B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.NEGYEDEV
    ,Aalap.TCS
    ,hato1.ATC
    ,hato1.HATOANYAG
    ,Balap.TCS
    ,hato2.ATC
    ,hato2.HATOANYAG
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,A_ATC
    ,B_TCS
    ,B_ATC
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/A' KATEG
    ,Aalap.EV IDOSZAK
    ,Aalap.TCS A_TCS
    ,hato1.ATC A_ATC
    ,hato1.HATOANYAG A_HATOANYAG
    ,'Mind' A_BRAND
    ,Balap.TCS B_TCS
    ,hato2.ATC B_ATC
    ,hato2.HATOANYAG B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.EV
    ,Aalap.TCS
    ,hato1.ATC
    ,hato1.HATOANYAG
    ,Balap.TCS
    ,hato2.ATC
    ,hato2.HATOANYAG
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,A_ATC
    ,B_TCS
    ,B_ATC
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/B' KATEG
    ,Aalap.NEGYEDEV IDOSZAK
    ,Aalap.TCS A_TCS
    ,hato1.ATC A_ATC
    ,hato1.HATOANYAG A_HATOANYAG
    ,'Mind' A_BRAND
    ,Balap.TCS B_TCS
    ,hato2.ATC B_ATC
    ,hato2.HATOANYAG B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_E_201809_5_TMP Calap on (Aalap.TAJ = Calap.TAJ) and (Calap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TTT = Calap.TTT)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.NEGYEDEV
    ,Aalap.TCS
    ,hato1.ATC
    ,hato1.HATOANYAG
    ,Balap.TCS
    ,hato2.ATC
    ,hato2.HATOANYAG
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,A_ATC
    ,B_TCS
    ,B_ATC
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/B' KATEG
    ,Aalap.EV IDOSZAK
    ,Aalap.TCS A_TCS
    ,hato1.ATC A_ATC
    ,hato1.HATOANYAG A_HATOANYAG
    ,'Mind' A_BRAND
    ,Balap.TCS B_TCS
    ,hato2.ATC B_ATC
    ,hato2.HATOANYAG B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_E_201809_5_TMP Calap on (Aalap.TAJ = Calap.TAJ) and (Calap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TTT = Calap.TTT)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.EV
    ,Aalap.TCS
    ,hato1.ATC
    ,hato1.HATOANYAG
    ,Balap.TCS
    ,hato2.ATC
    ,hato2.HATOANYAG
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,A_ATC
    ,B_TCS
    ,B_ATC
;
commit;

--TCS
insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/A' KATEG
    ,Aalap.NEGYEDEV IDOSZAK
    ,Aalap.TCS A_TCS
    ,'Mind' A_ATC
    ,'Mind' A_HATOANYAG
    ,'Mind' A_BRAND
    ,Balap.TCS B_TCS
    ,'Mind' B_ATC
    ,'Mind' B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.NEGYEDEV
    ,Aalap.TCS
    ,Balap.TCS
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,B_TCS
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/A' KATEG
    ,Aalap.EV IDOSZAK
    ,Aalap.TCS A_TCS
    ,'Mind' A_ATC
    ,'Mind' A_HATOANYAG
    ,'Mind' A_BRAND
    ,Balap.TCS B_TCS
    ,'Mind' B_ATC
    ,'Mind' B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.EV
    ,Aalap.TCS
    ,Balap.TCS
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,B_TCS
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/B' KATEG
    ,Aalap.NEGYEDEV IDOSZAK
    ,Aalap.TCS A_TCS
    ,'Mind' A_ATC
    ,'Mind' A_HATOANYAG
    ,'Mind' A_BRAND
    ,Balap.TCS B_TCS
    ,'Mind' B_ATC
    ,'Mind' B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_E_201809_5_TMP Calap on (Aalap.TAJ = Calap.TAJ) and (Calap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TTT = Calap.TTT)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.NEGYEDEV
    ,Aalap.TCS
    ,Balap.TCS
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,B_TCS
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/B' KATEG
    ,Aalap.EV IDOSZAK
    ,Aalap.TCS A_TCS
    ,'Mind' A_ATC
    ,'Mind' A_HATOANYAG
    ,'Mind' A_BRAND
    ,Balap.TCS B_TCS
    ,'Mind' B_ATC
    ,'Mind' B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_E_201809_5_TMP Calap on (Aalap.TAJ = Calap.TAJ) and (Calap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TTT = Calap.TTT)
    inner join RFLOW.RF_S248_TTT hato1 on Aalap.TTT = hato1.TTT
    inner join RFLOW.RF_S248_TTT hato2 on Balap.TTT = hato2.TTT
group by
    Aalap.EV
    ,Aalap.TCS
    ,Balap.TCS
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
    ,A_TCS
    ,B_TCS
;
commit;

--Mind
insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/A' KATEG
    ,Aalap.NEGYEDEV IDOSZAK
    ,'Mind' A_TCS
    ,'Mind' A_ATC
    ,'Mind' A_HATOANYAG
    ,'Mind' A_BRAND
    ,'Mind' B_TCS
    ,'Mind' B_ATC
    ,'Mind' B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
group by
    Aalap.NEGYEDEV
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/A' KATEG
    ,Aalap.EV IDOSZAK
    ,'Mind' A_TCS
    ,'Mind' A_ATC
    ,'Mind' A_HATOANYAG
    ,'Mind' A_BRAND
    ,'Mind' B_TCS
    ,'Mind' B_ATC
    ,'Mind' B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
group by
    Aalap.EV
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/B' KATEG
    ,Aalap.NEGYEDEV IDOSZAK
    ,'Mind' A_TCS
    ,'Mind' A_ATC
    ,'Mind' A_HATOANYAG
    ,'Mind' A_BRAND
    ,'Mind' B_TCS
    ,'Mind' B_ATC
    ,'Mind' B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_E_201809_5_TMP Calap on (Aalap.TAJ = Calap.TAJ) and (Calap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TTT = Calap.TTT)
group by
    Aalap.NEGYEDEV
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
;
commit;

insert into
    RFLOW.RF_S248_E_201809_5_1_0
select
    '5/B' KATEG
    ,Aalap.EV IDOSZAK
    ,'Mind' A_TCS
    ,'Mind' A_ATC
    ,'Mind' A_HATOANYAG
    ,'Mind' A_BRAND
    ,'Mind' B_TCS
    ,'Mind' B_ATC
    ,'Mind' B_HATOANYAG
    ,'Mind' B_BRAND
    ,count(distinct Aalap.TAJ) Beteg
from
    RFLOW.RF_S248_E_201809_5_TMP Aalap
    inner join RFLOW.RF_S248_E_201809_5_TMP Balap on (Aalap.TAJ = Balap.TAJ) and (Balap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TCS <> Balap.TCS)
    inner join RFLOW.RF_S248_E_201809_5_TMP Calap on (Aalap.TAJ = Calap.TAJ) and (Calap.DATUM between (Aalap.DATUM+1) and add_months(Aalap.DATUM,(Aalap.menny+1))) and (Aalap.TTT = Calap.TTT)
group by
    Aalap.EV
having
    count(distinct Aalap.TAJ) > 9
order by
    IDOSZAK
;
commit;


BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RFLOW.RF_S248_E_201809_5_TMP';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;