--sub6 다시풀어
SELECT *
FROM cycle 
WHERE cid =1 AnD pid IN (SELECT pid
                        FROM cycle
                        where cid=2
                        group by pid
);

SELECT pid
FROM cycle
WHERE cid=2
GROUP BY pid;

SELECT *
FROM product;

SELECT*
FROM customer;

SELECT c.cid,customer.cnm,c.pid,p.pnm,c.day,c.cnt
FROM cycle c JOIN product p ON (c.pid = p.pid) JOIN customer ON (c.cid= customer.cid)
AND c.cid=1 AND c.pid IN (SELECT cycle.pid
                        FROM cycle
                        WHERE cycle.cid=2
                        GROUP BY pid);





--SELECT pid
--                        FROM cycle
--                        where cid=2
--                        group by pid;
SELECT pid
FROM cycle
where cid=1
group by pid
                   


SELECT PID
FROM cycle
WHERE cid=1
GROUP BY pid;

SELECT *
FROM cycle
WHERE cid=1 
AND pid =(SELECT PID
          FROM cycle
          WHERE cid=2
            );
            -- pid = (값이 두개일경우 두개다 만족해야됨) AND
SELECT *
FROM cycle
WHERE cid = 1 
AND pid IN (SELECT PID
            FROM cycle
            WHERE cid=2
            );
            -- pid IN (값이 두개중 하나만 만족해도 출력) OR         
--sub7 다시풀어 
SELECT *
FROM customer;
SELECT *
FROM cycle;
SELECT *
FROM product;
SELECT cu.cid, cu.cnm,pr.pnm,cy.pid,cy.day,cy.cnt
FROM cycle cy JOIN customer cu ON (cy.cid = cu.cid) JOIN product pr ON(cy.pid = pr.pid)
WHERE cy.cid = 1 
AND cy.pid IN (SELECT PID
            FROM cycle
            WHERE cid=2
            );
            
--매니저가 존재하는 직원을 조회 13개데이터
SELECT * 
FROM EMP;

SELECT mgr
FROM emp 
WHERE mgr IS NOT NULL;

EXSITS 조건에 만족하는 행이 존재 하는지 확인하는 연산자#################################
다른 연산자와 다르게 WHERE 절에 컬럼을 기술하지 않는다
 - WHERE empno = 7369
 - WHERE EXISTS (SELECT 'X'
                 FROM .....);
매니저가 존재하는 직원을 EXISTS 연산자를 통해 조회;
매니저도 직원;

SELECT*
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.mgr);
--sub8 
SELECT *
FROM emp a
WHERE EXIsTS(SELECT 'X'
            FROM emp b
            WHERE  b.empno = a.mgr);
--sub9다시풀어
SELECT * 
FROM cycle;

SELECT * 
FROM product;

SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid=1 
              AND cycle.pid=product.pid);

SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1 
              AND cycle.pid = product.pid);
              
              

--sub11
SELECT*
FROM product;

SELECT *
FROM cycle
WHERE cid =1;

SELECT *
FROM product 
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND cycle.pid=product.pid
              );



SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1 
              AND cycle.pid = product.pid);

집합연산 #####################################################
합집합 : UNION - 중복제거 / UNIALL - 중복을 제거하지 않음(속도 향상)
교집합 : INTERSECT (집합개념)
차집합 : MINUS (집합개념)
집합연산 공통사항
- 두 집합의 컬럼의 개수, 타입이 일치 해야 한다;

동일한 집합을 합집하기 떄문에 중복되는 데이터는 한번만 적용된다
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

UNION ALL 연산자는 UNION 연산자와 다르게 중복을 허용한다.
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

INTERSECT (교집합) : 위. 아래 집합에서 값이 같은 행만 조회
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

MINUS(차집합) : 위 집합에서 아래 집합의 데이터를 제거한 나머지 집합;              
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

집합의 기술 순서가 영향이 가는 집합연산자
A UNION B       = B UNION A ==> 같음 
A UNION ALL B   = B UNION ALL A ==> 같음(집합)
A INTERSECT B   = B INTERSECT A ==> 같음
A MINUS B       = B MINUS A   ==> 다름 

집합연산의 결과 컬럼 이름은 첫번째 집합의 컬럼명을 따른다;
SELECT 'X' fir ,'B' sec
FROM dual

UNION

SELECT 'Y','A'
FROM dual;

정렬 (ORDER BY) 는 집합연산 가장 마지막 집합다음에 기술한다;

SELECT deptno,dname, loc
FORM (SELECT * 
      FROM dept
      WHERE deptno IN (10,20)

UNION ALL

SELECT deptno,dname, loc
FROM dept
WHERE deptno IN (10,20)
ORDER BY deptno;

햄버거 도시 발전지수;

SELECT *
FROM fastfood;

시도,시군구,버거지수;



--대덕수 롯데리아 수 
SELECT count(*) num
FROM fastfood
where sigungu = '대덕구' AND gb = '롯데리아';



SELECT sido,count(*)
FROM fastfood 
WHERE sido like '%대전%'
GROUP BY sido;

분자(KFC, 버거킹, 맥도날드)
SELECT *
FROM
(SELECT sido, sigungu, COUNT(*)
FROM fastfood   
WHERE sido = '대전광역시'
AND GB IN ('KFC','버거킹','맥도날드')
GROUP BY sido, sigungu) a,

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
------------------------------------------------------------------
SELECT * 
FROM (
     SELECT ROWNUM rn,a.*
     FROM
    (SELECT sigungu,ROUND(sum(sal)/sum(people),2) sigungu_pri_sal
    FROM tax
    GROUP BY sido,sigungu
    ORDER BY sigungu_pri_sal DESC) a) a
    
LEFT OUTER JOIN (
     SELECT ROWNUM rn,b.*
    FROM
    (SELECT sido,ROUND(SUM(sal)/sum(people),2) sido_pri_sal
    FROM tax
    GROUP BY sido
    ORDER BY sido_pri_sal DESC)b)b
ON
    (b.rn = a.rn); 
    
SELECT sido,count(*)
FROM fastfood
WHERE gb IN ('맥도날드','버거킹','KFC')
GROUP BY sido
ORDER BY count(*) DESC;

--시도 별 롯데리아 , 나머지  rownum적용
SELECT ROWNUM rn,a.*
FROM 
    (SELECT sido,count(*)
    FROM fastfood
    WHERE gb IN ('맥도날드','버거킹','KFC')
    GROUP BY sido
    ORDER BY count(*) DESC)a;

SELECT ROWNUM rn,b.*
FROM 
    (SELECT sigungu,count(*)
     FROM fastfood
     WHERE gb IN ('맥도날드','버거킹','KFC')
     GROUP BY sigungu
     ORDER BY count(*) DESC)b;
--join하기
SELECT  a.rn,a.sido,a.num3,b.sigungu,b.num3
FROM 
    (SELECT ROWNUM rn,a.*
    FROM 
    (SELECT sido,count(*) num3
    FROM fastfood
    WHERE gb IN ('맥도날드','버거킹','KFC')
    GROUP BY sido
    ORDER BY count(*) DESC)a)a
JOIN
    (SELECT ROWNUM rn,b.*
    FROM 
    (SELECT sigungu,count(*) num3
     FROM fastfood
     WHERE gb IN ('맥도날드','버거킹','KFC')
     GROUP BY sigungu
     ORDER BY count(*) DESC)b)b
ON
    (a.rn=b.rn);


--
SELECT ROWNUM rn,b.*
FROM 
    (SELECT sigungu,count(*) num1
    FROM fastfood
    WHERE gb IN ('롯데리아')
    GROUP BY sigungu
    ORDER BY count(*) DESC)b;

    
SELECT ROWNUM rn,a.*
FROM 
    (SELECT sido,count(*) num1
    FROM fastfood
    WHERE gb IN ('롯데리아')
    GROUP BY sido
    ORDER BY count(*) DESC )a;
--join
SELECT *
FROM (
    SELECT ROWNUM rn,b.*
    FROM 
    (SELECT sigungu,count(*) num1
    FROM fastfood
    WHERE gb IN ('롯데리아')
    GROUP BY sigungu
    ORDER BY count(*) DESC)b)B
JOIN (    
    SELECT ROWNUM rn,a.*
    FROM 
    (SELECT sido,count(*) num1
    FROM fastfood
    WHERE gb IN ('롯데리아')
    GROUP BY sido
    ORDER BY count(*) DESC )a)a
ON (a.rn = b.rn);

--전체조인 
SELECT *
FROM ( 

    SELECT *
    FROM (
            SELECT ROWNUM rn,b.*
            FROM 
                (SELECT sigungu,count(*) num1
                FROM fastfood
                WHERE gb IN ('롯데리아')
                GROUP BY sigungu
                ORDER BY count(*) DESC)b)b
    JOIN 
        (SELECT ROWNUM rn,a.*
        FROM 
            (SELECT sido,count(*) num1
            FROM fastfood
            WHERE gb IN ('롯데리아')
            GROUP BY sido
            ORDER BY count(*) DESC )a)a
    ON 
    (a.rn = b.rn))a; 
---------------------------두개의테이블을 조인할수 없음 : 전체 select 절에서 안에있는 rn을 읽을수없음  그러니까 다른방법 ( 1. exist , 2. 상호연관쿼리)
LEFT OUTER JOIN (;
                                                                    SELECT  *
                                                                    FROM(
                                                                            SELECT ROWNUM rn,a.*
                                                                            FROM 
                                                                                (SELECT sido,count(*) num3
                                                                                FROM fastfood
                                                                                WHERE gb IN ('맥도날드','버거킹','KFC')
                                                                                GROUP BY sido
                                                                                ORDER BY count(*) DESC)a)a
                                                                    JOIN
                                                                        (SELECT ROWNUM rn,b.*
                                                                        FROM 
                                                                            (SELECT sigungu,count(*) num3
                                                                            FROM fastfood
                                                                            WHERE gb IN ('맥도날드','버거킹','KFC')
                                                                            GROUP BY sigungu
                                                                            ORDER BY count(*) DESC)b)b
                                                                    ON
                                                                    (a.rn=b.rn))b;
ON (a.rn_1=b.rn);

select a.sigungu,b.sigungu,ROUND((b.cnt/a.cnt),2)
from (
        select sigungu,count(*) cnt
        from fastfood
        where gb IN ('롯데리아')
        GROUP BY sigungu)a
 join (
        select sigungu,count(*) cnt
        from fastfood
        where gb IN ('버거킹','kfc','맥도날드')
        GROUP BY sigungu)b
on (a.sigungu= b.sigungu)
AND (a.sigungu = b.sigungu);


GROUP BY a.sigungu;      


SELECT a.sido,a.sigungu, round((b.cnt/a.cnt),2)버거지수
FROM 
    (select sido, sigungu,count(*) cnt
    from fastfood
    where gb IN ('롯데리아')
    GROUP BY sigungu, sido)a
    ,    
    (SELECt  sido, sigungu,count(*) cnt
    from fastfood
    WHERE gb IN('버거킹','KFC','맥도날드')
    GROUP BY sigungu, sido)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 버거지수 DESC 
;



--SELECt *
--FROM (
--
--        select count(*) cnt
--        from fastfood
--        where gb IN ('롯데리아')
--        ORDER BY sigungu)a
--    ,
--        (select count(*) cnt
--        from fastfood
--        where gb IN ('버거킹','kfc','맥도날드')
--        ORDER BY sigungu)b
--WHERE a.cnt = b.cnt

    








        select sigungu,SIDO,count(*) cnt
        from fastfood
        where gb IN ('롯데리아')
        GROUP BY sigungu, SIDO;
        
        
         select sigungu,SIDO,count(*) cnt
        from fastfood
        where gb IN ('버거킹','kfc','맥도날드')
        GROUP BY sigungu, SIDO;
    