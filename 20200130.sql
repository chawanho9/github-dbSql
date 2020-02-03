--emp 테이블을 이용하여 deptno에 따라 부서명으로 변경해서 다음과 같이 조회 되는 쿼리를 작성하세요 

SELECT ename, deptno,
        DECODE(deptno, 10 , 'ACCOUNTING'
                     , 20 , 'RESEARCH'
                     , 30 , 'SALES'
                     , 40 , 'OPERATIONS','DDIT') DNAME
FROM emp;

SELECT ename, deptno,
        CASE WHEN deptno = 10 THEN 'ACCOUNTING'
             WHEN deptno = 20 THEN 'RESEARCH'
             WHEN deptno = 30 THEN 'SALSE'
             WHEN deptno = 40 THEN 'OPERATIONS'
             ELSE 'DDIT'
        END DNANME
FROM emp;        

--emp 테이블을 이용하여 hiredate에 따라 올해 건강보험 검진 대상자인지 조회하는 쿼리를 작성하세요
--생년을 기준으로 하나 여기서는 입사년도를 기준으로 한다.
SELECT ename, hiredate , 
        CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2)=0 THEN 'O'
             ELSE 'X'
        END 건강검진_대상자     
FROM emp;

--SELECT empno,ename,hiredate,
--    MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2) hire,
--    MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2),
--    CASE
--        WHEN MOD(TO_NUMBER(TO_CHAR(hiredate , 'YYYY')), 2) = MOD(TO_NUMBER(TO_CHAR(SISDATE, 'YYYY')),2)
--            THEN '대상자'
--            ELSE '비대상자'
--        END CONTACT_TO_DOCTOR,
--        DECODE(MOD(TO_NUMBER(TO_CHAR(

--######################################################################################
--GROUP BY 행을 기준으로 묶음
--부서번호가 같은 ROW끼리 묶는 경우 : GROUP BY deptno
--담당업무가 같은 ROW끼리 묶는 경우 : GROUP BY job
--MRG가 같고 담당업무가 같은 ROW 끼리 묶는경우 : GROUP BY mgr, job

--그룹함수의 종류
--SUM   : 합계
--COUNT : 갯수
--MAX   : 최대값
--MIN   : 최소값
--AVG   : 평균

-- 그룹함수의 특징 
-- 해당 컬럼에 Null값으 갖는 ROW가 존재할 경우 해당 값은 무시하고 계산한다 (NULL 연산의 결과는 NULL)

-- 그룹함수 주의점
--GROUP BY 절에 나온 컬럼이외의 다른컬럼이 SELECT절에 표현되면 에러 
--그룹화와 관련없는 임의의 문자열, 함수, 숫자등은 SELECT절에 나오는 것이 가능


--부서별 급여 합 
SELECT deptno, 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno;

--GOUP BY 절이 없는 상타에서 그룹함수를 사용한 경우 
-- 전체행을 하나의 행으로 묶는다
SELECT 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2),
        COUNT(sal), -- sal컬럼의 값이 null이 아닌 row의 갯수
        COUNT(comm),-- COMM 컬럼의 값중 NULL이 아닌 COMM의 갯수
        COUNT(*) -- 몇건의 데이터가 있는지 
FROM emp;

-- SINGLE ROW FUNCTION의 경우 WHERE 절에서 사용하는 것이 가능하나
-- MULTI ROW FUNCTION의 경우 WHERE 절에서 사용이 불가능하고
-- HAVING 절에서 조건을 기술한다.

-- 부서별 급여 합 조회, 단 급여합이 9000이상인 데이터만 
-- deptno, 급여합 
SELECT deptno, SUM(sal) SUM_SAL
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

--emp테이블의 이용하여 다음을 구하시오
--직원중 가장 높은 급여 
SELECT  MAX(sal),MIN(sal), ROUND(AVG(sal),2),SUM(sal),COUNT(sal),COUNT(mgr),COUNT(ename)
FROM emp;

--부서 기준
SELECT deptno,  MAX(sal),MIN(sal), ROUND(AVG(sal),2),SUM(sal),COUNT(sal),COUNT(mgr),COUNT(ename)
FROM emp
GROUP BY deptno;

SELECT ename, sal
FROM emp
ORDER BY sal DESC;

--emp테이블을 이용하여 다음을 구하시오
SELECT *
FROM   
    (SELECT 
            CASE WHEN deptno=10 THEN 'ACCOUNTING'
                 WHEN deptno=20 THEN 'RESEARCH'
                 WHEN deptno=30 THEN 'SALES'
            END   DNAME  
            ,  MAX(sal),MIN(sal), ROUND(AVG(sal),2),SUM(sal),COUNT(sal),COUNT(mgr),COUNT(*)
        FROM emp
        GROUP BY deptno)
ORDER BY dname;


--ORACLE 9I 이전까지는 GROUP BY절에 기술한 컬럼으로 정렬을 보장
--ORACLE 10I 이후 부터는 GROUP BY절에 기술한 컬럼으로 정렬을 보장 하지 않는다(GROUP BY 연산자 속도UP

--직원의 입사 년월별로 몇명의 직원이 입사했느지 조회
SELECT  TO_CHAR(hiredate , 'YYYY/MM'),COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate , 'YYYY/MM')
ORDER BY TO_CHAR(hiredate , 'YYYY/MM');

--emp테이블을 이용하여 다음을 구하시오
--직원의 입사 년별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성하세요
SELECT  TO_CHAR(hiredate , 'YYYY'),COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate , 'YYYY')
ORDER BY TO_CHAR(hiredate , 'YYYY');

--회사에 존재하는 부서의 개수는 몇개인지 조회하는 쿼리를 작성하시오
SELECT  COUNT(*)
FROM dept;

--직원이 속한 부서의 개수를 조회하는 쿼리를 작성하세요 
SELECT COUNT(*) cnt
FROM (
        SELECT deptno,COUNT(*)
        FROM emp
        GROUP BY deptno);
        
--과제 3
--올해 년도의 짝수 구분과, REG_DT년도의 짝수 구분이 동일하면 -->대상자
--올해 년도의 짝수 구분과, REG_DT년도의 짝수 구분이 동일하지 않으면 -->대상자
SELECT userid, usernm, reg_dt, 
     CASE 
         WHEN MOD(TO_NUMBER(TO_CHAR(reg_dt,'YY')),2) = 0 THEN '비 대상자'
         WHEN MOD(TO_NUMBER(TO_CHAR(reg_dt,'YY')),2) = 1 THEN ' 대상자'
                ELSE 'null'
    END            
     
FROM users
ORDER BY userid;