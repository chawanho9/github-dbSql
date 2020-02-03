--DATE : TO_DATE ���ڿ� =>��¥ (DATE)
--      TO_CHAR ��¥ => ���ڿ� (��¥ ���� ����)
-- JAVA������ ��¥ ������ ��ҹ��ڸ� ������ ( MM/mm => �� / ��)
--�ְ� ����(1~7) : �Ͽ��� 1, ������ 2 ....����� ?
-- ���� IW : ISOǥ�� - �ش����� ������� �������� ������ ���� 
--          2019/12/31 ȭ���� --> 2020/01/02(�����) --> �׷��� ������ 1������ ����

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS'),
       TO_CHAR(SYSDATE, 'D'),
       TO_CHAR(SYSDATE, 'IW'),
       TO_CHAR(TO_DATE('2019/12/31', 'YYYY/MM/DD'),'IW')
FROM dual;   

--emp���̺��� hiredate (�Ի�����) �÷��� ����� ��:��:��
SELECT ename, hiredate, 
       TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS') AS result,
       TO_CHAR(hiredate + 1, 'YYYY-MM-DD HH24:MI:SS') AS result,
       TO_CHAR(hiredate + 1/24, 'YYYY-MM-DD HH24:MI:SS') AS result,
       TO_CHAR(hiredate + (1/24/60)*30, 'YYYY-MM-DD HH24:MI:SS') AS result,
       -- hiredate�� 30�п� ���Ͽ� TO_CHAR�� ǥ��
       TO_CHAR(hiredate + 1/48, 'YYYY-MM-DD HH24:MI:SS') AS result
FROM emp;

--���� ��¥�� ������ ���� �������� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
SELECT  
    TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS' ),
    TO_CHAR(SYSDATE, 'DD-MM-YYYY' )
FROM dual;

--MONTH_BETWEEN(DATE,DATE)
--���ڷ� ���� �� ��¥ ������ �������� ����
SELECT ename, hiredate,
       MONTHS_BETWEEN(SYSDATE, hiredate),
       MONTHS_BETWEEN(TO_DATE('2020-01-17', 'YYYY-MM-DD'), hiredate)
FROM emp 
WHERE ename = 'SMITH';

--ADD_MONTHS(DATE, ����-������ ������)
SELECT ADD_MONTHS(SYSDATE, 5),  --2020/01/25 --> 2020/06/29
       ADD_MONTHS(SYSDATE, -5)  --2020/01/29 --> 2020/08/29
FROM dual;

-- NEXT_DAY(DATE, weekday), ex: NEXT_dATE(SYSDATE, 5) => SYSDATE���� ó�� �����ϴ� �ְ����� 5(��)�� �ش��ϴ� ��¥
--                              SYSDATE 2020/01/29(��) ���� ó�� �����ϴ� 5(��)���� -> 2020/01/30(��)
SELECT NEXT_DAY(SYSDATE, 5)
FROM dual;

--LAST_DAY(DATE) DATE�� ���� ���� ������ ���ڸ� ���� 
SELECT LAST_DAY(SYSDATE) --SYSDATE 2020/01/29 --> 2020/01/31
FROM dual;

--LAST_DAY�� ���� ���ڷ� ���ƿ� DATE�� ���� ���� ������ ���ڸ� ���Ҽ� �ִµ� 
--date�� ù���� ���ڴ� ��� ���ұ�?

SELECT SYSDATE,
        LAST_DAY(SYSDATE),
        TO_CHAR(SYSDATE,'YYYY-MM'),
        TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM')|| '-01','YYYY-MM-DD')
FROM dual;        

--hiredate ���� �̿��Ͽ� �ش� ���� ù��° ���ڷ� ǥ��
SELECT ename, hiredate,
       TO_DATE(TO_CHAR(hiredate, 'YYYY-MM')||'-01','YYYY-MM-DD')
FROM emp;

--SQL����ȯ 
--empno�� NUMBERŸ�� , ���ڴ� ���ڿ� 
--Ÿ���� ���� �ʱ� ������ ������ ����ȯ�� �Ͼ.
--���̺� �÷��� Ÿ�Կ� �°� �ùٸ� ���� ���� �ִ°� �߿�
SELECT *
FROM emp
WHERE empno='7369';

SELECT *
FROM emp
WHERE empno=7369;

--hiredate�� ��� DATEŸ��, ���ڴ� ���ڿ��� �־����� ������ ������ ����ȯ�� �߻�
-- ��¥ ���ڿ� ���� ��¥ Ÿ������ ��������� ����ϴ°��� ����
SELECT *
FROM emp
WHERE hiredate = '1980/12/17';

SELECT *
FROM emp
WHERE hiredate = TO_DATE('1980/12/17','YYYY/MM/DD');

EXPLAIN PLAN FOR 
SELECT * 
FROM emp 
WHERE empno='7369';

EXPLAIN PLAN FOR 
SELECT * 
FROM emp 
WHERE TO_CHAR(empno)='7369';

SELECT *
FROM table(dbms_xplan.display);
--�鿩 ���Ⱑ �Ǿ��ִ°�� �� �����ִ� Operation�� �θ� �ǹ� 

--���ڸ� ���ڿ��� �����ϴ� ��� : ���� 
--õ���� ������ 
-- 1000 �̶�� ���ڸ�
--�ѱ� : 1,000.50
--���� : 1.000,50

-- emp sal �÷��� ������ ##################################
-- 9 : ����
-- 0 : ���� �ڸ� ����(0���� ǥ��)
-- L : ��ȭ����
SELECT ename, sal ,TO_CHAR(sal, 'L0,999')
FROM emp;


-- NULL�� ���� ������ ����� �׻� NULL 
-- emp���̺��� sal �÷����� null�����Ͱ� �������� ���� 
-- emp���̺��� comm �÷����� null�����Ͱ� ����
-- sal + comm --> comm�� null�� �࿡ ���ؼ��� ����� null�� ���´� .
-- �䱸���� comm�� null�̸� sal �÷��� ���� ��ȸ 
--�䱸������ ���� ��Ű�� ���Ѵ� -> ����

--NVL(Ÿ��, ��ü�� ##########################################
-- Ÿ���� ���� NULL�̸� ��ü���� ��ȯ�ϰ�
-- Ÿ���� ���� NUL�� �ƴϸ� Ÿ�� ���� ��ȯ
-- if( Ÿ�� == null ) 
--      return(��ü��)
-- else 
--      return(Ÿ��);
SELECT ename, sal, comm, NVL(comm, 0),sal+NVL(comm,0),NVL(sal+comm,0)
FROM emp;

--NVL2(expr1,expr2,expr3)
--if(expr1 != null)
--      return expr2;
--else
--      return expr3;
SELECT ename, sal, comm, NVL2(comm, 10000, 0)
FROM emp;

--NULLIF(expr1,exp2)
--if(expr1 == expr2)
--      return null;
-- else
--      return expr1;

SELECT ename, sal, comm, NULLIF(sal, 1250) --sal 1250�� ����� null�� ����, 1250�� �ƴѻ���� sal�� ���� 
FROM emp;

--��������  
--COALESCE �����߿� ���� ó������ �����ϴ� null�� �ƴ� ���ڸ� ��ȯ
--COALESCE(expr1,expr2...)
--if(expr1 != null)
--  return expr1;
--else
--  return COALESCE(expr2,expr3...);

--COALESCE(comm, sal): comm�� null�� �ƴϸ� comm
--                     comm�� null �̸� sal(��, sal �÷��� ���� NULL�� �ƴҋ�)
SELECT ename, sal , comm, COALESCE(comm, sal)
FROM emp;

--emp���̺��� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ��� 
--NVL,NVL2,COALESCE

SELECT empno,ename,mgr,NVL(mgr,9999)MGR_N,NVL2(mgr,NULL,9999)MGR_N_1,COALESCE(mgr, 9999)MGR_N_2
FROM emp;

--users ���̺��� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ��� 
--reg_dt�� null�� ��� sysdate�� ����
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
    FROM 
        (SELECT empno, ename 
    FROM emp
    ORDER BY ename) a )    
--WHERE rn >= 1 AND rn <= 5;
WHERE rn BETWEEN (1 - 1) * 5  AND 1 * 5;

SELECT userid, usernm, reg_dt, NVL(reg_dt,SYSDATE+1)
FROM users
WHERE userid != 'brown';

--CONDITION : ������
--CASE : JAVA�� if - else if - else
--CASE
--      WHEN ����  THEN ���ϰ�1
--      WHEN ����2 THEN ���ϰ�2
--      ELSE �⺻��
-- END
--emp���̺��� job�÷��� ���� SALESMAN �̸� SAL * 1.05 ���� 
--                           MANAGER �̸� SAL * 1.1 ����
--                           PRESIDENT �̸� SAL + 1.2 ����
--                           �׹��� ������� SAL�� ���� 

SELECT ename, job, sal,
        CASE
            WHEN job = 'SALESMAN' THEN sal* 1.05
            WHEN job = 'MANAGER' THEN sal* 1.1
            WHEN job = 'PRESIDENT' THEN sal* 1.2
            ELSE sal
        END    
FROM emp;


--DECODE �Լ� : CASE���� ���� 
--�ٸ��� CASE �� : WHEN ���� ���Ǻ񱳰� �����Ӵ�
--      DECODE �Լ� : �ϳ��� ���� ���ؼ� = �񱳸� ���
--DECODE �Լ� : ��������(������ ������ ��Ȳ�� ���� �þ ���� ����)
--DECODE(�÷��̳� expr, �ι�° ���ڿ� ���� ��1, ù���� ���ڿ� �ι��� ���ڰ� ������� ��ȯ ��,
--       ù��° ���ڿ� ���� ��2,ù��° ���ڿ� �׹��� ���ڰ� ���� ��� ��ȯ �� ....
--       option - else ���������� ��ȯ�� �⺻��)


SELECT ename, job, sal,
    DECODE (job, 'SALESMAN' , sal* 10.5,
                    'MANAGER', sal* 1.1,
                    'PRESIDENT', sal* 1.2,sal) bonus_sal
FROM emp;             

--emp���̺��� job�÷��� ���� SALESMAN �̸鼭 sal�� 1400���� ũ��  SAL * 1.05 ���� 
--                          SALESMAN �̸鼭 sal�� 1400���� ������  SAL * 1.1 ���� 
--                           MANAGER �̸� SAL * 1.1 ����
--                           PRESIDENT �̸� SAL + 1.2 ����
--                           �׹��� ������� SAL�� ���� 
-- 1. CASE �̿��ؼ�
-- 2. DECODE, CASE �̿��ؼ� 


SELECT ename, job sal,
        CASE WHEN  job = 'SALESMAN' AND sal > 1400 THEN sal * 1.05
             WHEN  job = 'SALESMAN'  AND sal < 1400 THEN sal * 1.1
             WHEN  job = 'MANAGER' THEN sal * 1.1
             WHEN  job = 'PRESIDENT' THEN sal * 1.2
             ELSE sal
        END AS bonus_sal
FROM emp;        
SELECT ename ,job, sal,
        CASE WHEN job = 'SALESMAN' AND sal > 1400 THEN sal * 1.05
             WHEN job = 'SALESMAN' AND sal < 1400 THEN sal * 1.1
             ELSE sal
        END AS bonus_sal,
        DECODE ( job , 'MANAGER',sal*1.1,
                       'PRESIDENT', sal * 1.2) bonus_sal2

FROM emp;
SELECT ename ,job, sal,
        CASE 
             WHEN job = 'SALESMAN' AND sal > 1400 THEN sal * 1.05
             WHEN job = 'SALESMAN' AND sal < 1400 THEN sal * 1.1
             ELSE sal
        END AS bonus_sal,
        DECODE ( job , 'MANAGER',sal*1.1,
                       'PRESIDENT', sal * 1.2) bonus_sal2
--        NVL(bonus_sal2, bonus_sal)  

FROM emp;

SELECT a.*,NVL(bonus_sal2,bonus_sal)
     
FROM ( SELECT ename ,job, sal,
        CASE WHEN job = 'SALESMAN' AND sal > 1400 THEN sal * 1.05
             WHEN job = 'SALESMAN' AND sal < 1400 THEN sal * 1.1
             ELSE sal
        END AS bonus_sal,
        DECODE ( job , 'MANAGER',sal*1.1,
                       'PRESIDENT', sal * 1.2) bonus_sal2 
                       FROM emp)a;
-- 2 sem            
SELECT ename, job, sal,
        DECODE(job, 'SALESMAN', CASE 
                                    WHEN sal >1400 THEN sal* 1.05
                                    WHEN sal > 1400 THEN sal* 1.1
                                END,
                    'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2,sal) bonus_sal
                   
FROM emp;


