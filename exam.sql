1답;
select ename,hiredate
from emp
where hiredate between '19820101' and '19830101';

2답;
select mem_id ,mem_name
from member
where mem_name like '%진%';

3답;
SELECT 
FROM EMP
WHERE JOB IN 'SALESMAN' AND HIREDATE = ('810601');

4답;
SELECT rownum, empno, ename
FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY empno);

5답;
SELECT MAX(SAL) MAX_SAL,MIN(SAL) MIN_SAL,ROUND(AVG(SAL),2)AVG_SAL,SUM(SAL)SUM_SAL,
       COUNT(SAL) COUNT_SAL,COUNT(MGR)COUNT_MGR,COUNT() COUNT_ALL
FROM EMP;

6답;
select customer.CID , customer.CNM , cycle.PID , cycle.DAY , cycle.CNT
from customer,cycle
where (customer.CID=cycle.CID) AND (CNM='brown' or CNM='sally');

7답;
select 
from emp
where deptno in (select deptno
                 from emp
                 where ename in('SMITH','WARD'));