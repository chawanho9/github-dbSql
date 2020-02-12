
--대덕수 롯데리아 수 
SELECT count(*) num
FROM fastfood
where sigungu = '대덕구' AND gb = '롯데리아';



SELECT sido,count(*)
FROM fastfood 
WHERE sido like '%대전%'
GROUP BY sido;

분자(KFC, 버거킹, 맥도날드);
SELECT *
FROM
(SELECT sido, sigungu, COUNT(*)
FROM fastfood   
WHERE sido = '대전광역시'
AND GB IN ('KFC','버거킹','맥도날드')
GROUP BY sido, sigungu) a;

대전광역시	중구	7
대전광역시	동구	4
대전광역시	서구	17
대전광역시	유성구	4
대전광역시	대덕구	2;

대전시군구별 롯데리아 
SELECT  a.sido,a.sigungu,ROUND(c1/c2,2) hambuger_score
FROM
(SELECT sido, sigungu, COUNT(*) c1
FROM fastfood   
WHERE sido = '대전광역시'
AND GB IN ('KFC','버거킹','맥도날드')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) c2
FROM fastfood   
WHERE sido = '대전광역시'
AND GB IN ('롯데리아')
GROUP BY sido, sigungu)b
WHERE a.sido= b.sido
AND a.sigungu = b.sigungu
ORDER BY hambuger_score DESC;
두개의 테이블을 컬럼으로 확장하려면 JOIN 사용;


fastfood 테이블을 한번만 읽는 방식으로 작성하기;

SELECT sido,sigungu,ROUND((kfc+burgerking+mac )/lot,2) burger_score
FROM
(SELECT sido, sigungu, 
                    NVL(sum(DECODE(gb, 'KFC', 1)),0)kfc,  
                    NVL(sum(DECODE(gb, '버거킹',1)),0)burgerking,
                    NVL(sum(DECODE(gb, '맥도날드',1)),0) mac,
                    NVL(sum(DECODE(gb, '롯데리아',1)),1) lot                   
FROM fastfood
WHERE gb IN('kfc','버거킹','맥도날드','롯데리아')
GROUP BY sido, sigungu)
ORDER BY  burger_score DESC;

SELECT*
FROM fastfood
WHERE sido = '경기도'
AND sigungu = '구리시';

햅머거 지수, 개인별 근로소득 금액 순위가 같은 시도별로 (조인)
지수, 개인별 근로소득 금액으로 정렬후 ROWNUM을 통해 순위를 부여 
같은순위의 행끼리 조인 
햄버거지수 시도, 햄버거지수 시군구, 햄버거지수, 세금 시도, 세금시군구,개인별 근로소득액
SELECT ROWNUM,a.*
FROM
    (SELECT sigungu,ROUND(sum(sal)/sum(people),2) sigungu_pri_sal
    FROM tax
    GROUP BY sido,sigungu
    ORDER BY sigungu_pri_sal DESC) a;
 
 SELECT ROWNUM,b.*
 FROM
    (SELECT sido,ROUND(SUM(sal)/sum(people),2) sido_pri_sal
    FROM tax
    GROUP BY sido
    ORDER BY sido_pri_sal DESC)b;

SELECT *
    FROM 
    (SELECT ROWNUM rn ,a.*
    FROM
        (SELECT sigungu,ROUND(sum(sal)/sum(people),2) sigungu_pri_sal
        FROM tax
        GROUP BY sido,sigungu
        ORDER BY sigungu_pri_sal DESC) a) a
        
        LEFT OUTER JOIN
        
    ( SELECT ROWNUM rn ,b.*
     FROM
        (SELECT sido,ROUND(SUM(sal)/sum(people),2) sido_pri_sal
        FROM tax
        GROUP BY sido
        ORDER BY sido_pri_sal DESC) b) b 
        
        ON(a.rn = b.rn);
        
DML - INSERT##############################################
DESC emp;
empno 컬럼은 NOTNULL 제약 조건이 있다 -INSERT 시 반드시 값이 존재해야 정상적으로 입력된다.
empno 컬럼을 제외한 나머지 컬럼은 NULLABLE 이다 (NULL 값이 저장될 수 있다);
INSERT INTO emp (empno,ename,job)
VALUES (9999,'brown','NULL');

insert into emp(empno,ename,job) values (9949,'wano','개발자');
SELECT*
FROM emp;
rollback;
INSERT INTO emp(ename,job)
VALUES ('saaly','SALESMAN');

문자열 : '문자열' == > "문자열"
숫자 : 10
날짜 : TO_DATE('20200206','YYYYMMDD'), SISDATE;

emp 테이블의 hiredate 컬럼은 date 타입
emp 테이블의 3개의 컬럼에 값을 입력;
DESC emp;
INSERT INTO emp
VALUES (9999,'sally','SALESMAN',NULL,SYSDATE,10000,NULL,99);
ROLLBACK;

여러건의 데이터를 한번에 INSERT;
INSERT INTO 테이블명 (컬럼명),컬럼명2...)
SELECT ...
FROM ;

INSERT INTO emp
SELECT 9999,'sally','SALESMAN',NULL,SYSDATE,10000,NULL,99
FROM dual
    UNION ALL
SELECT 9999,'brown','CLERK',NULL, TO_DATE('20200205','YYYYMMDD'),1100,NULL,99
FROM dual;

SELECT*
FROM EMP;

UPDATE 쿼리
UPDATE 테이블명 컬럼명 1 = 갱신할 컬럼 값1, 컬럼명2 = 갱신할 컬럼 값 , ....
where 행 제한 조건 
업데이트 쿼리 작성시 WHERE 절이 존재하지 않으면 해당 테이블의 
모든 행을 대상으로 업데이트가 일어난다
UPDATE, DELETE 절에 WHERE 절이 없으면 다시한번 확인한다
WHERE 절이 있다고 하더라도 해당 조건으로 해당 테이블을 SELECT 하는 쿼리를 작성하여 실행하면
UPDATE 대상 행을 조회 할 수 있으므로 확인 하고 실행하는 것도 사고 발생 방지에 도움이 된다;

99번 부서번호를 갖는 부서 정보가 DEPT테이블에 있는상황 
INSERT INTO dept VALUE (99,'ddit','daejeon');
COMMIT;

SELECT *
FROM dept;

99번 부서번호를 갖는 부서의 dname 컬럼의 값을 '대덕IT', loc 컬럼의 값을 '영민빌딩'으로 업데이트;

--update##############################
UPDATE dept SET dname ='대덕IT', loc='영민빌딩'
WHERE deptno = 99;

SELECT *
FROM dept;
ROLLBACK;

실수로 WHERE 절을 기술하지 않았을 경우;
UPDATE dept SET dname ='대덕IT', loc='영민빌딩';
WHERE deptno = 99;

여사님-시스템 번호를 잊어먹음 ==> 한달에 한번씩 모든 여사님을 대상으로
                               본인 주민번호 뒷자리로 비밀번호를 업데이트 
시스템 사용자 : 여사님(12,000), 영입점(550, 직원(1,300)
UPDATE 사용자 SET 비밀번호 = 주민번호 뒷자리
WHERE 사용자구분= '여사님';
COMMIT;

10 ==> subquery ;
SMITH, WARD가 속한 부서에 소속된 직원 정보;
SELECT *
FROM emp 
WHERE deptno IN (SELECT deptno
                 from EMP
                 WHERE ename IN ('SMITH','WARD'));

UPDATE에서도 서브 쿼리 사용이 가능;
INSERT INTO emp (empno,ename) VALUES (9999,'brown');
9999번 사원 deptno, job 정보를 SMITH 사원이 속한 부서정보, 담당업무로 업데이트;

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
                job=(SELECT job FROM emp WHERE ename='SMITH')
WHERE empno= 9999;

SELECT *
FROM emp;

DELETE SQL : 특정 행을 삭제
DELETE (FROM) 테이블명
WHERE 행제한 조건 ;

SELECT *
FROM dept;

99번 부서번호에 해당하는 부서 정보 삭제
DELETE dept
WHERE deptno =99;
COMMIT;

SUBQUERY를 통해서 특정 행을 제한하는 조건을 갖는 DELECT
매니저가 7698 사번인 직원을 삭제하는 쿼리를 작성 ;
DELETE emp
WHERE empno IN (7499,7521,7654,7844,7900);

DELETE emp 
WHERE empno IN (SELECT empno FROM emp WHERE mgr= 7698);
SELECT*
FROM emp;
ROLLBACK;