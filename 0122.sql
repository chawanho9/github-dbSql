--emp 테이블에 존재하는 컬럼을 확인 해보세요
DESC EMP;
--users 테이블에서 userid, usernm, reg_dt 컬럼만 조회하는 sql을 작성하세요 
SELECT userid, usernm, reg_dt
FROM users;
--lprod 테이블에서 lprod_gu, lprod_nm 두 컬럼을 조회하는 쿼리를 작성하시오
DESC lprod;
SELECT lprod_gu,lprod_nm
FROM lprod;
--userid, usernm 컬럼을 결합, 별칭 id_name
DESC users;
SELECT userid || usernm AS id_name
FROM users;
Select '이것이 콘켓이다:' || CONCAT(userid, usernm) AS id_name2
FROM users;
-- emp 테이블에서 deptno (부서번호가)가 30보다 크거나 같은 사원들만 조회
SELECT *
FROM emp
WHERE deptno >= 30;
--입사일자가 1980년 12월 17일 직원만 조회         (투데이투)
SELECT *
FROM emp
WHERE hiredate = TO_DATE('1980/12/17','YYYY/MM/DD');
-- sal 컬럼의 값이 1000에서 2000 사이인 사람
SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000;
--범위연산자를 부등호 대신에 BETWEN AND 연산자로 대체
SELECT *
FROM emp 
WHERE sal 
BETWEEN 1000 AND 2000;
--실습문제 emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 
--1983년 1월1일 이전인 사원의 ename, hiredate 
--단 연산자는 between을 사용한다.
SELECT ename, hiredate
FROM emp
WHERE hiredate 
BETWEEN TO_DATE('19820101','YYYYMMDD') AND TO_DATE(19830101);


