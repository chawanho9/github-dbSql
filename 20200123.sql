--���ǿ� �´� ������ ��ȸ�ϱ� ( >=, >, <=, < �ǽ� where2)
--emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1��1�� ������ �����
--ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ� 
SELECT ename,'19' || hiredate AS hiredate
FROM emp
where hiredate 
BETWEEN  TO_DATE('19820101','YYYYMMDD') AND TO_DATE('19830101','YYYYMMDD');

--WHERE ���� ����ϴ� ���ǿ� ������ ��ȸ ����� ������ ��ġ�� �ʴ´�.
--SQL�� ������ ������ ���� �ִ�.
--���� : Ű�� 185cm �̻��̰� �����԰� 70kg �̻��� ������� ����
--      -->�����԰� 70kg �̻��̰� Ű�� 185cm �̻��� ������� ����
--������ Ư¡ : ���տ��� ������ ����
--(1, 5, 10) --> (10, 5, 1) : �� ������ ���� �����ϴ�
--���̺��� ������ ������� ����
--SELECT ����� ������ �ٸ����� ���� �����ϸ� ����

-- IN ������
-- Ư¡ ���տ� ���ԵǴ��� ���θ� Ȯ��
-- �μ���ȣ�� 10�� Ȥ�� 20���� ���ϴ� ���� ��ȸ
SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10, 20);

--IN �����ڸ� ������� �ʰ� OR ������ ���
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10
OR deptno = 20;

-- emp���̺��� ����̸��� SMITH, JONES �� ������ ��ȸ (empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp
WHERE ename IN ('SMITH', 'JONES');

SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'JONES';

-- users ���̺��� userid�� brown, cony, sally�� �����͸� ������ ���� ��ȸ �Ͻÿ�
-- (IN ������ ���)
SELECT userid, usernm, '����' AS ����
FROM users
WHERE userid IN ('brown', 'cony', 'sally');


