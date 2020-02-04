SELECT ename,deptno
FROM emp;

SELECT *
FROM dept;


-- JOIN �� ���̺��� �����ϴ� �۾�
-- JOIN ���� 
-- 1.ANSI ����
-- 2.ORACLE ����

--1. Natural Join##############################
-- �� ���̺� �� �÷����� ���� �� �ش� �÷����� ���� 
-- emp, dept ���̺��� deptno ��� �÷��� ����
SELECT *
FROM emp NATURAL JOIN dept;

--Natural join�� ���� ���� �÷�(deptno)�� ������(ex: ���̺��, ���̺� ��Ī)�� ������� �ʰ� �÷��� ����Ѵ�.
--ex) dept.deptno --> deptno

SELECT emp.empno,emp.ename, dept.dname,deptno
FROM emp NATURAL JOIN dept;

--���̺� ���� ��Ī�� ��밡��
SELECT e.empno,e.ename, d.dname,deptno
FROM emp e NATURAL JOIN dept d;

--2. ORACLE JOIN ###################################
--FROM ���� ������ ���̺� ����� ,�� �����Ͽ� �����Ѵ�
--������ ���̺��� ���������� WHERE���� ����Ѵ�.
--emp, dept ���̺� �����ϴ� deptno �÷��� (������) ����
SELECT *
FROM emp;
SELECT emp.ename,dept.dname,emp.deptno,dept.deptno
FROM emp, dept 
WHERE emp.deptno != dept.deptno; --�μ���ȣ�� �ٸ��� �����ض�
SELECT emp.ename,dept.dname,emp.deptno,dept.deptno
FROM emp, dept 
WHERE emp.deptno != dept.deptno;

--SELECT TABLE(

--����Ŭ ������ ���̺� ��Ī

SELECT e.empno,e.ename,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI : join with USING 
--���� �Ϸ��� �ΰ��� ���̺� �̸��� ���� �÷��� �ΰ������� 
--�ϳ��� �÷����θ� ������ ���ڰ� �ҋ�
--�����Ϸ��� ���� �÷��� ���
--emp, dept ���̺��� ���� �÷� : deptno
SELECT * FROM emp;
SELECT * FROM dept;
SELECT deptno, e.empno, e.ename
FROM emp e JOIN dept d USING (deptno);

SELECT emp.ename,dept.dname,deptno
FROM emp JOIN dept USING(deptno);

--JOIN WITH UING�� ORACLE�� ǥ���ϸ�?;
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--�����Ϸ����ϴ� ���̺��� �÷��� �̸��� ���� �ٸ���
SELECT emp.ename, dept.dname, dept.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--SELF JOIN :���� ���̺��� ���� 
--emp ���̺��� �����Ǵ� ����� ������ ����� �̿��Ͽ� ������ �̸��� ��ȸ�ҋ�
SELECT e.empno,e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

--����Ŭ �������� �ۼ�
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--equal ���� : =
--non-eqaul ���� : !=, >,<, BETWEEN AND

SELECT ename
FROM emp;

SELECT *
FROM salgrade;

--����� �޿� ������ �޿� ��� ���̺��� �̿��Ͽ� �ش����� �޿� ����� ���غ���
SELECT ename, sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal Between salgrade.losal
                  AND salgrade.hisal;

--ANSI����
--ANSI : JOIN WITH ON

SELECT ename, sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal  BETWEEN salgrade.losal
                                        AND salgrade.hisal);        

--emp,dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
--����Ŭ ����
SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e , dept d
where e.deptno = d.deptno
ORDER BY deptno ;
--ANSI
SELECT e.empno, e.ename,deptno,d.dname
FROM emp e JOIN dept d USING (deptno)
ORDER BY deptno;
--NATURAL
SELECT e.empno, e.ename,deptno,d.dname
FROM emp e NATURAL JOIN dept d
ORDER BY deptno;

--emp,dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���(�μ���ȣ�� 10,30�� �����͸� ��ȸ) join0-1
SELECT *
FROM emp;
SELECT *
FROM dept;

SELECT  e.empno,e.ename,d.deptno ,d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno)
WHERE D.deptno IN (10,30);

--emp,dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���  �޿��� 2500�ʰ� JOIN0_2
SELECT  *
FROM dept;
SELECT * 
FROM emp;

SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno)AND sal>=2500;

--join0_3
SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno)
WHERE sal > 2500 AND e.empno >7600;

-- join0_4
SELECT e.empno,e.ename,e.sal,d.deptno,d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno)
AND e.sal >2500 AND e.empno > 7600
AND d.dname = 'RESEARCH';

WHILE ( A=0  ) ; 
--join1
--PROD:PROD_LGU
--LPROD : LPROD_GU;

SELECT *
FROM prod;

SELECT *
FROM lprod;

SELECT lp.lprod_gu, lp.lprod_nm,p.prod_id,p.prod_name
FROM prod p ,lprod lp
WHERE p.prod_lgu = lp.lprod_gu
ORDER BY lp.lprod_gu;

SELECT lp.lprod_gu, lp.lprod_nm,p.prod_id,p.prod_name
FROM prod P JOIN lprod LP ON (p.prod_lgu = lp.lprod_gu)
ORDER BY lp.lprod_gu;

--join 2
--pord : pord_buyer
--buyer : buyer_id

SELECT b.buyer_id,b.buyer_name,p.prod_id,p.prod_name
FROM prod p JOIN buyer b ON (p.prod_buyer = b.buyer_id);

SELECT b.buyer_id,b.buyer_name,p.prod_id,p.prod_name
FROM prod P,buyer b
WHERE p.prod_buyer = b.buyer_id
ORDER BY b.buyer_id;

--join 3
SELECT m.mem_id,m.mem_name,p.prod_id,p.prod_name,c.cart_qty
FROM member m JOIN cart c ON ( m.mem_id = c.cart_member) 
JOIN prod p ON (c.cart_prod = p.prod_id);


--join 8



