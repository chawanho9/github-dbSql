--emp ���̺� �����ϴ� �÷��� Ȯ�� �غ�����
DESC EMP;
--users ���̺��� userid, usernm, reg_dt �÷��� ��ȸ�ϴ� sql�� �ۼ��ϼ��� 
SELECT userid, usernm, reg_dt
FROM users;
--lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
DESC lprod;
SELECT lprod_gu,lprod_nm
FROM lprod;
--userid, usernm �÷��� ����, ��Ī id_name
DESC users;
SELECT userid || usernm AS id_name
FROM users;
Select '�̰��� �����̴�:' || CONCAT(userid, usernm) AS id_name2
FROM users;
-- emp ���̺��� deptno (�μ���ȣ��)�� 30���� ũ�ų� ���� ����鸸 ��ȸ
SELECT *
FROM emp
WHERE deptno >= 30;
--�Ի����ڰ� 1980�� 12�� 17�� ������ ��ȸ         (��������)
SELECT *
FROM emp
WHERE hiredate = TO_DATE('1980/12/17','YYYY/MM/DD');
-- sal �÷��� ���� 1000���� 2000 ������ ���
SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000;
--���������ڸ� �ε�ȣ ��ſ� BETWEN AND �����ڷ� ��ü
SELECT *
FROM emp 
WHERE sal 
BETWEEN 1000 AND 2000;
--�ǽ����� emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 
--1983�� 1��1�� ������ ����� ename, hiredate 
--�� �����ڴ� between�� ����Ѵ�.
SELECT ename, hiredate
FROM emp
WHERE hiredate 
BETWEEN TO_DATE('19820101','YYYYMMDD') AND TO_DATE(19830101);


