select sysdate ,
       level
from dual
connect by level <=10;

--ppt sysdate�� level�� Ȱ���� ��¥ ��Ÿ����
select sysdate + level-1 dt    --���⼭ level�� -1�� ���������� ������ �����ϸ鼭 +1�� �Ǳ⶧���� ��Ȯ�� sysdate�� ��Ÿ��������
from dual
connect by level <=9;

* iw:�������� ���� ����(isoǥ��);
* ��-1 ��-2 ȭ-3 ��-4 ��-5 ��-6 ��-7 ��-8 : 'day'-'d'

--ppt Ư�� ����� ��� ���� ���ϱ�
select to_date('202002','yyyymm')+level-1 dt
from dual
connect by level <= last_day(to_date('202002','yyyymm'))-
                    to_date('202002','yyyymm')+1;
--connect by level <=31 �� ���������� ��ü
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
    
    
    
    
--�������� H_2
SELECT LPAD(' ',4, '*')
FROM DUAL;
select DEPT_H.*
from dept_h
start with deptcd = 'dept0_02'
CONNECT BY PRIOR DEPTCD = P_DEPTCD;