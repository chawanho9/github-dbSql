SELECT ename,deptno
FROM emp;

SELECT *
FROM dept;


-- JOIN 두 테이블을 연결하는 작업
-- JOIN 문법 
-- 1.ANSI 문법
-- 2.ORACLE 문법

--1. Natural Join##############################
-- 두 테이블 간 컬럼명이 같을 떄 해당 컬럼으로 조인 
-- emp, dept 테이블에는 deptno 라는 컬럼이 존재
SELECT *
FROM emp NATURAL JOIN dept;

--Natural join에 사용된 조언 컬럼(deptno)는 한정자(ex: 테이블명, 테이블 별칭)을 사용하지 않고 컬럼명만 기술한다.
--ex) dept.deptno --> deptno

SELECT emp.empno,emp.ename, dept.dname,deptno
FROM emp NATURAL JOIN dept;

--테이블에 대한 별칭도 사용가능
SELECT e.empno,e.ename, d.dname,deptno
FROM emp e NATURAL JOIN dept d;

--2. ORACLE JOIN ###################################
--FROM 절에 조인할 테이블 목록을 ,로 구분하여 나열한다
--조인할 테이블의 연결조건을 WHERE절에 기술한다.
--emp, dept 테이블에 존재하는 deptno 컬러밍 (같을떄) 조인
SELECT *
FROM emp;
SELECT emp.ename,dept.dname,emp.deptno,dept.deptno
FROM emp, dept 
WHERE emp.deptno != dept.deptno; --부서번호가 다를떄 조인해라
SELECT emp.ename,dept.dname,emp.deptno,dept.deptno
FROM emp, dept 
WHERE emp.deptno != dept.deptno;

--SELECT TABLE(

--오라클 조인의 테이블 별칭

SELECT e.empno,e.ename,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI : join with USING 
--조인 하려는 두개의 테이블에 이름이 같은 컬럼이 두개이지만 
--하나의 컬럼으로만 조인을 하자고 할떄
--조인하려는 기준 컬럼을 기술
--emp, dept 테이블의 공통 컬럼 : deptno
SELECT * FROM emp;
SELECT * FROM dept;
SELECT deptno, e.empno, e.ename
FROM emp e JOIN dept d USING (deptno);

SELECT emp.ename,dept.dname,deptno
FROM emp JOIN dept USING(deptno);

--JOIN WITH UING을 ORACLE로 표현하면?;
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--조인하려고하는 테이블의 컬럼의 이름이 서로 다를떄
SELECT emp.ename, dept.dname, dept.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--SELF JOIN :같은 테이블간의 조인 
--emp 테이블에서 관리되는 사원의 관리자 사번을 이용하여 관리자 이름을 조회할떄
SELECT e.empno,e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

--오라클 문법으로 작성
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--equal 조인 : =
--non-eqaul 조인 : !=, >,<, BETWEEN AND

SELECT ename
FROM emp;

SELECT *
FROM salgrade;

--사원의 급여 정보와 급여 등급 테이블을 이용하여 해당사원의 급여 등급을 구해보자
SELECT ename, sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal Between salgrade.losal
                  AND salgrade.hisal;

--ANSI문법
--ANSI : JOIN WITH ON

SELECT ename, sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal  BETWEEN salgrade.losal
                                        AND salgrade.hisal);        

--emp,dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요
--오라클 문법
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

--emp,dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요(부서번호가 10,30인 데이터만 조회) join0-1
SELECT *
FROM emp;
SELECT *
FROM dept;

SELECT  e.empno,e.ename,d.deptno ,d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno)
WHERE D.deptno IN (10,30);

--emp,dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요  급여가 2500초과 JOIN0_2
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



