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

1. �ش� ���� 1���ڰ� ���� ���� �Ͽ��� ���ϱ� 
2. �ش� ���� ������ ���ڰ� ���� ���� ����� ���ϱ�
3. 2-1�� �Ͽ� �� �ϼ� ���ϱ� 

select trunc(to_date('20200401','yyyymmdd'),'iw') ù����,trunc(to_date('20200430','yyyymmdd'),'iw')+5 ��������
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

���� : �������� 1�� ������ ��¥ : �ش���� ������ ���� 
select ('202002','yyyymm') + (level-1)
from dual
connect by level <= 29;


���� : �������ڰ� : �ش���� 1���ڰ� ���� ���� �Ͽ���
      ��������¥ : �ش���� ������ ���ڰ� ���� ���� �����      ;
select to_Date('2020026','yyyymmdd') + (level-1)
from dual
connect by level <= 35;

SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      
                
--����
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


�������� 1��~������;
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
 

1���ڰ� ���� ���� �Ͽ��ϱ��ϱ�
���������ڰ� ���� ���� ����ϱ� �ϱ�
�ϼ� ���ϱ�; 
SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      


1����, �����ڰ� ���� �������� ǥ���� �޷�
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

����Ŭ ������ ���� ���� 
select ....
from ....
start with ���� : � ���� ���������� ������
connect by ��� ���� �����ϴ� ����
            prior  : �̹� ���� ��
            "   "  : ������ ���� ��;

����� : �������� �ڽĳ��� ���� (��==>�Ʒ�);

xxȸ�� (�ֻ��� ����) ���� ������ �ؼ� ���� �μ��� �������� ���� ����;
SELECT LPAD(' ',4, '*')
FROM DUAL;
select DEPT_H.*, LEVEL, LPAD(' ', (LEVEL-1)*4,' ') || DEPTNM -- ���鸸����ֱ�
from dept_h
start with deptcd = 'dept0'
CONNECT BY PRIOR DEPTCD = P_DEPTCD;
��� ���� ���� ���� (XXȸ�� - 3���� �μ�(������,������ȹ,�����ý���);
--�����κο� ���� ��������
PRIOR XXȸ��.DEPTCD = �����κ�.P_DEPTCD;
PRIOR �����κ�.DEPTCD = ��������.P_DEPTCD;
--������ȹ�ο� ���� ��������
PRIOR XXȸ��.DEPTCD = ������ȹ��.P_DEPTCD
PRIOR ������ȹ��.P_DEPTCD = ��ȹ��.P_DEPTCD
PRIOR ��ȹ��.DEPTCD = ��ȹ��Ʈ.P_DEPT_CD
--�����ý��ۿ� ���� ��������
PRIOR XXȸ��.DEPTCD = �����ý��ۺ�.P_DEPTCD(����1��,����2��)
PRIOR �����ý��ۺ�.P.DEPTCD = ����1��.P_DEPTCD
PRIOR ����1��.P_DEPTCD != ....
PRIOR �����ý��ۺ�.P.DEPTCD = ����2��.P_DEPTCD
PRIOR ����2��.P_DEPTCD != ....


--H_2
SELECT LPAD(' ',4, '*')
FROM DUAL;
select DEPT_H.*
from dept_h
start with deptcd = 'dept0_02'
CONNECT BY PRIOR DEPTCD = P_DEPTCD;
