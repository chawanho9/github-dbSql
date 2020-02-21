:dt==> 202002;
select decode(d,1,iw+1,iw) i,
        min(decode(d,1,dt)) sun,
        min(decode(d,2,dt)) mon,
        min(decode(d,3,dt)) tue,
        min(decode(d,4,dt)) wed,
        min(decode(d,5,dt)) tur,
        min(decode(d,6,dt)) fri,
        min(decode(d,7,dt)) sat
from
(SELECT TO_DATE(:dt,'yyyymm') + (level-1) dt,
        to_char(TO_DATE(:dt,'yyyymm') + (level-1),'D') d,
        to_char(TO_DATE(:dt,'yyyymm') + (level-1),'iw') iw
FROM dual 
CONNECT BY LEVEL <= next_day(last_day(to_date(:dt, 'yyyymm')),7)
                    -(to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'d')-1))
group by decode(d,1,iw+1,iw)
order by decode(d,1,iw+1,iw);

1. 해당 월읠 1일자가 속한 주의 일요일 구하기 
2. 해당 월의 마지막 일자가 속한 주의 토요일 구하기
3. 2-1을 하여 총 일수 구하기 

select trunc(to_date('20200401','yyyymmdd'),'iw') 첫쨰주,trunc(to_date('20200430','yyyymmdd'),'iw')+5 마지막주
from dual;

--sem
select 
        dt,d,
        dt - (7-d),
        next_day(dt2, 7)
from 
(select to_date(:dt || '01','yyymmdd') dt,
        to_char(to_date(:dt || '01','yyyymmdd'), 'd')d,
     
        last_day(to_date(:dt, 'yyyymm')) dt2,
        to_char(last_day(to_date(:dt, 'yyyymm')),'d')d2
from dual);    

기존 : 시작일자 1일 마지막 날짜 : 해당월의 마지막 일자 
select ('202002','yyyymm') + (level-1)
from dual
connect by level <= 29;


변경 : 시작일자가 : 해당월의 1일자가 속한 주의 일요일
      마지막날짜 : 해당월의 마지막 일자가 속한 주의 토요일      ;
select to_Date('2020026','yyyymmdd') + (level-1)
from dual
connect by level <= 35;

SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      
                
--수정
select decode(d,1,iw+1,iw) i,
        min (DECODE(d, 1, dt))sun,
        min (DECODE(d, 2, dt))mon,
        min (DECODE(d, 3, dt))tue,
        min (DECODE(d, 4, dt))wed,
        min (DECODE(d, 5, dt))tur,
        min (DECODE(d, 6, dt))fri,
        min (DECODE(d, 7, dt))sat
from
(select to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1) + (level-1) dt,

        to_char (to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1) + (level-1),'D') d,
        to_char (to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1) + (level-1),'IW') IW
from dual
connect by level <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1))
group by decode(d,1,iw+1,iw)
order by decode(d,1,iw+1,iw);


원본쿼리 1일~말일자;
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  TO_CHAR(last_day(to_date(:dt,'yyyymm')), 'DD'))
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
 

1일자가 속한 주의 일요일구하기
마지막일자가 속한 주의 토요일구 하기
일수 구하기; 
SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      


1일자, 말일자가 속한 주차까지 표현한 달력
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);


--calendar 1
select 
      min( decode(dt,01,s,'')) jan,
       min( decode(dt,02,s,'')) feb,
      nvl( min( decode(dt,03,s,'')),0) mar,
       min( decode(dt,04,s,'')) apr,
        min(decode(dt,05,s,'')) may,
       min( decode(dt,06,s,'')) jun
from(
select  to_char(dt,'mm') dt ,sum(sales) s        
from sales
group by to_char(dt,'mm')
order by dt
) ;

select*
from dept_h;

오라클 계층형 쿼리 문법 
select ....
from ....
start with 조건 : 어떤 행을 시작점으로 삼을지
connect by 행과 행을 연결하는 기준
            prior  : 이미 읽은 행
            "   "  : 앞으로 읽을 행;

하향식 : 상위에서 자식노드로 연결 (위==>아래);

xx회사 (최상위 조직) 부터 시작을 해서 하위 부서로 내려가는 계층 쿼리;
SELECT LPAD(' ',4, '*')
FROM DUAL;
select DEPT_H.*, LEVEL, LPAD(' ', (LEVEL-1)*4,' ') || DEPTNM -- 공백만들어주기
from dept_h
start with deptcd = 'dept0'
CONNECT BY PRIOR DEPTCD = P_DEPTCD;
행과 행의 연결 조건 (XX회사 - 3가지 부서(디자인,정보기획,정보시스템);
--디자인부에 대한 계층쿼리
PRIOR XX회사.DEPTCD = 디자인부.P_DEPTCD;
PRIOR 디자인부.DEPTCD = 디자인팀.P_DEPTCD;
--정보기획부에 대한 계층쿼리
PRIOR XX회사.DEPTCD = 정보기획부.P_DEPTCD
PRIOR 정보기획부.P_DEPTCD = 기획팀.P_DEPTCD
PRIOR 기획팀.DEPTCD = 기획파트.P_DEPT_CD
--정보시스템에 대한 계층쿼리
PRIOR XX회사.DEPTCD = 정보시스템부.P_DEPTCD(개발1팀,개발2팀)
PRIOR 정보시스템부.P.DEPTCD = 개발1팀.P_DEPTCD
PRIOR 개발1팀.P_DEPTCD != ....
PRIOR 정보시스템부.P.DEPTCD = 개발2팀.P_DEPTCD
PRIOR 개발2팀.P_DEPTCD != ....


--H_2
SELECT LPAD(' ',4, '*')
FROM DUAL;
select DEPT_H.*
from dept_h
start with deptcd = 'dept0_02'
CONNECT BY PRIOR DEPTCD = P_DEPTCD;
