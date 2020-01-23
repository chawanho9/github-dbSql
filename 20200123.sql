--조건에 맞는 데이터 조회하기 ( >=, >, <=, < 실습 where2)
--emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월1일 이전인 사원의
--ename, hiredate 데이터를 조회하는 쿼리를 작성하시오 
SELECT ename,'19' || hiredate AS hiredate
FROM emp
where hiredate 
BETWEEN  TO_DATE('19820101','YYYYMMDD') AND TO_DATE('19830101','YYYYMMDD');

--WHERE 절에 기술하는 조건에 순서는 조회 결과에 영향을 미치지 않는다.
--SQL은 집합의 개념을 갖고 있다.
--집합 : 키가 185cm 이상이고 몸무게가 70kg 이상인 사람들의 모임
--      -->몸무게가 70kg 이상이고 키가 185cm 이상인 사람들의 모임
--집합의 특징 : 집합에는 순서가 없다
--(1, 5, 10) --> (10, 5, 1) : 두 집합은 서로 동일하다
--테이블에는 순서가 보장되지 않음
--SELECT 결과가 순서가 다르더라도 값이 동일하면 정답

-- IN 연산자
-- 특징 집합에 포함되는지 여부를 확인
-- 부서번호가 10번 혹은 20번에 속하는 직원 조회
SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10, 20);

--IN 연산자를 사용하지 않고 OR 연산자 사용
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10
OR deptno = 20;

-- emp테이블에서 사원이름이 SMITH, JONES 인 직원만 조회 (empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp
WHERE ename IN ('SMITH', 'JONES');

SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'JONES';

-- users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회 하시오
-- (IN 연산자 사용)
SELECT userid, usernm, '별명' AS 별명
FROM users
WHERE userid IN ('brown', 'cony', 'sally');


