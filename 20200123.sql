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
SELECT * 
FROM users;
SELECT userid, usernm, alias AS ����
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

--���ڿ� ��Ī ������ : LIKE, %, _
--% � ���ڿ� (�ѱ���, ���� ��������  �ְ�, ���� ���ڿ��� �ü��� �ִ�)
--( _ ) ��Ȯ�� �ѹ���
--������ ������ ������ ������ ��ġ�� ���ؼ� �ٷ�
--�̸��� BR�� �����ϴ� ����� ��ȸ
--�̸��� R ���ڿ��� ���� ����� ��ȸ

--��� �̸��� s�� �����ϴ� ��� ��ȸ
--SMITH, SMKILE, SKC
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--���� �̸��� S�� �����ϰ� �̸��� ��ü ���̰� 5���� �� ����
--S____
SELECT *
FROM emp
WHERE ename LIKE 'S____';

--��� �̸��� 5���ڰ� ���� ��� ��ȸ
--ename LIKE '%S%' 
SELECT *
FROM emp
WHERE ename LIKE '%S%';

--MEMBER ���̺��� ȸ���� ���� '��'���� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

--member ���̺��� ȸ���� �̸��� ���� '��'�� ���� ��� ����� mem_id, meme_name�� ��ȸ�ϴ� ������ �ۼ����̼�
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

-- null �� ���� (IS)
SELECT *
FROM emp
WHERE comm IS null;

--emp ���̺��� comm�� �ִ� ȸ���� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��Ͻÿ�
SELECT *
FROM emp
WHERE comm LIKE '%';

SELECT *
FROM emp
WHERE comm IS NOT NULL;

--����� �����ڰ� 7690, 7839 �׸��� �Ŵ��� ������ null�� �ƴ� ������ ��ȸ-------------------------------�ٽ�Ǯ��-------------
NOT IN �����ڿ����� NULL ���� ���� ��Ű�� �ȵȴ�.;
SELECT * 
FROM emp
where empno not in (7690, 7839)
and mgr is not null;

SELECT*
FROM emp
WHERE empno NOT IN (7690,7839) AND mgr IS NOT NULL;

SELECT *
FROM emp;
SELECT *
FROM emp 
WHERE mgr NOT IN (7698,7839, NULL);

-- --> 
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839)
AND mgr IS NOT NULL;

--emp ���̺��� job�� SALESMAN �̰� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���
SELECT *
FROM emp
WHERE job IN 'SALESMAN' AND TO_DATE(hiredate,'YYYY/MM/DD') >= TO_DATE('19810601','yyyymmdd');


SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate > TO_DATE('19810601','YYYYMMDD');
--emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6��1�� ������ ������ ������ ������ ���� ��ȸ�Ͻÿ�
--(IN, NOT IN �����ڱ���)

SELECT *
FROM emp
WHERE deptno != 10 AND TO_DATE(hiredate,'yyyy/mm/dd') >= TO_DATE('19810601','YYYYMMDD');
SELECT *
FROM emp
WHERE deptno <>10
AND hiredate > TO_DATE('19810601','YYYYMMDD');
--emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�Ͻÿ�
--(NOT IN ������ ���)
SELECT *
FROM emp
WHERE deptno NOT IN 10 AND TO_DATE(hiredate,'yyyy/mm/dd') >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE deptno NOT IN(10)
AND hiredate > TO_DATE('19810601','YYYYMMDD');
--emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���
--(�μ��� 10, 20, 30�� �ִٰ� �����ϰ� IN �����ڸ� ���)
SELECT *
FROM emp
WHERE deptno IN(20,30)
AND hiredate > TO_DATE('1981,06,01','YYYY,MM,DD');
--emp ���̺��� job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate > TO_DATE('1981,06,01','YYYY,MM,DD');
--emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� ���۵Ǵ� ������ ������ ������ ���� ��ȸ�ϼ���
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';
--emp���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ������ ���� ��ȸ �ϼ���
--(like �����ڸ� ������� ������)


SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno > 7800
AND empno < 7900;

--������ �켱����
--*,/ �����ڰ� +,- ���� �켱������ ����
--1+5*2 = 11 
--�켱���� ���� : ()
--AND > OR 

-- emp ���̺��� ��� �̸��� SMITH�̰ų� ����̸��� ALLEN �̸鼭 ��� ������ SALESMAN�� ��� ��ȸ
SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR (ename = 'ALLEN' AND job = 'SALESMAN');
--��� �̸��� SMITH�̰ų� ALLEN �̸鼭 �������� SALESMAN�� �����ȸ
SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN') AND job = 'SALESMAN';
--emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϸ鼭 �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���
������ ���� �빮�ڸ�  �빮�ڷ� ã�ƾ���;
--##########################�ٽ�Ǯ��EMP


SELECT *
FROM emp
WHERE job = 'SALESMAN' OR (empno LIKE ('78%') AND hiredate > TO_DATE('1981/06/01' ,'YYYY/MM/DD')); 


SELECT*
FROM emp
WHERE job = 'SALESMAN' 
OR empno LIKE '78%' AND hiredate > TO_DATE('19810601' , 'YYYYMMDD');

--���� ##########################
--SELECT *
--FROM table
--[WEHRE]
--ORDER BY �÷����� Ȥ�� ��Ī Ȥ�� �÷��ε��� [ASC | DESC], ...)

--emp ���̺��� ��� ����� ename �÷� ���� �������� ���� ���� ������ ����� ��ȸ�ϼ���
SELECT *
FROM emp
ORDER BY ename ASC;
--emp ���̺��� ��� ����� ename �÷� ���� �������� ���� ���� ������ ����� ��ȸ�ϼ���
SELECT *
FROM emp
ORDER BY ename DESC;
--DESC emp; -- DESC : DESCRIBE (�����ϴ�)
--ORDER BY ename; -- DESC : DESCENDING (����)

--emp ���̺��� ��� ������ ename�÷����� ��������, ename ���� ���� ��� mgr �÷����� ��������
SELECT *
FROM emp
ORDER BY ename DESC, mgr ASC;
--���Ľ� ��Ī�� ���
SELECT empno, ename AS nm, sal*12 year_sal
FROM emp
ORDER BY year_sal;

--�÷� �ε����� ����(���õ� �÷��� ���������� ����)
--jave array [0]
--SQL COLUM INDEX : 1���� ���� 
SELECT empno, ename AS nm, sal*12 year_sal
FROM emp
ORDER BY 3;
--orderby1
--dept ���̺��� ��� ������ �μ��̸����� �������� ���ķ� ��ȸ�ǵ��� ������ �ۼ��ϼ���
SELECT *
FROM dept
ORDER BY loc;

--dept ���̺��� ��� ������ �μ���ġ�� �������� ���ķ� ��ȸ�ǵ��� ������ �ۼ��ϼ���
SELECT *
FROM dept
ORDER BY loc DESC;
--orderby2
--emp ���̺��� ��(comm)������ �ִ� ����鸸 ��ȸ�ϰ� �󿩸� ���� �޴� ����� ���� ��ȸ�ǵ��� �ϰ�,
--�󿩰� ���� ��� ������� �������� �����ϼ���(0�λ���� ���°����� ����)
SELECT *
FROM emp
WHERE comm LIKE ('%')
--WHERE comm IS NOT ULL
AND comm NOT IN (0)
--AND comm >0
ORDER BY comm DESC,empno;
--orderby3
--emp ���̺��� �����ڰ� �ִ� ����鸸 ��ȸ�ϰ�,����(job)������ �������� �����ϰ�
--������ ���� ��� ����� ū ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���

SELECT *
FROM emp
WHERE mgr IS NOT NULL 
ORDER BY job ,empno DESC; 


SELECT *
FROM emp
WHERE mgr IS NOT NULL
--WHERE mgr LIKE ('%')
ORDER BY job, empno DESC;









