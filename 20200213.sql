DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno number(4),
    ename varchar2(10),
    deptno number(2),
    hp  varchar2(20)
);
ALTER TABLE emp_test MODIFY (hp DEFAULT '010');


SELECT *
FROM emp_test;

DELETE emp_test;

--�α׸� �ȳ����. ==>������ �ȵȴ� -->�׽�Ʈ ������ ���� ��
TRUNCATE TABLE emp_test;

--emp���̺��� emp_test���̺�� �����Ѵ�.(7369-SMITH)

INSERT INTO emp_test
SELECT empno, ename, deptno, '010'
FROM emp
WHERE empno = 7369;

--�����Ͱ� �� �Է� �Ǿ����� Ȯ��;
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

COMMIT;

--emp���̺��� ��� ������ emp_test���̺�� ������ ����
--emp���̺��� ���������� emp_test���� �������� ������ insert
--emp���̺��� �����ϰ� emp_test���� �����ϸ� ename, deptno�� update


--emp���̺� �����ϴ� 14���� �������� emp_test���� �����ϴ�  7369 �� ������ 13���� �����Ͱ� 
--emp_test ���̺� �űԷ� �Է��� �ǰ�
--emp_test�� �����ϴ� 7369���� �����ʹ� ename(brown)�� emp ���̺� �����ϴ� �̸��� SMITH�� ����
MERGE INTO emp_test a
USING emp b
ON (a.empno= b.empno)
WHEN MATCHED THEN
    update set a.ename = b.ename,
                a.deptno = b.deptno
WHEN NOT MATCHED THEN
    INSERT (empno, ename, deptno) VALUES (b.empno, b.ename, b.deptno);

SELECT *
FROM emp_test;


--�ش� ���̺� �����Ͱ� ������ insert, ������ update
--emp_test���̺� ����� 9999���� ����� ������ ���Ӱ� insert
--������ update
--(9999,'brown',10,'010')

INSERT INTO emp_test VALUES (9999,'brown',10,'010');
UPDATE emp_test SET ename = 'brown',
                    deptno = 10,
                    hp = '010'
WHERE empno = 9999;

SELECT *
FROM emp_test;


MERGE INTO emp_test
USING dual
ON (empno = 9999)
WHEN MATCHED THEN
    UPDATE SET ename = 'brown',
                deptno = 10,
                hp = '010'
WHEN NOT MATCHED THEN
    INSERT VALUES (9999,'brown',10,'010');


SELECT *
FROM emp_test;
--MERGE, window function(�м��Լ�)


--merge--
--MERGE INTO ���̺�� [alias]
--USING (TABLE | VIEW | IN-LINE-VIEW)
--ON (��������)                         
--WHEN MATCHED THEN    (���࿡ ���⼭ �����ϴ� �����Ͱ� �ִٸ�)
--  UPDATE SET coll = �÷���, col2 = �÷���
--WHEN NOT MATCHED THEN        (���࿡ ���⼭ �����ϴ� �����Ͱ� ���ٸ�)
--  INSERT (�÷�1, �÷�2, �÷�3...)VALUES (�÷���1, �÷���2....);


DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno number(4),
    ename varchar2(10),
    deptno number(2),
    hp  varchar2(20)
);
ALTER TABLE emp_test MODIFY (hp DEFAULT '010');


SELECT *
FROM emp_test;

DELETE emp_test;

--�α׸� �ȳ����. ==>������ �ȵȴ� -->�׽�Ʈ ������ ���� ��
TRUNCATE TABLE emp_test;

--emp���̺��� emp_test���̺�� �����Ѵ�.(7369-SMITH)

INSERT INTO emp_test
SELECT empno, ename, deptno, '010'
FROM emp
WHERE empno = 7369;

--�����Ͱ� �� �Է� �Ǿ����� Ȯ��;
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

COMMIT;

--emp���̺��� ��� ������ emp_test���̺�� ������ ����
--emp���̺��� ���������� emp_test���� �������� ������ insert
--emp���̺��� �����ϰ� emp_test���� �����ϸ� ename, deptno�� update


--emp���̺� �����ϴ� 14���� �������� emp_test���� �����ϴ�  7369 �� ������ 13���� �����Ͱ� 
--emp_test ���̺� �űԷ� �Է��� �ǰ�
--emp_test�� �����ϴ� 7369���� �����ʹ� ename(brown)�� emp ���̺� �����ϴ� �̸��� SMITH�� ����
MERGE INTO emp_test a
USING emp b
ON (a.empno= b.empno)
WHEN MATCHED THEN
    update set a.ename = b.ename,
                a.deptno = b.deptno
WHEN NOT MATCHED THEN
    INSERT (empno, ename, deptno) 
    VALUES (b.empno, b.ename, b.deptno);

SELECT *
FROM emp_test;


--�ش� ���̺� �����Ͱ� ������ insert, ������ update
--emp_test���̺� ����� 9999���� ����� ������ ���Ӱ� insert
--������ update
--(9999,'brown',10,'010')

INSERT INTO emp_test VALUES (9999,'brown',10,'010');

UPDATE emp_test SET ename = 'brown',
                    deptno = 10,
                    hp = '010'
WHERE empno = 9999;

SELECT *
FROM emp_test;


MERGE INTO emp_test
USING dual
ON (empno = 9999)
WHEN MATCHED THEN
    UPDATE SET ename = 'brown',
                deptno = 10,
                hp = '010'
WHEN NOT MATCHED THEN
    INSERT VALUES (9999,'brown',10,'010');


SELECT *
FROM emp_test;
--MERGE, window function(�м��Լ�)

--report group funcion
--�μ��� �հ�, ��ü �հ踦 ������ ���� ���Ϸ���??(�ǽ�(group_ad1)
SELECT deptno,sum(sal)
FROM emp
GROUP BY deptno
ORDER BY deptno;

SELECT deptno, sum(sal)
FROM emp
GROUP BY deptno
union 
SELECT null ,sum(sal)
FROM emp;
--�Ұ�� ��ü���� ���ƴ�.



--I/O
--CPU CASHE > RAM > SSD > HDD > NETWORK
--REPORT GROUP FUNCTION
--ROLLUP
--CUBE
--GROUPING;

--------------------------------------------------ppt
rollup - �׷���̸� Ȯ���Ѱ�, ���� �׷��� �����Ѵ�, 
������ : group by rollup (�÷�1,�÷�2....)
subgroup�� �ڵ������� ����
subgroup�� �����ϴ� ��Ģ : roll�� ����� �÷��� �����ʿ��� ���� �ϳ��� �����ϸ鼭 
                         sub group�� ����
ek : group by rollup (deptno)
==>
ù���� sub group : group by deptno 
�ι��� sub group : group by null ==> �������� ���

group_ad1�� group by rollup���� ����Ͽ� �ۼ�;
select deptno,sum(sal)
from emp
group by rollup (deptno);

select job, deptno, 
       grouping(job),
       grouping (deptno)+sum(sal + nvl(comm,0)) sal
from emp                                            
group by rollup (job,deptno);

1.group by job, deptno : ������ , �μ��� �޿���
2.group by job : ������ �޿���
3.group by  : ��ü �޿��� 



--gorup_ad2 ���� �ۼ� 
select case grouping(job)
            when  1 then '����'
       else job 
       end job, deptno, 
       grouping (deptno),sum(sal + nvl(comm,0)) sal
       
from emp
group by rollup (job,deptno);

--decode���



--group_ad2-1 ����  : 2�� decode , case;
Dcode(���� ,����x,)
select 
    decode (grouping(job),1,'��',0,job) job,   
    decode (grouping(deptno),1, decode (grouping(job),1,'��',0,'�Ұ�')  ,0,decode(grouping(job),0,deptno,1,deptno)) deptno
   ,grouping (deptno),sum(sal + nvl(comm,0)) sal
    
from emp
group by rollup (job,deptno);




