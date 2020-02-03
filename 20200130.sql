--emp ���̺��� �̿��Ͽ� deptno�� ���� �μ������� �����ؼ� ������ ���� ��ȸ �Ǵ� ������ �ۼ��ϼ��� 

SELECT ename, deptno,
        DECODE(deptno, 10 , 'ACCOUNTING'
                     , 20 , 'RESEARCH'
                     , 30 , 'SALES'
                     , 40 , 'OPERATIONS','DDIT') DNAME
FROM emp;

SELECT ename, deptno,
        CASE WHEN deptno = 10 THEN 'ACCOUNTING'
             WHEN deptno = 20 THEN 'RESEARCH'
             WHEN deptno = 30 THEN 'SALSE'
             WHEN deptno = 40 THEN 'OPERATIONS'
             ELSE 'DDIT'
        END DNANME
FROM emp;        

--emp ���̺��� �̿��Ͽ� hiredate�� ���� ���� �ǰ����� ���� ��������� ��ȸ�ϴ� ������ �ۼ��ϼ���
--������ �������� �ϳ� ���⼭�� �Ի�⵵�� �������� �Ѵ�.
SELECT ename, hiredate , 
        CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2)=0 THEN 'O'
             ELSE 'X'
        END �ǰ�����_�����     
FROM emp;

--SELECT empno,ename,hiredate,
--    MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2) hire,
--    MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2),
--    CASE
--        WHEN MOD(TO_NUMBER(TO_CHAR(hiredate , 'YYYY')), 2) = MOD(TO_NUMBER(TO_CHAR(SISDATE, 'YYYY')),2)
--            THEN '�����'
--            ELSE '������'
--        END CONTACT_TO_DOCTOR,
--        DECODE(MOD(TO_NUMBER(TO_CHAR(

--######################################################################################
--GROUP BY ���� �������� ����
--�μ���ȣ�� ���� ROW���� ���� ��� : GROUP BY deptno
--�������� ���� ROW���� ���� ��� : GROUP BY job
--MRG�� ���� �������� ���� ROW ���� ���°�� : GROUP BY mgr, job

--�׷��Լ��� ����
--SUM   : �հ�
--COUNT : ����
--MAX   : �ִ밪
--MIN   : �ּҰ�
--AVG   : ���

-- �׷��Լ��� Ư¡ 
-- �ش� �÷��� Null���� ���� ROW�� ������ ��� �ش� ���� �����ϰ� ����Ѵ� (NULL ������ ����� NULL)

-- �׷��Լ� ������
--GROUP BY ���� ���� �÷��̿��� �ٸ��÷��� SELECT���� ǥ���Ǹ� ���� 
--�׷�ȭ�� ���þ��� ������ ���ڿ�, �Լ�, ���ڵ��� SELECT���� ������ ���� ����


--�μ��� �޿� �� 
SELECT deptno, 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno;

--GOUP BY ���� ���� ��Ÿ���� �׷��Լ��� ����� ��� 
-- ��ü���� �ϳ��� ������ ���´�
SELECT 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2),
        COUNT(sal), -- sal�÷��� ���� null�� �ƴ� row�� ����
        COUNT(comm),-- COMM �÷��� ���� NULL�� �ƴ� COMM�� ����
        COUNT(*) -- ����� �����Ͱ� �ִ��� 
FROM emp;

-- SINGLE ROW FUNCTION�� ��� WHERE ������ ����ϴ� ���� �����ϳ�
-- MULTI ROW FUNCTION�� ��� WHERE ������ ����� �Ұ����ϰ�
-- HAVING ������ ������ ����Ѵ�.

-- �μ��� �޿� �� ��ȸ, �� �޿����� 9000�̻��� �����͸� 
-- deptno, �޿��� 
SELECT deptno, SUM(sal) SUM_SAL
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

--emp���̺��� �̿��Ͽ� ������ ���Ͻÿ�
--������ ���� ���� �޿� 
SELECT  MAX(sal),MIN(sal), ROUND(AVG(sal),2),SUM(sal),COUNT(sal),COUNT(mgr),COUNT(ename)
FROM emp;

--�μ� ����
SELECT deptno,  MAX(sal),MIN(sal), ROUND(AVG(sal),2),SUM(sal),COUNT(sal),COUNT(mgr),COUNT(ename)
FROM emp
GROUP BY deptno;

SELECT ename, sal
FROM emp
ORDER BY sal DESC;

--emp���̺��� �̿��Ͽ� ������ ���Ͻÿ�
SELECT *
FROM   
    (SELECT 
            CASE WHEN deptno=10 THEN 'ACCOUNTING'
                 WHEN deptno=20 THEN 'RESEARCH'
                 WHEN deptno=30 THEN 'SALES'
            END   DNAME  
            ,  MAX(sal),MIN(sal), ROUND(AVG(sal),2),SUM(sal),COUNT(sal),COUNT(mgr),COUNT(*)
        FROM emp
        GROUP BY deptno)
ORDER BY dname;


--ORACLE 9I ���������� GROUP BY���� ����� �÷����� ������ ����
--ORACLE 10I ���� ���ʹ� GROUP BY���� ����� �÷����� ������ ���� ���� �ʴ´�(GROUP BY ������ �ӵ�UP

--������ �Ի� ������� ����� ������ �Ի��ߴ��� ��ȸ
SELECT  TO_CHAR(hiredate , 'YYYY/MM'),COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate , 'YYYY/MM')
ORDER BY TO_CHAR(hiredate , 'YYYY/MM');

--emp���̺��� �̿��Ͽ� ������ ���Ͻÿ�
--������ �Ի� �⺰�� ����� ������ �Ի��ߴ��� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT  TO_CHAR(hiredate , 'YYYY'),COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate , 'YYYY')
ORDER BY TO_CHAR(hiredate , 'YYYY');

--ȸ�翡 �����ϴ� �μ��� ������ ����� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
SELECT  COUNT(*)
FROM dept;

--������ ���� �μ��� ������ ��ȸ�ϴ� ������ �ۼ��ϼ��� 
SELECT COUNT(*) cnt
FROM (
        SELECT deptno,COUNT(*)
        FROM emp
        GROUP BY deptno);
        
--���� 3
--���� �⵵�� ¦�� ���а�, REG_DT�⵵�� ¦�� ������ �����ϸ� -->�����
--���� �⵵�� ¦�� ���а�, REG_DT�⵵�� ¦�� ������ �������� ������ -->�����
SELECT userid, usernm, reg_dt, 
     CASE 
         WHEN MOD(TO_NUMBER(TO_CHAR(reg_dt,'YY')),2) = 0 THEN '�� �����'
         WHEN MOD(TO_NUMBER(TO_CHAR(reg_dt,'YY')),2) = 1 THEN ' �����'
                ELSE 'null'
    END            
     
FROM users
ORDER BY userid;