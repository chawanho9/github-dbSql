CROSS JOIN ==> (Cartesian product)
조인하는 두 테이블의 연결 조건이 누락되는 경우
가능한 모든 조합에 대해 연결(조인)이 시도
dept(4),emp(14)의 CROSS JOIN 의 결과는 4*14=56 건
dept 테이블과 emp테이블을 조인을 하기위해 FROM절에 두개의 테이블을 기술
WHERE절에 두 테이블의 연결 조건을 누락;

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

SUBQUERY : 쿼리 안에 다른 쿼리가 들어가 있는 경우 
SUBQUERY가 사용된 위치에 따라 3가지로 분류


SELECT 절 : SCALAR SUBQUERY (하나의 행 , 하나의 컬럼만 리턴해야 에러가 발생하지 않음)
FROM 절 : INLINE - VIEW
WHERE 절 : SUB QUERY

구하조가하는것
SMITH가 속한 부서에 속하는 직원들의 정보를 조회;
1.SMITH가 속한 부서 번호를 구한다.
2. 1번에서 구한 부서 번호에 속한 직원들 정보를 조회한다

1-1;
SELECT *
FROM emp
WHERE ename IN 'SMITH';

1-2 1번에서 구한 부서번호를 이용하여 해당 부서에 속하는 직원 정보를 조회;
SELECT *
FROM emp
WHERE deptno = 20;

SUBQUERY를 이용하면 두개의 쿼리를 동시에 하나의 SQL로 실행이 가능 

SELECT *
FROM emp
WHERE deptno =  ( SELECT deptno 
                  FROM emp
                  WHERE ename = 'SMITH');

--sub1
--평균 급여보다 높은 급여를 받는 직원의 수를 조회하세요
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


다중행 연산자 
IN : 서브쿼리의 여러행중 일치하는 값이 존재 할 떄 
ANY (활용도는 다소 떨어짐):서브쿼리의 여러행중 한행이라도 조건을 만족할떄
ALL (활용도는 다소 떨어짐):서브쿼리의 여러행중 모든행에 대해 조건을 만족할떄;

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

SMITH,WARD 사원의 급여보다 급여가 작은 직원의 조회 ;
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
             
SMITH,WARD 사원의 급여보다 급여가 높은 직원을 조회(SMITH , WARD의 급여 2가지 모두에 대해 작을떄
1250보다 급여가 높은사람
SELECT * 
FROM emp
WHERE sal> ALL(select sal
               FROM EMP
               where ENAME IN ('SMITH','WARD'));
               
IN,NOT IN 의 NULL 과 관련된 유의 사항;

직원의 관리자 사번이 7902 이거나(OR) null;
SELECT *
FROM emp
WHERE mgr IN ( 7902 , null);


NULL비교는 = 연산자가 아니라 IS NUL 로 비교 해야하지만 IN 연산자는 =로 계산 ;
NULL 값이 있을경우 IN 연산자 사용은 조심 !!!!!!!!!!;
SELECT *
FROM emp
WHERE mgr = 7902 OR mgr = null;

empno NOT IN (7902 , NULL) ==> AND
사원번호가 7902가 아니면서 (AND) NULL 이 아닌 데이터
SELECT *
FROM emp
WHERE empno NOT IN (7902, NULL);

SELECT *
FROM emp
WHERE empno != 7902
AND empno IS NOT NULL;

pairvise (순서쌍)
순서쌍의 결과를 동시에 만족 시킬떄;
(mgr , deptno)
7698,30  7683,30
SELECT *
FROM emp
WHERE (mgr, deptno) IN SELECT mgr, empno
FROM emp
WHERE empno IN (7499,7782); 

non - parirwise는 순서쌍을 동시에 만족시키지 않는 형태로 작성 
mgr값이 7696dlrjsk 7839 이면서
deptno가 10이거나 310번이 직원
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
                
스칼라 서브쿼리 : SELECT 절에 기술 , 1개의 ROW ,1개의 COL 을 조회하는 쿼리;
스칼라 서브쿼리는 MAIN 쿼리의 컬럼을 사용하는게 가능하다;

SELECT (SELECT SYSDATE FROM dual), dept.*
FROM dept;

SELECT empno,ename, deptno, 
       (SELECT dname 
       FROM dept 
       WHERE deptno = emp.deptno ) dname
FROM emp;

INLINE VIEW : FROM 절에 기술되는 서브쿼리;

MAIN 쿼리의 컬럼은 SUBQUERY에서 사용 하는지 유의에 따른 분류
사용 할 경우 : CORRELATED SUBQURY(상호 연관 쿼리), 서브 쿼리만 단독으로 실행하는게 불가능
             실행순서가 정해져있다. (MAIN > SUB)
사용 하지 않을 경우 : NON-CORELATED SUBQUERY(비상호 연관 서브쿼리), 서브쿼리만 단독으로 실행 가능 
                    실행순서가 정해져있지 않다.
모든직원의 급여 평균보다 급여가 높은 사람을 조회
SELECT * 
FROM emp 
WHERE sal > (SELECT AVG(sal)
             FROM emp);
    
직원이 속한 부서의 급여 평균보다 급여가 높은 사람을 조회;
SELECT  e.eanem, e.sal
FROM emp e JOIN emp m ON (e.; 

SELECT * 
FROM emp m
WHERE sal >  (SELECT AVG(sal)
             FROM emp s
             WHERE s.deptno = m.deptno);

위의 문제를 조인을 이용해 풀어보자
1. 조인 테이블 선정 
    emp, 붓별 급여 평균 (inline view);
    
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
데이터 추가;
INSERT INTO dept VALUES (99, 'ddit','daejeon');
COMMIT;

DELETE dept 
WHERE deptno =99;

SELECT * 
FROM dept;

ROLLBACK; 트랜잭션 취소 
COMMIT; 트랜잭션 확정 

--sub4
dept 테이블에는 신규 등록된 99번 부서에 속한 사람은 없음
직원이 속하지 않은 부서를 조회하는 쿼리르 작성해보세요;
SELECT * 
FROM emp;

SELECT * 
FROM dept;

SELECT* 
FROM dept
WHERE deptno NOT IN (select deptno FROM emp); --비상호연관

               