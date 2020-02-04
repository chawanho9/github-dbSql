--iprod ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT *
FROM lprod;
--buyer ���̺��� buyer_id, buyer_name �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���

SELECT buyer_id, buyer_name
FROM buyer;
--cart ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT *
FROM cart;
--member ���̺��� mem_id, mem_pass, mem_name�÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT mem_id, mem_pass, mem_name
FROM member;

--uswers ���̺� ��ȸ 
SELECT *
FROM users;

--���̺� � �÷��� �ִ��� Ȯ���ϴ� ��� 
--1. SELECT *
--2. TOOL�� ��� (�����-TABELS)
--3. DESC ���̺�� (DESC-DESCRIBE)
DESC users;
SELECT *
FROM users;

--users ���̺��� userid, usernm, reg_dt �÷��� ��ȸ�ϴ� sql�� �ۼ��ϼ��� 
-- ��¥ ���� (reg_dt �÷��� date������ ������ �ִ� ����)
-- SQL��¥ �÷� + (���ϱ� ����) �������� ��Ģ������ �ƴѰ͵� (5+5)
--String H = "hello";
--String w = "world";
--String hw = h+w; �ڹٿ����� �� ���ڿ��� ���� 
--SQL���� ���ǵ� ��¥ ���� : 
--��¥ + ���� = ��¥���� ������ ���ڷ� ����Ͽ� ���� ��¥�� �ȴ� 
--ex) 2019/01/28 + 5 - 2019/02/02
--reg_dt : ������� �÷�
SELECT userid  u_id, usernm, reg_dt, reg_dt +5 AS reg_dt_after_5dat
--reg_dt +5�� �÷��� ������ ǥ����
--(AS)���� �÷����� �ٲܼ��ִ�(��Ī). AS �������� 
--null: ���� �𸣴� ����
--null�� ���� ���� ����� �׻� null
FROM users;

DESC users;

--prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(�� prod_id-> id prod_name -> name���� ��Ī ���� 
SELECT prod_id id , prod_name name
FROM prod ;


DESC prod;
SELECT prod_id AS id, prod_name AS name
FROM prod;
--lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(��) lprod_gu -> gu, lprod_nm -> nm �÷����� ��Ī ����
SELECT lprod_gu gu, lprod_nm nm
FROM lprod;
--buyer ���̺��� buyer_id, buyer_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--(�� buyer_id ->���̾���̵�, buyer_name ->���̾� �̸����� �÷� ��Ī ����)
SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;

--���ڿ� ���� 
--�ڹ� ���� ���ڿ� ���� : + ("Hello" + "world")
--SQL������ : || ('Hello' || 'world')
--SQL������ : concat('Hello', 'world')

--userid, usernm �÷��� ����, ��Ī id_name
SELECT userid || usernm id_name,CONCAT(userid, usernm) con_id_name
FROM users;

--����, ��� 
-- int a = 5; String msg = "HelloWorld";
-- System.outprintln(msg); //������ �̿��� ���
-- System.outprintln("Hello, World"); //����� �̿��� ��� 
-- SQL������ ������ ����(�÷��� ����� ����, pl/sql ���� ������ ����)
-- SQL���� ���ڿ� ����� �̱� �����̼����� ǥ��
--"Hello, World" --> 'Hello, World'

--���ڿ� ����� �÷����� ����
-- user id : brown
-- user id : cony

SELECT 'user id : '|| userid AS "User id"
FROM users;

SELECT TABLE_NAME
FROM USER_TABLES;

SELECT 'SELECT * FROM '||TABLE_NAME||';' AS QUERY
FROM USER_TABLES;

-- || --> CONCAT (���ڸ� �ΰ��ۿ� �̿����)
--SQL������ : concat('Hello', 'world')
SELECT CONCAT(CONCAT('SELECT * FROM ',TABLE_NAME),';') AS QUERY
FROM USER_TABLES;
SELECT CONCAT(CONCAT('SELECT * FROM ',userid),';') AS QUERY
FROM users;

-- int a = 5; // �Ҵ�, ���� ������
-- if(a == 5) (a�� ���� 5���� ��)
-- sql������ ������ ������ ���� (PL/SQL)

--WHERE �� : ���̺��� �����͸� ��ȸ�� �� ���ǿ� �´� �ุ ��ȸ
--ex : userid �÷��� ���� brown�� �ุ ��ȸ
--brown, 'brown' ����
--�÷�, ���ڿ� ���
-- userid�� brown�� �ƴ� �����͸� ����Ͻÿ�
--������ : = , �ٸ��� : !=, <>
SELECT *
FROM users
WHERE userid !='brown';

--emp ���̺� �����ϴ� �÷��� Ȯ�� �غ�����
SELECT *
FROM emp;

--emp ���̺��� ename �÷� ���� JONES�� �ุ ��ȸ
-- *SQL KEY WORD�� ��ҹ��ڸ� ������ ������
--�÷��� ���̳�, ���ڿ� ����� ��ҹ��ڸ� ������
--'JONES','Jones'�� ���� �ٸ����ִ�
SELECT *
FROM emp
WHERE ename = 'JONES';

SELECT *
FROM emp; 
DESC emp;
5 > 10 -- FALSE
5 > 5 -- FALSE
5 >= 5 -- TURE

-- emp ���̺��� deptno (�μ���ȣ��)�� 30���� ũ�ų� ���� ����鸸 ��ȸ
SELECT *
FROM emp
WHERE deptno >= 30;

--���ڿ� : '���ڿ�'
--���� : 50
--��¥ : ??? --> �Լ��� ���ڿ��� �����Ͽ� ǥ�� ���ڿ��� �̿��Ͽ� ǥ�� ���� ( ����x )
--      �������� ��¥ ǥ�� ����� �ٸ��� ���� 
--      �ѱ� : �⵵4�ڸ�-��2�ڸ�-����2�ڸ�
--      �̱� : ��2�ڸ�-����2�ڸ�-�⵵4�ڸ�

--�Ի����ڰ� 1980�� 12�� 17�� ������ ��ȸ
-- TO_DATE : ���ڿ��� date Ÿ������ �����ϴ� �Լ�
-- TO_DATE (��¥���� ���ڿ�, ù���� ������ ����)
--'1980/22/03'
SELECT *
FROM emp
WHERE hiredate = TO_DATE('19801217', 'YYYYMMDD');


--��������
-- sal �÷��� ���� 1000���� 2000 ������ ���
-- sal >= 1000
-- sal <= 2000
SELECT *
FROM emp
WHERE sal >= 1000 
AND sal <=2000
AND deptno = 30;

--���������ڸ� �ε�ȣ ��ſ� BETWEN AND �����ڷ� ��ü
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--�ǽ����� emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 
--1983�� 1��1�� ������ ����� ename, hiredate 
--�� �����ڴ� between�� ����Ѵ�.
SELECT ename,hiredate
FROM emp
--WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');
WHERE hiredate BETWEEN TO_DATE('19820101','YYYYMMDD') AND TO_DATE('19830101','YYYYMMDD');
