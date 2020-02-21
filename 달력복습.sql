select sysdate ,
       level
from dual
connect by level <=10;

--ppt sysdate와 level을 활용한 날짜 나타내기
select sysdate + level-1 dt    --여기서 level에 -1을 해준이유는 레벨이 시작하면서 +1이 되기때문에 정확힌 sysdate로 나타내기위해
from dual
connect by level <=9;

* iw:월요일을 주의 시작(iso표준);
* 일-1 월-2 화-3 수-4 목-5 금-6 토-7 일-8 : 'day'-'d'

--ppt 특정 년월의 모든 일자 구하기
select to_date('202002','yyyymm')+level-1 dt
from dual
connect by level <= last_day(to_date('202002','yyyymm'))-
                    to_date('202002','yyyymm')+1;
--connect by level <=31 을 서브쿼리로 대체
-----------------------------------------------------
select decode(d,1,w+1,w) w_no,
    min(decode(d,1,dt, '')) sun,
    min(decode(d,2,dt, '')) mon,
    min(decode(d,3,dt, '')) tue,
    min(decode(d,4,dt, '')) wed,
    min(decode(d,5,dt, '')) thu,
    min(decode(d,6,dt, '')) fri,
    min(decode(d,7,dt, '')) sat
from
    (select dt, 
        to_char(dt,'iw') w,
        to_char(dt,'d') d
    from(    
    select to_date('201905','yyyymm')+level-1 dt   
    from dual
    connect by level <= last_day(to_date('201905','yyyymm'))-
                        to_date('201905','yyyymm')+1))
    group by Decode(d,1,w+1,w)                    
    order by Decode(d,1,w+1,w);         
    
    
    
    
--계층쿼리 H_2
SELECT LPAD(' ',4, '*')
FROM DUAL;
select DEPT_H.*
from dept_h
start with deptcd = 'dept0_02'
CONNECT BY PRIOR DEPTCD = P_DEPTCD;