--sub6 �ٽ�Ǯ��
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
            -- pid = (���� �ΰ��ϰ�� �ΰ��� �����ؾߵ�) AND
SELECT *
FROM cycle
WHERE cid = 1 
AND pid IN (SELECT PID
            FROM cycle
            WHERE cid=2
            );
            -- pid IN (���� �ΰ��� �ϳ��� �����ص� ���) OR         
--sub7 �ٽ�Ǯ�� 
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
            
--�Ŵ����� �����ϴ� ������ ��ȸ 13��������
SELECT * 
FROM EMP;

SELECT mgr
FROM emp 
WHERE mgr IS NOT NULL;

EXSITS ���ǿ� �����ϴ� ���� ���� �ϴ��� Ȯ���ϴ� ������#################################
�ٸ� �����ڿ� �ٸ��� WHERE ���� �÷��� ������� �ʴ´�
 - WHERE empno = 7369
 - WHERE EXISTS (SELECT 'X'
                 FROM .....);
�Ŵ����� �����ϴ� ������ EXISTS �����ڸ� ���� ��ȸ;
�Ŵ����� ����;

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
--sub9�ٽ�Ǯ��
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

���տ��� #####################################################
������ : UNION - �ߺ����� / UNIALL - �ߺ��� �������� ����(�ӵ� ���)
������ : INTERSECT (���հ���)
������ : MINUS (���հ���)
���տ��� �������
- �� ������ �÷��� ����, Ÿ���� ��ġ �ؾ� �Ѵ�;

������ ������ �����ϱ� ������ �ߺ��Ǵ� �����ʹ� �ѹ��� ����ȴ�
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

UNION ALL �����ڴ� UNION �����ڿ� �ٸ��� �ߺ��� ����Ѵ�.
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

INTERSECT (������) : ��. �Ʒ� ���տ��� ���� ���� �ุ ��ȸ
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

MINUS(������) : �� ���տ��� �Ʒ� ������ �����͸� ������ ������ ����;              
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

������ ��� ������ ������ ���� ���տ�����
A UNION B       = B UNION A ==> ���� 
A UNION ALL B   = B UNION ALL A ==> ����(����)
A INTERSECT B   = B INTERSECT A ==> ����
A MINUS B       = B MINUS A   ==> �ٸ� 

���տ����� ��� �÷� �̸��� ù��° ������ �÷����� ������;
SELECT 'X' fir ,'B' sec
FROM dual

UNION

SELECT 'Y','A'
FROM dual;

���� (ORDER BY) �� ���տ��� ���� ������ ���մ����� ����Ѵ�;

SELECT deptno,dname, loc
FORM (SELECT * 
      FROM dept
      WHERE deptno IN (10,20)

UNION ALL

SELECT deptno,dname, loc
FROM dept
WHERE deptno IN (10,20)
ORDER BY deptno;

�ܹ��� ���� ��������;

SELECT *
FROM fastfood;

�õ�,�ñ���,��������;



--����� �Ե����� �� 
SELECT count(*) num
FROM fastfood
where sigungu = '�����' AND gb = '�Ե�����';



SELECT sido,count(*)
FROM fastfood 
WHERE sido like '%����%'
GROUP BY sido;

����(KFC, ����ŷ, �Ƶ�����)
SELECT *
FROM
(SELECT sido, sigungu, COUNT(*)
FROM fastfood   
WHERE sido = '����������'
AND GB IN ('KFC','����ŷ','�Ƶ�����')
GROUP BY sido, sigungu) a,

����������	�߱�	7
����������	����	4
����������	����	17
����������	������	4
����������	�����	2;

�����ñ����� �Ե����� 
SELECT  a.sido,a.sigungu,ROUND(c1/c2,2) hambuger_score
FROM
(SELECT sido, sigungu, COUNT(*) c1
FROM fastfood   
WHERE sido = '����������'
AND GB IN ('KFC','����ŷ','�Ƶ�����')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) c2
FROM fastfood   
WHERE sido = '����������'
AND GB IN ('�Ե�����')
GROUP BY sido, sigungu)b
WHERE a.sido= b.sido
AND a.sigungu = b.sigungu
ORDER BY hambuger_score DESC;
�ΰ��� ���̺��� �÷����� Ȯ���Ϸ��� JOIN ���;
fastfood ���̺��� �ѹ��� �д� ������� �ۼ��ϱ�;

SELECT sido,sigungu,ROUND((kfc+burgerking+mac )/lot,2) burger_score
FROM
(SELECT sido, sigungu, 
                    NVL(sum(DECODE(gb, 'KFC', 1)),0)kfc,  
                    NVL(sum(DECODE(gb, '����ŷ',1)),0)burgerking,
                    NVL(sum(DECODE(gb, '�Ƶ�����',1)),0) mac,
                    NVL(sum(DECODE(gb, '�Ե�����',1)),1) lot                   
FROM fastfood
WHERE gb IN('kfc','����ŷ','�Ƶ�����','�Ե�����')
GROUP BY sido, sigungu)
ORDER BY  burger_score DESC;

SELECT*
FROM fastfood
WHERE sido = '��⵵'
AND sigungu = '������';

�ݸӰ� ����, ���κ� �ٷμҵ� �ݾ� ������ ���� �õ����� (����)
����, ���κ� �ٷμҵ� �ݾ����� ������ ROWNUM�� ���� ������ �ο� 
���������� �ೢ�� ���� 
�ܹ������� �õ�, �ܹ������� �ñ���, �ܹ�������, ���� �õ�, ���ݽñ���,���κ� �ٷμҵ��
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
WHERE gb IN ('�Ƶ�����','����ŷ','KFC')
GROUP BY sido
ORDER BY count(*) DESC;

--�õ� �� �Ե����� , ������  rownum����
SELECT ROWNUM rn,a.*
FROM 
    (SELECT sido,count(*)
    FROM fastfood
    WHERE gb IN ('�Ƶ�����','����ŷ','KFC')
    GROUP BY sido
    ORDER BY count(*) DESC)a;

SELECT ROWNUM rn,b.*
FROM 
    (SELECT sigungu,count(*)
     FROM fastfood
     WHERE gb IN ('�Ƶ�����','����ŷ','KFC')
     GROUP BY sigungu
     ORDER BY count(*) DESC)b;
--join�ϱ�
SELECT  a.rn,a.sido,a.num3,b.sigungu,b.num3
FROM 
    (SELECT ROWNUM rn,a.*
    FROM 
    (SELECT sido,count(*) num3
    FROM fastfood
    WHERE gb IN ('�Ƶ�����','����ŷ','KFC')
    GROUP BY sido
    ORDER BY count(*) DESC)a)a
JOIN
    (SELECT ROWNUM rn,b.*
    FROM 
    (SELECT sigungu,count(*) num3
     FROM fastfood
     WHERE gb IN ('�Ƶ�����','����ŷ','KFC')
     GROUP BY sigungu
     ORDER BY count(*) DESC)b)b
ON
    (a.rn=b.rn);


--
SELECT ROWNUM rn,b.*
FROM 
    (SELECT sigungu,count(*) num1
    FROM fastfood
    WHERE gb IN ('�Ե�����')
    GROUP BY sigungu
    ORDER BY count(*) DESC)b;

    
SELECT ROWNUM rn,a.*
FROM 
    (SELECT sido,count(*) num1
    FROM fastfood
    WHERE gb IN ('�Ե�����')
    GROUP BY sido
    ORDER BY count(*) DESC )a;
--join
SELECT *
FROM (
    SELECT ROWNUM rn,b.*
    FROM 
    (SELECT sigungu,count(*) num1
    FROM fastfood
    WHERE gb IN ('�Ե�����')
    GROUP BY sigungu
    ORDER BY count(*) DESC)b)B
JOIN (    
    SELECT ROWNUM rn,a.*
    FROM 
    (SELECT sido,count(*) num1
    FROM fastfood
    WHERE gb IN ('�Ե�����')
    GROUP BY sido
    ORDER BY count(*) DESC )a)a
ON (a.rn = b.rn);

--��ü���� 
SELECT *
FROM ( 

    SELECT *
    FROM (
            SELECT ROWNUM rn,b.*
            FROM 
                (SELECT sigungu,count(*) num1
                FROM fastfood
                WHERE gb IN ('�Ե�����')
                GROUP BY sigungu
                ORDER BY count(*) DESC)b)b
    JOIN 
        (SELECT ROWNUM rn,a.*
        FROM 
            (SELECT sido,count(*) num1
            FROM fastfood
            WHERE gb IN ('�Ե�����')
            GROUP BY sido
            ORDER BY count(*) DESC )a)a
    ON 
    (a.rn = b.rn))a; 
---------------------------�ΰ������̺��� �����Ҽ� ���� : ��ü select ������ �ȿ��ִ� rn�� ����������  �׷��ϱ� �ٸ���� ( 1. exist , 2. ��ȣ��������)
LEFT OUTER JOIN (;
                                                                    SELECT  *
                                                                    FROM(
                                                                            SELECT ROWNUM rn,a.*
                                                                            FROM 
                                                                                (SELECT sido,count(*) num3
                                                                                FROM fastfood
                                                                                WHERE gb IN ('�Ƶ�����','����ŷ','KFC')
                                                                                GROUP BY sido
                                                                                ORDER BY count(*) DESC)a)a
                                                                    JOIN
                                                                        (SELECT ROWNUM rn,b.*
                                                                        FROM 
                                                                            (SELECT sigungu,count(*) num3
                                                                            FROM fastfood
                                                                            WHERE gb IN ('�Ƶ�����','����ŷ','KFC')
                                                                            GROUP BY sigungu
                                                                            ORDER BY count(*) DESC)b)b
                                                                    ON
                                                                    (a.rn=b.rn))b;
ON (a.rn_1=b.rn);

select a.sigungu,b.sigungu,ROUND((b.cnt/a.cnt),2)
from (
        select sigungu,count(*) cnt
        from fastfood
        where gb IN ('�Ե�����')
        GROUP BY sigungu)a
 join (
        select sigungu,count(*) cnt
        from fastfood
        where gb IN ('����ŷ','kfc','�Ƶ�����')
        GROUP BY sigungu)b
on (a.sigungu= b.sigungu)
AND (a.sigungu = b.sigungu);


GROUP BY a.sigungu;      


SELECT a.sido,a.sigungu, round((b.cnt/a.cnt),2)��������
FROM 
    (select sido, sigungu,count(*) cnt
    from fastfood
    where gb IN ('�Ե�����')
    GROUP BY sigungu, sido)a
    ,    
    (SELECt  sido, sigungu,count(*) cnt
    from fastfood
    WHERE gb IN('����ŷ','KFC','�Ƶ�����')
    GROUP BY sigungu, sido)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY �������� DESC 
;



--SELECt *
--FROM (
--
--        select count(*) cnt
--        from fastfood
--        where gb IN ('�Ե�����')
--        ORDER BY sigungu)a
--    ,
--        (select count(*) cnt
--        from fastfood
--        where gb IN ('����ŷ','kfc','�Ƶ�����')
--        ORDER BY sigungu)b
--WHERE a.cnt = b.cnt

    








        select sigungu,SIDO,count(*) cnt
        from fastfood
        where gb IN ('�Ե�����')
        GROUP BY sigungu, SIDO;
        
        
         select sigungu,SIDO,count(*) cnt
        from fastfood
        where gb IN ('����ŷ','kfc','�Ƶ�����')
        GROUP BY sigungu, SIDO;
    