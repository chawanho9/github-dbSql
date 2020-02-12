--1��
select ename,hiredate
from emp
where hiredate between '1982/01/01' and '1983/01/01';

--2��
select mem_id,mem_name
from member
where mem_name LIKE ('%��%');

--3��
SELECT *
from emp 
WHERE job ='SALESMAN' AND HIREDATE >TO_DATE(19810601);

--4��
SELECT ROWNUM,e.*
 FROM (   
    SELECT EMPNO,ENAME
    FROM EMP 
    ORDER BY EMPNO)e;
--5��
select deptno, max(sal) MAX_SAL, min(sal) MIN_SAL, round(avg(sal),2) AVG_SAL
from emp
group by deptno;

--6��
select c.cid,c.cnm,p.pnm,cy.pid,cy.day,cy.cnt
from customer c join cycle cy on (c.cid=cy.cid) 
join product p on (cy.pid= p.pid)
where c.cnm IN ('brown','sally');

--7��
SELECT *
FROM EMP 
WHERE DEPTNO IN (
            select DEPTNO
            from emp
            where ename in ('SMITH','WARD'));
