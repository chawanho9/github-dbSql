
--����� �Ե����� �� 
SELECT count(*) num
FROM fastfood
where sigungu = '�����' AND gb = '�Ե�����';



SELECT sido,count(*)
FROM fastfood 
WHERE sido like '%����%'
GROUP BY sido;

����(KFC, ����ŷ, �Ƶ�����);
SELECT *
FROM
(SELECT sido, sigungu, COUNT(*)
FROM fastfood   
WHERE sido = '����������'
AND GB IN ('KFC','����ŷ','�Ƶ�����')
GROUP BY sido, sigungu) a;

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
empno �÷��� NOTNULL ���� ������ �ִ� -INSERT �� �ݵ�� ���� �����ؾ� ���������� �Էµȴ�.
empno �÷��� ������ ������ �÷��� NULLABLE �̴� (NULL ���� ����� �� �ִ�);
INSERT INTO emp (empno,ename,job)
VALUES (9999,'brown','NULL');

insert into emp(empno,ename,job) values (9949,'wano','������');
SELECT*
FROM emp;
rollback;
INSERT INTO emp(ename,job)
VALUES ('saaly','SALESMAN');

���ڿ� : '���ڿ�' == > "���ڿ�"
���� : 10
��¥ : TO_DATE('20200206','YYYYMMDD'), SISDATE;

emp ���̺��� hiredate �÷��� date Ÿ��
emp ���̺��� 3���� �÷��� ���� �Է�;
DESC emp;
INSERT INTO emp
VALUES (9999,'sally','SALESMAN',NULL,SYSDATE,10000,NULL,99);
ROLLBACK;

�������� �����͸� �ѹ��� INSERT;
INSERT INTO ���̺�� (�÷���),�÷���2...)
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

UPDATE ����
UPDATE ���̺�� �÷��� 1 = ������ �÷� ��1, �÷���2 = ������ �÷� �� , ....
where �� ���� ���� 
������Ʈ ���� �ۼ��� WHERE ���� �������� ������ �ش� ���̺��� 
��� ���� ������� ������Ʈ�� �Ͼ��
UPDATE, DELETE ���� WHERE ���� ������ �ٽ��ѹ� Ȯ���Ѵ�
WHERE ���� �ִٰ� �ϴ��� �ش� �������� �ش� ���̺��� SELECT �ϴ� ������ �ۼ��Ͽ� �����ϸ�
UPDATE ��� ���� ��ȸ �� �� �����Ƿ� Ȯ�� �ϰ� �����ϴ� �͵� ��� �߻� ������ ������ �ȴ�;

99�� �μ���ȣ�� ���� �μ� ������ DEPT���̺� �ִ»�Ȳ 
INSERT INTO dept VALUE (99,'ddit','daejeon');
COMMIT;

SELECT *
FROM dept;

99�� �μ���ȣ�� ���� �μ��� dname �÷��� ���� '���IT', loc �÷��� ���� '���κ���'���� ������Ʈ;

--update##############################
UPDATE dept SET dname ='���IT', loc='���κ���'
WHERE deptno = 99;

SELECT *
FROM dept;
ROLLBACK;

�Ǽ��� WHERE ���� ������� �ʾ��� ���;
UPDATE dept SET dname ='���IT', loc='���κ���';
WHERE deptno = 99;

�����-�ý��� ��ȣ�� �ؾ���� ==> �Ѵ޿� �ѹ��� ��� ������� �������
                               ���� �ֹι�ȣ ���ڸ��� ��й�ȣ�� ������Ʈ 
�ý��� ����� : �����(12,000), ������(550, ����(1,300)
UPDATE ����� SET ��й�ȣ = �ֹι�ȣ ���ڸ�
WHERE ����ڱ���= '�����';
COMMIT;

10 ==> subquery ;
SMITH, WARD�� ���� �μ��� �Ҽӵ� ���� ����;
SELECT *
FROM emp 
WHERE deptno IN (SELECT deptno
                 from EMP
                 WHERE ename IN ('SMITH','WARD'));

UPDATE������ ���� ���� ����� ����;
INSERT INTO emp (empno,ename) VALUES (9999,'brown');
9999�� ��� deptno, job ������ SMITH ����� ���� �μ�����, �������� ������Ʈ;

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
                job=(SELECT job FROM emp WHERE ename='SMITH')
WHERE empno= 9999;

SELECT *
FROM emp;

DELETE SQL : Ư�� ���� ����
DELETE (FROM) ���̺��
WHERE ������ ���� ;

SELECT *
FROM dept;

99�� �μ���ȣ�� �ش��ϴ� �μ� ���� ����
DELETE dept
WHERE deptno =99;
COMMIT;

SUBQUERY�� ���ؼ� Ư�� ���� �����ϴ� ������ ���� DELECT
�Ŵ����� 7698 ����� ������ �����ϴ� ������ �ۼ� ;
DELETE emp
WHERE empno IN (7499,7521,7654,7844,7900);

DELETE emp 
WHERE empno IN (SELECT empno FROM emp WHERE mgr= 7698);
SELECT*
FROM emp;
ROLLBACK;