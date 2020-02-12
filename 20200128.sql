-- emp테이블 에서 10번 부서 혹은 30번 부서에 속하는 사람중 급여가 1500이 넘는 사람들만 조회하고 이름으로 내림차순 정렬되도록
SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 30 AND sal >= 1500
ORDER BY  ename DESC;

SELECT *
FROM emp
WHERE deptno IN (20, 30) AND sal > 1500
ORDER BY ename DESC;

-- RWONUM: 행번호 나타내는 컬럼
SELECT ROWNUM, empno, ename
FROM emp
WHERE deptno IN (10, 30)
AND SAL > 1500;
--ROWNUM################################################################################################
--ROWNUM 을 WHERE에서 도 사용가능
--동작하는거 : ROWNUM =1, ROWNUM <= 2  --> ROWNUM =1, ROWNUM <= N
--동작하지 않는거 : ROWNUM = 2,ROWNUM >= 2 ROWNUM = N( N은 1이 아닌 정수) ROWNUM >= N (N은 1이 아닌 정수)
--ROWNUM 이미 읽은 데이터에다가 순서형부여
-- 유의점1 :읽지 않는 상태의 값을 (ROWNUM의 부여되지 않는 행)은 조회할 수가 없다.
-- 유의점2 : 
--사용 용도 : 페이징 처리 
--테이블에 있는 모든 행을 조회하는것이 아니라 우리가 원하는 페이지에 해당하는 행 데이터만 조회를 한다
--페이징 처리시 고려사항 : 1페이지당 건수, 정렬기준
--emp테이블 총 row 건수 : 14
--페이지당 5건의 데이터를 조회
-- 1page : 1~5
-- 2page : 6-10
-- 3page : 11~15
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM <= 2;

--page 
SELECT ROWNUM rn, empno,ename
FROM emp
ORDER BY ename;

-- 정렬된 결과의 ROWNUM을 부여 하기 위해서는 IN- LINE VIEW을 사용한다.
-- 요점정리 : 1.정렬 , 2.ROWNUM부여 

SELECT empno, ename
FROM emp
ORDER BY ename;

-- SELECT *를 기술할 경우 다른 EXPRESSION을 표기 
-- 하기 위해서 테이블명.*로 표현해야한다.
SELECT ROWNUM, emp.*
FROM emp;

--FROM 절 에서 테이블명  별칭가능
SELECT ROWNUM rn, e.*
FROM emp e;

-- ROWNUM = rn 
-- *page size : 5 , 정렬기준은 ename
-- 1 page : rn 1~5
-- 2 page : rn 5~10
-- 3 page : rn 11~15
-- n page : rn (page-1) * pageSize + 1 ~ page * pageSize
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE rownum <= 10;

SELECT ROWNUM rn, emp.*
FROM emp
where ROWNUM<=10;

SELECT *
FROM
    (SELECT ROWNUM rn, a.*
    FROM 
        (SELECT empno, ename 
    FROM emp
    ORDER BY ename) a )    
--WHERE rn >= 1 AND rn <= 5;
WHERE rn BETWEEN (1 - 1) * 5  AND 1 * 5;

--row_1)emp 테이블에서 ROWNUM 값이 1~10인 값만 조회하는 쿼리르 작성하라 (정렬없지 진행)

SELECT*
FROM
(SELECT ROWNUM rn, emp.*
FROM emp) 
where rn<=10;

--다시풀어 
--sem
SELECT *
FROM 
    (SELECT ROWNUM rn, empno, ename
    FROM emp)
WHERE rn <= 10;

SELECT *
FROM 
    (SELECT ROWNUM rn, empno, ename
    FROM emp)
WHERE rn <= 10;    

--row_2)ROWNUM값이 11~ 20 인 값만 조회하시오
SELECT *
FROM 
    (SELECT ROWNUM rn, empno, ename
    FROM emp)
WHERE rn BETWEEN 11 AND 20;

--row_3)emp 테이블의 사원 정보를 이름컬럼으로 오름차순 적용했을때의 11~14번쨰 행을 작성하시오
--아스테리크스 외의 다르 이스테릭션? 뽑을떄 x.*
--rownum이 where절에서 사용할수없기떄문에한번더 감싼다
SELECT *
FROM ( 
    SELECT ROWNUM RN, empno, ename
    FROM emp)
WHERE  rn BETWEEN 11 AND 14
ORDER BY  empno;

SELECT *
FROM 
    (SELECT ROWNUM rn, a.*
    FROM 
        (SELECT  empno, ename
        FROM emp
        ORDER BY ename)a) 
WHERE rn BETWEEN (:page-1) * :pageSize + 1 AND :page * :pageSize ;  
--(page-1) * pageSize + 1 ~ page * pageSize
--매서드##############################################################################여기부터
-- DUAL 테이블 : 데이터와 관계없이, 함수를 테스트해볼 목적으로 사용
--문자의 대소문자 : LOWER, UPPER, INITCAP
SELECT LOWER ('Hello, world'), UPPER('Hello, world'),  INITCAP('Hello, world')
FROM dual;
--함수는 WHERE절에서도 사용 가능
--사원 이름이 SMITH인 사람만 조회
--바인딩변수(자바변수)는 앞에 : 붙여주면댐 
SELECT *
FROM emp
WHERE ename = UPPER(:ename);
--SQL작성시 아래 형태는 지양 해야한다.
--테이블의 컬럼을 가공하지 않는 형태로 SQL을 작성한다.
SELECT *
FROM emp
WHERE LOWER(ename) = :ename;

--
SELECT CONCAT ('Hello',', world') CONCAT,
       SUBSTR('Hello, World', 1, 5) SUB,
       LENGTH('Hello, World') len, 
       INSTR('Hello, World', 'l',5) ins, --특정 문자를 원하는 부분에서 찾기
       LPAD('Hello, World', 15, '*')LP, --원하는 크기많큼 원하는 문자로 왼쪽에서채우기
       RPAD('Hello, World', 15, '*')RP, --원하는 크기많큼 원하는 문자로 오른쪽에서채우기
       REPLACE('Hello, World', 'H','T') REP, --특정 문자열을 원하는 문자로 변경하기
       TRIM('d' FROM 'Hello, World') TR    --앞뒤 공백 제거하기//특정문자 제거 
FROM dual;

--숫자 함수
--ROUND : 반올림 (10.6을 소수점 첫번쨰 자리에서 반올림 --> 11)
--TRUNC : 절삭(버림) ( 10.6을 소수점 첫번쨰 자리에서 절삭 --> 10)
--ROUD , TRUNC l 몇번쨰 자리에서 반올림/절삭
--MOD : 나머지 연산( 몫이 아니라 나누기 연산을 한 나머지 값 ) (13/5 => 몫 : 2, 나머지 3)

--ROUND (대상 숫자, 작용 결과 자리 )
SELECT ROUND(105.54,1) ROUND, -- 반올림 결과가 소수점 1번째 자리 까지 나오도록  --> 두번쨰 자리에서 반올림 
       ROUND(105.56,1), 
       ROUND(105.56,0), -- 반올림 결과가 정수부만 --> 소수점 첫번쨰 자리에서 반올림 
       ROUND(105.55,-1), --반올림 결과가 십의 자리까지 --> 일의 자리에서 반올림
       ROUND(105.55)    -- 두번째 인자를 입력하지 않는 경우 0이 적용
FROM dual;

SELECT TRUNC(105.54, 1),  -- 절삭의 결과가 소수점 첫번째 자리까지 나오도록 --> 두번째 자리에서 절삭 
       TRUNC(105.55, 1),  -- 절삭의 결과가 소수점 첫번쨰 자리까지 나오도록 --> 소수점 두번쨰 자리에서 절삭
       TRUNC(105.55, 0),  -- 절삭의 결과가 정수부(일의자리) 까지 나오도록 --> 소수점 첫번쨰 자리에서 절삭
       TRUNC(105.55, -1), -- 절삭의 결과가 10의 자리 까지 나오도록 일의자리에서 절삭
       TRUNC(105.55)      -- 두번째 인자를 입력하지 않을 경우 0이 적용 
FROM dual;

--EMP테이블에서 사원의 급여(sal)를 1000으로 나눴을 떄 몫을 구하세요 
SELECT ename, sal , TRUNC(sal/ 1000), MOD(sal , 1000) --mod의 결과를 divisor보다 항상작다
FROM emp;

DESC emp;

-- 년도 2자리/월 2자리/일자 2자리 
SELECT ename, hiredate
FROM emp;

--SYSDATE : 현재 오라클 서버의 시분초가 포함된 날짜 정보를 리턴하는 특수 함수 
--data = + 정수 = 일자 연산
-- 1 = 하루
-- 1시간 = 1/24
--2020/01/28 + 5

--숫자 표기 : 숫자
--문자 표기 : 싱글 쿼테이션 + 문자열 + 싱클 쿼테이션 = '문자열'
--날짜 표기 : TO_DATE('문자열 날짜 값','문자열 나짜값의 표기 형식' --> TO_DATE('2020-01-28', 'YYYY-MM-DD')

SELECT SYSDATE +5, SYSDATE + 1/24 
FROM dual;

--fn 1 
--1. 2019년 12월 31일을 date형으로 표현
--2. 2019년 12월 31일을 date형으로 표현하고 5일 이전 날짜
--3. 현재 날짜 
--4. 현재 날짜에 3일 전 값 
--위 4개 컬럼을 생성하여 다음과 같이 조회하는 쿼리를 작성하세요 
SELECT TO_DATE('2019/12/31' , 'YYYY/MM/DD'), TO_DATE('2019/12/31' , 'YYYY/MM/DD')-5,SYSDATE, SYSDATE-3
FROM dual;

     
