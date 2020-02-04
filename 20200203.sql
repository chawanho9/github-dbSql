SELECT *
FROM customer;

SELECT *
FROM product;

SELECT *
FROM cycle;

-- 판매점 : 200-250
-- 고객당 2.5개 제품
-- 하루 : 500~750
-- 한달 : 15500~17500

SELECT *
FROM daily;

SELECT *
FROM batch;
--join 4
SELECT c.cid,c.cnm,cy.pid,cy.day,cy.cnt
FROM customer c ,cycle  cy
WHERE c.cid = cy.cid AND (cnm = 'brown' OR cnm = 'sally');

--join 5
SELECT c.cid,c.cnm,cy.pid,p.pnm,cy.day,cy.cnt
FROM customer c ,cycle  cy,product p
WHERE c.cid = cy.cid AND cy.pid = p.pid  AND (cnm = 'brown' OR cnm = 'sally');

--join 6
SELECT c.cid,c.cnm,cy.pid,p.pnm,SUM(cy.cnt)
FROM customer c ,cycle  cy,product p
WHERE c.cid = cy.cid AND cy.pid = p.pid
GROUP BY c.cid,c.cnm,cy.pid,p.pnm;

--join 7
SELECT cy.pid,p.pnm,SUM(cy.cnt)
FROM customer c ,cycle  cy,product p
WHERE c.cid = cy.cid AND cy.pid = p.pid
GROUP BY cy.pid,p.pnm;

--OUTER JOIN ############################################################
--1.LEFT OUTER JOIN
--2.FIGHET OUTER JOIN
--3.FULL OUTER JOIN(LEFT + RIGHT)

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e , emp m
WHERE e.mgr = m.empno;

SELECT *
FROM emp;

OUTER JOIN;
두 테이블을 조인할 떄 연결 조건을 만족 시키지 못하는 데이터를
기준으로 지정한 테이블의 데이터만이라도 조회 되게끔 하는 조인 방식;

연결조건 : e.mgr = m.empno : KING의 MGR NULL이기 떄문에 조인에 실패한다
EMP테이블의 데이터는 총 14건이지만 아래와 같은 쿼리에서는 결과가 15건이 된다 (1건이 조인실패)
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e , emp m
WHERE e.mgr = m.empno;

ANSI OUTER ################################################################################
1. 조인에 실패하더라도 조회가 될 테이블을 선정 (매니저 정보가 없어도 사연정보는 나오게끔);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno;

RIGHT OUTER로 변경
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON e.mgr = m.empno;

ORACLE OUTER JOIN;#########################################################################
데이터가 없는 쪽의 테이블 컬럼 뒤에 (+)기호를 붙여준다;
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+);
위의 SQL을 ANSL (OUTER JOING)으로 변경해보세요;
매니저의 부서번호가 10번인 직원만 조회;
SELECT *
FROM emp;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno AND m.deptno= 10;

아래 LEFT OUTER 조인은 실질적으로 outer 조인이 아니다
아래 INNER 조인과 결과가 동일하다;
여기서부터 오류 ;
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = '10';

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = '10';

아래 오라클 OUTER JOIN
오라클 OUTER JOIN 시 기준 테이블의 반대편 테이블의 모든 컬럼에 (+)를 붙여야
정상전인 OUTER JOIN 으로 동작한다
한 컬럼이라도 (+)를 누락하면 INNER 조인으로 동작;
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

사원 - 매니저 RIGHT OUTER JOIN;
SELECT empno, ename, mgr
FROM emp e;

SELECT empno, ename, mgr
FROM emp m;

SELECT e.empno,e.ename, e.mgr, m.empno, m.ename
FROM   emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno);

FULL OUTER : LEFT OUTER + RIGHT OUTER -중복제거; #####################################################
오라클 OUTER JOIN에서는 (+)이용하여 FULL OUTER를 사용할수없음
SELECT e.empno,e.ename, e.mgr, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

--OUTERJOIN 1
SELECT *
FROM buyprod
WHERE buy_date = TO_DATE('2005/01/25','YYYY/MM/DD') ;
SELECT *
FROM prod;

SELECT *
FROM buyprod 
where buy_date = TO_DATE('2005/01/25','YYYY/MM/DD') ;
--1
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_date
FROM buyprod b RIGHT OUTER JOIN prod p ON p.prod_id = b.buy_prod AND b.buy_date = to_date('20050125','yyyymmdd');


SELECT *
FROM buyprod;

SELECT *
FROM prod;
--2
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = to_date('20050125','yyyymmdd');

--outer join 2
SELECT to_date('20050125','yyyymmdd'), b.buy_prod, p.prod_id, p.prod_name,b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON p.prod_id = b.buy_prod AND b.buy_date = to_date('20050125','yyyymmdd');




