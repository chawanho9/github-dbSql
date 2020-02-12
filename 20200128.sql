-- emp���̺� ���� 10�� �μ� Ȥ�� 30�� �μ��� ���ϴ� ����� �޿��� 1500�� �Ѵ� ����鸸 ��ȸ�ϰ� �̸����� �������� ���ĵǵ���
SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 30 AND sal >= 1500
ORDER BY  ename DESC;

SELECT *
FROM emp
WHERE deptno IN (20, 30) AND sal > 1500
ORDER BY ename DESC;

-- RWONUM: ���ȣ ��Ÿ���� �÷�
SELECT ROWNUM, empno, ename
FROM emp
WHERE deptno IN (10, 30)
AND SAL > 1500;
--ROWNUM################################################################################################
--ROWNUM �� WHERE���� �� ��밡��
--�����ϴ°� : ROWNUM =1, ROWNUM <= 2  --> ROWNUM =1, ROWNUM <= N
--�������� �ʴ°� : ROWNUM = 2,ROWNUM >= 2 ROWNUM = N( N�� 1�� �ƴ� ����) ROWNUM >= N (N�� 1�� �ƴ� ����)
--ROWNUM �̹� ���� �����Ϳ��ٰ� �������ο�
-- ������1 :���� �ʴ� ������ ���� (ROWNUM�� �ο����� �ʴ� ��)�� ��ȸ�� ���� ����.
-- ������2 : 
--��� �뵵 : ����¡ ó�� 
--���̺� �ִ� ��� ���� ��ȸ�ϴ°��� �ƴ϶� �츮�� ���ϴ� �������� �ش��ϴ� �� �����͸� ��ȸ�� �Ѵ�
--����¡ ó���� ������� : 1�������� �Ǽ�, ���ı���
--emp���̺� �� row �Ǽ� : 14
--�������� 5���� �����͸� ��ȸ
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

-- ���ĵ� ����� ROWNUM�� �ο� �ϱ� ���ؼ��� IN- LINE VIEW�� ����Ѵ�.
-- �������� : 1.���� , 2.ROWNUM�ο� 

SELECT empno, ename
FROM emp
ORDER BY ename;

-- SELECT *�� ����� ��� �ٸ� EXPRESSION�� ǥ�� 
-- �ϱ� ���ؼ� ���̺��.*�� ǥ���ؾ��Ѵ�.
SELECT ROWNUM, emp.*
FROM emp;

--FROM �� ���� ���̺��  ��Ī����
SELECT ROWNUM rn, e.*
FROM emp e;

-- ROWNUM = rn 
-- *page size : 5 , ���ı����� ename
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

--row_1)emp ���̺��� ROWNUM ���� 1~10�� ���� ��ȸ�ϴ� ������ �ۼ��϶� (���ľ��� ����)

SELECT*
FROM
(SELECT ROWNUM rn, emp.*
FROM emp) 
where rn<=10;

--�ٽ�Ǯ�� 
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

--row_2)ROWNUM���� 11~ 20 �� ���� ��ȸ�Ͻÿ�
SELECT *
FROM 
    (SELECT ROWNUM rn, empno, ename
    FROM emp)
WHERE rn BETWEEN 11 AND 20;

--row_3)emp ���̺��� ��� ������ �̸��÷����� �������� ������������ 11~14���� ���� �ۼ��Ͻÿ�
--�ƽ��׸�ũ�� ���� �ٸ� �̽��׸���? ������ x.*
--rownum�� where������ ����Ҽ����⋚�����ѹ��� ���Ѵ�
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
--�ż���##############################################################################�������
-- DUAL ���̺� : �����Ϳ� �������, �Լ��� �׽�Ʈ�غ� �������� ���
--������ ��ҹ��� : LOWER, UPPER, INITCAP
SELECT LOWER ('Hello, world'), UPPER('Hello, world'),  INITCAP('Hello, world')
FROM dual;
--�Լ��� WHERE�������� ��� ����
--��� �̸��� SMITH�� ����� ��ȸ
--���ε�����(�ڹٺ���)�� �տ� : �ٿ��ָ�� 
SELECT *
FROM emp
WHERE ename = UPPER(:ename);
--SQL�ۼ��� �Ʒ� ���´� ���� �ؾ��Ѵ�.
--���̺��� �÷��� �������� �ʴ� ���·� SQL�� �ۼ��Ѵ�.
SELECT *
FROM emp
WHERE LOWER(ename) = :ename;

--
SELECT CONCAT ('Hello',', world') CONCAT,
       SUBSTR('Hello, World', 1, 5) SUB,
       LENGTH('Hello, World') len, 
       INSTR('Hello, World', 'l',5) ins, --Ư�� ���ڸ� ���ϴ� �κп��� ã��
       LPAD('Hello, World', 15, '*')LP, --���ϴ� ũ�⸹ŭ ���ϴ� ���ڷ� ���ʿ���ä���
       RPAD('Hello, World', 15, '*')RP, --���ϴ� ũ�⸹ŭ ���ϴ� ���ڷ� �����ʿ���ä���
       REPLACE('Hello, World', 'H','T') REP, --Ư�� ���ڿ��� ���ϴ� ���ڷ� �����ϱ�
       TRIM('d' FROM 'Hello, World') TR    --�յ� ���� �����ϱ�//Ư������ ���� 
FROM dual;

--���� �Լ�
--ROUND : �ݿø� (10.6�� �Ҽ��� ù���� �ڸ����� �ݿø� --> 11)
--TRUNC : ����(����) ( 10.6�� �Ҽ��� ù���� �ڸ����� ���� --> 10)
--ROUD , TRUNC l ����� �ڸ����� �ݿø�/����
--MOD : ������ ����( ���� �ƴ϶� ������ ������ �� ������ �� ) (13/5 => �� : 2, ������ 3)

--ROUND (��� ����, �ۿ� ��� �ڸ� )
SELECT ROUND(105.54,1) ROUND, -- �ݿø� ����� �Ҽ��� 1��° �ڸ� ���� ��������  --> �ι��� �ڸ����� �ݿø� 
       ROUND(105.56,1), 
       ROUND(105.56,0), -- �ݿø� ����� �����θ� --> �Ҽ��� ù���� �ڸ����� �ݿø� 
       ROUND(105.55,-1), --�ݿø� ����� ���� �ڸ����� --> ���� �ڸ����� �ݿø�
       ROUND(105.55)    -- �ι�° ���ڸ� �Է����� �ʴ� ��� 0�� ����
FROM dual;

SELECT TRUNC(105.54, 1),  -- ������ ����� �Ҽ��� ù��° �ڸ����� �������� --> �ι�° �ڸ����� ���� 
       TRUNC(105.55, 1),  -- ������ ����� �Ҽ��� ù���� �ڸ����� �������� --> �Ҽ��� �ι��� �ڸ����� ����
       TRUNC(105.55, 0),  -- ������ ����� ������(�����ڸ�) ���� �������� --> �Ҽ��� ù���� �ڸ����� ����
       TRUNC(105.55, -1), -- ������ ����� 10�� �ڸ� ���� �������� �����ڸ����� ����
       TRUNC(105.55)      -- �ι�° ���ڸ� �Է����� ���� ��� 0�� ���� 
FROM dual;

--EMP���̺��� ����� �޿�(sal)�� 1000���� ������ �� ���� ���ϼ��� 
SELECT ename, sal , TRUNC(sal/ 1000), MOD(sal , 1000) --mod�� ����� divisor���� �׻��۴�
FROM emp;

DESC emp;

-- �⵵ 2�ڸ�/�� 2�ڸ�/���� 2�ڸ� 
SELECT ename, hiredate
FROM emp;

--SYSDATE : ���� ����Ŭ ������ �ú��ʰ� ���Ե� ��¥ ������ �����ϴ� Ư�� �Լ� 
--data = + ���� = ���� ����
-- 1 = �Ϸ�
-- 1�ð� = 1/24
--2020/01/28 + 5

--���� ǥ�� : ����
--���� ǥ�� : �̱� �����̼� + ���ڿ� + ��Ŭ �����̼� = '���ڿ�'
--��¥ ǥ�� : TO_DATE('���ڿ� ��¥ ��','���ڿ� ��¥���� ǥ�� ����' --> TO_DATE('2020-01-28', 'YYYY-MM-DD')

SELECT SYSDATE +5, SYSDATE + 1/24 
FROM dual;

--fn 1 
--1. 2019�� 12�� 31���� date������ ǥ��
--2. 2019�� 12�� 31���� date������ ǥ���ϰ� 5�� ���� ��¥
--3. ���� ��¥ 
--4. ���� ��¥�� 3�� �� �� 
--�� 4�� �÷��� �����Ͽ� ������ ���� ��ȸ�ϴ� ������ �ۼ��ϼ��� 
SELECT TO_DATE('2019/12/31' , 'YYYY/MM/DD'), TO_DATE('2019/12/31' , 'YYYY/MM/DD')-5,SYSDATE, SYSDATE-3
FROM dual;

     
