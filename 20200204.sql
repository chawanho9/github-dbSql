CROSS JOIN ==> (Cartesian product)
�����ϴ� �� ���̺��� ���� ������ �����Ǵ� ���
������ ��� ���տ� ���� ����(����)�� �õ�
dept(4),emp(14)�� CROSS JOIN �� ����� 4*14=56 ��
dept ���̺�� emp���̺��� ������ �ϱ����� FROM���� �ΰ��� ���̺��� ���
WHERE���� �� ���̺��� ���� ������ ����;

SELECT dept.dname,emp.empno,emp.ename
FROM dept, emp
where dept.deptno=10
AND dept.deptno = emp.deptno;

SELECT *
FROM customer;

SELECT*
FROM product;

SELECT *
FROM customer c , product P;

SUBQUERY : ���� �ȿ� �ٸ� ������ �� �ִ� ��� 
SUBQUERY�� ���� ��ġ�� ���� 3������ �з�


SELECT �� : SCALAR SUBQUERY (�ϳ��� �� , �ϳ��� �÷��� �����ؾ� ������ �߻����� ����)
FROM �� : INLINE - VIEW
WHERE �� : SUB QUERY

���������ϴ°�
SMITH�� ���� �μ��� ���ϴ� �������� ������ ��ȸ;
1.SMITH�� ���� �μ� ��ȣ�� ���Ѵ�.
2. 1������ ���� �μ� ��ȣ�� ���� ������ ������ ��ȸ�Ѵ�

1-1;
SELECT *
FROM emp
WHERE ename IN 'SMITH';

1-2 1������ ���� �μ���ȣ�� �̿��Ͽ� �ش� �μ��� ���ϴ� ���� ������ ��ȸ;
SELECT *
FROM emp
WHERE deptno = 20;

SUBQUERY�� �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ ���� 

SELECT *
FROM emp
WHERE deptno =  ( SELECT deptno 
                  FROM emp
                  WHERE ename = 'SMITH');

--sub1
--��� �޿����� ���� �޿��� �޴� ������ ���� ��ȸ�ϼ���
SELECT*
FROM EMP;

SELECT count(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM EMP);

--sub2
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM EMP);


������ ������ 
IN : ���������� �������� ��ġ�ϴ� ���� ���� �� �� 
ANY (Ȱ�뵵�� �ټ� ������):���������� �������� �����̶� ������ �����ҋ�
ALL (Ȱ�뵵�� �ټ� ������):���������� �������� ����࿡ ���� ������ �����ҋ�;

--sub3
SELECT deptno
FROM emp
WHERE ename IN ('SMITH','WARD');

SELECT empno, ename, job, mgr,hiredate,sal,comm,deptno
FROM emp
WHERE deptno IN(
                 SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH','WARD'));

SMITH,WARD ����� �޿����� �޿��� ���� ������ ��ȸ ;
SELECT *
FROM emp
WHERE sal < ANY (800,1250);

SELECT sal
FROM emp
WHERE ename IN  ('WARD','SMITH');

SELECT *
FROM emp
WHERE sal < ANY (SELECT sal
             FROM emp
             WHERE ename IN  ('WARD','SMITH'));
             
SMITH,WARD ����� �޿����� �޿��� ���� ������ ��ȸ(SMITH , WARD�� �޿� 2���� ��ο� ���� ������
1250���� �޿��� �������
SELECT * 
FROM emp
WHERE sal> ALL(select sal
               FROM EMP
               where ENAME IN ('SMITH','WARD'));
               
IN,NOT IN �� NULL �� ���õ� ���� ����;

������ ������ ����� 7902 �̰ų�(OR) null;
SELECT *
FROM emp
WHERE mgr IN ( 7902 , null);


NULL�񱳴� = �����ڰ� �ƴ϶� IS NUL �� �� �ؾ������� IN �����ڴ� =�� ��� ;
NULL ���� ������� IN ������ ����� ���� !!!!!!!!!!;
SELECT *
FROM emp
WHERE mgr = 7902 OR mgr = null;

empno NOT IN (7902 , NULL) ==> AND
�����ȣ�� 7902�� �ƴϸ鼭 (AND) NULL �� �ƴ� ������
SELECT *
FROM emp
WHERE empno NOT IN (7902, NULL);

SELECT *
FROM emp
WHERE empno != 7902
AND empno IS NOT NULL;

pairvise (������)
�������� ����� ���ÿ� ���� ��ų��;
(mgr , deptno)
7698,30  7683,30
SELECT *
FROM emp
WHERE (mgr, deptno) IN SELECT mgr, empno
FROM emp
WHERE empno IN (7499,7782); 

non - parirwise�� �������� ���ÿ� ������Ű�� �ʴ� ���·� �ۼ� 
mgr���� 7696dlrjsk 7839 �̸鼭
deptno�� 10�̰ų� 310���� ����
7689,10    7698,30
7893,10    7893,30
SELECT *
FROM emp
 WHERE mgr IN (select mgr
                from emp
                where empno IN (7499 , 7782))
and DEPTNO in (SELECT deptno
                from emp 
                where EMPNO in(7499,7782));
                
��Į�� �������� : SELECT ���� ��� , 1���� ROW ,1���� COL �� ��ȸ�ϴ� ����;
��Į�� ���������� MAIN ������ �÷��� ����ϴ°� �����ϴ�;

SELECT (SELECT SYSDATE FROM dual), dept.*
FROM dept;

SELECT empno,ename, deptno, 
       (SELECT dname 
       FROM dept 
       WHERE deptno = emp.deptno ) dname
FROM emp;

INLINE VIEW : FROM ���� ����Ǵ� ��������;

MAIN ������ �÷��� SUBQUERY���� ��� �ϴ��� ���ǿ� ���� �з�
��� �� ��� : CORRELATED SUBQURY(��ȣ ���� ����), ���� ������ �ܵ����� �����ϴ°� �Ұ���
             ��������� �������ִ�. (MAIN > SUB)
��� ���� ���� ��� : NON-CORELATED SUBQUERY(���ȣ ���� ��������), ���������� �ܵ����� ���� ���� 
                    ��������� ���������� �ʴ�.
��������� �޿� ��պ��� �޿��� ���� ����� ��ȸ
SELECT * 
FROM emp 
WHERE sal > (SELECT AVG(sal)
             FROM emp);
    
������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ;
SELECT  e.eanem, e.sal
FROM emp e JOIN emp m ON (e.; 

SELECT * 
FROM emp m
WHERE sal >  (SELECT AVG(sal)
             FROM emp s
             WHERE s.deptno = m.deptno);

���� ������ ������ �̿��� Ǯ���
1. ���� ���̺� ���� 
    emp, �׺� �޿� ��� (inline view);
    
SELECT emp.*
FROM emp, (SELECT deptno, round(avg(sal)) avg_sal
           FROM emp
           GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno           
AND emp.sal> dept_sal.avg_sal;
----------------------------------------------------------------------
select emp.ename , sal, emp.deptno,dept_sal.*
from emp,(select deptno,round(AVG(sal)) avg_sal
          from emp
          group by deptno) dept_sal
where emp.deptno=dept_sal.deptno
and emp.sal>dept_sal.avg_sal;               

--sub4
������ �߰�;
INSERT INTO dept VALUES (99, 'ddit','daejeon');
COMMIT;

DELETE dept 
WHERE deptno =99;

SELECT * 
FROM dept;

ROLLBACK; Ʈ����� ��� 
COMMIT; Ʈ����� Ȯ�� 

--sub4
dept ���̺��� �ű� ��ϵ� 99�� �μ��� ���� ����� ����
������ ������ ���� �μ��� ��ȸ�ϴ� ������ �ۼ��غ�����;
SELECT * 
FROM emp;

SELECT * 
FROM dept;

SELECT* 
FROM dept
WHERE deptno NOT IN (select deptno FROM emp); --���ȣ����

               