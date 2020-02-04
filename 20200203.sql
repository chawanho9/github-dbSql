SELECT *
FROM customer;

SELECT *
FROM product;

SELECT *
FROM cycle;

-- �Ǹ��� : 200-250
-- ���� 2.5�� ��ǰ
-- �Ϸ� : 500~750
-- �Ѵ� : 15500~17500

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
�� ���̺��� ������ �� ���� ������ ���� ��Ű�� ���ϴ� �����͸�
�������� ������ ���̺��� �����͸��̶� ��ȸ �ǰԲ� �ϴ� ���� ���;

�������� : e.mgr = m.empno : KING�� MGR NULL�̱� ������ ���ο� �����Ѵ�
EMP���̺��� �����ʹ� �� 14�������� �Ʒ��� ���� ���������� ����� 15���� �ȴ� (1���� ���ν���)
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e , emp m
WHERE e.mgr = m.empno;

ANSI OUTER ################################################################################
1. ���ο� �����ϴ��� ��ȸ�� �� ���̺��� ���� (�Ŵ��� ������ ��� �翬������ �����Բ�);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno;

RIGHT OUTER�� ����
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON e.mgr = m.empno;

ORACLE OUTER JOIN;#########################################################################
�����Ͱ� ���� ���� ���̺� �÷� �ڿ� (+)��ȣ�� �ٿ��ش�;
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+);
���� SQL�� ANSL (OUTER JOING)���� �����غ�����;
�Ŵ����� �μ���ȣ�� 10���� ������ ��ȸ;
SELECT *
FROM emp;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno AND m.deptno= 10;

�Ʒ� LEFT OUTER ������ ���������� outer ������ �ƴϴ�
�Ʒ� INNER ���ΰ� ����� �����ϴ�;
���⼭���� ���� ;
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = '10';

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = '10';

�Ʒ� ����Ŭ OUTER JOIN
����Ŭ OUTER JOIN �� ���� ���̺��� �ݴ��� ���̺��� ��� �÷��� (+)�� �ٿ���
�������� OUTER JOIN ���� �����Ѵ�
�� �÷��̶� (+)�� �����ϸ� INNER �������� ����;
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

��� - �Ŵ��� RIGHT OUTER JOIN;
SELECT empno, ename, mgr
FROM emp e;

SELECT empno, ename, mgr
FROM emp m;

SELECT e.empno,e.ename, e.mgr, m.empno, m.ename
FROM   emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno);

FULL OUTER : LEFT OUTER + RIGHT OUTER -�ߺ�����; #####################################################
����Ŭ OUTER JOIN������ (+)�̿��Ͽ� FULL OUTER�� ����Ҽ�����
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




