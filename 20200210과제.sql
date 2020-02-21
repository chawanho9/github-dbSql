Drop table emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(4),
    hp VARCHAR2(20)
);
INSERT INTO emp_test (empno, ename, deptno)VALUES(9999,'brown',99);
ALTER TABLE emp_test MODIFY (hp DEFAULT '010');

SELECT *
FROM emp_test;
------------------------------------------------------------------------------
�������� Ȯ�� ���
1. tool
2. dictrionary view
�������� : USER_CONSTRAINTS
���� ���� - �÷� : UWER_CONS_COLUMNS
���������� ��� �÷��� ���õǾ� �ִ��� �˼� ���� ������ ���̺��� ������ �и��Ͽ� ����;


SELECT* 
FROM USER_CONSTRAINTS
WHERE table_name IN('EMP','DEPT','EMP_TEST','DEPT_TEST');

EMP, DEPT PK, FK ������ �������� ����
���̺� �������� �������� �߰�;
2.EMP : pk(empno)
3.      fk (depno) - dept.deptno (fk ������ �����ϱ� ���ؼ��� �����ϴ� ���̺� �÷��� �ε����� ���� �ؾ� �Ѵ�);

1. dept : pk (deptno);

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept ( deptno);


--���̺�,�÷�,�ּ�
SELECT*
FROM member;

���̺�, �÷� �ּ� : DICTIONARY Ȯ�� ����
���̺� �ּ� : USER_TAB_COMMENTS
�÷� �ּ� : USER_COL_COMMENTS;


�ּ� ����
���̺� �ּ� : COMMENT ON TABLE ���̺�� IS '�ּ�'
�÷� �ּ� : COMMENT ON COLUMN ���̺�.�÷� IS '�ּ�';

emp :  ����;
dept : �μ�;

COMMENT ON TABLE emp IS '����';
COMMENT ON TABLE dept IS '�μ�';
SELECT*
FROM user_tab_comments
WHERE table_name in ('EMP','DEPT');

SELECT *
FROM USER_COL_COMMENTS;

SELECT*
FROM user_COL_comments
WHERE table_name in ('EMP','DEPT');
DEPT	DEPTNO  : �μ���ȣ
DEPT	DNAME   : �μ���
DEPT	LOC     : �μ���ġ
EMP	EMPNO       : ������ȣ
EMP	ENAME       : �����̸�
EMP	JOB         : ������
EMP	MGR         : �Ŵ��� ������ȣ
EMP	HIREDATE    : �Ի�����    
EMP	SAL         : �޿� 
EMP	COMM        : ������   
EMP	DEPTNO      : �ҼӺμ���ȣ

COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ';

COMMENT ON COLUMN emp.deptno IS '������ȣ';
COMMENT ON COLUMN emp.ename IS '�����̸�';
COMMENT ON COLUMN emp.job IS '������';
COMMENT ON COLUMN emp.mgr IS '�Ŵ��� ������ȣ';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';
COMMENT ON COLUMN emp.sal IS '�޿�';
COMMENT ON COLUMN emp.comm IS '������';
COMMENT ON COLUMN emp.deptno IS '�ҼӺμ���ȣ';


select*
from user_tab_comments;

select *
from user_col_comments;

select*
from user_tab_comments t join user_col_comments c
on (t.table_name= c.table_name)
where t.table_name in ('CUSTOMER','PRODUCT','CYCLE','DAILY');

VIEW = QUERY 
TABLE ó�� DBMS�� �̸��ۼ��� ��ü
==> �ۼ����� �ʰ� QUERY���� �ٷ� �ۼ��� VIEW : IN-LINEVUEW ==> �̸��� ���� ������ ��Ȱ���� �Ұ�
VIEW �� ���̺��̴� (X)

������
1. ���� ����(Ư¡ �÷��� �����ϰ� ������ ����� �����ڿ� ����)
2. INLINE -VIEW �� VIEW�� �����Ͽ� ��Ȱ��
    . ���� ���� ����
    
�������
CREATE [OR REPLACE] VIEW �� ��Ī [ (column1, column2 ....)] AS
SUBQUERY;

emp ���̺��� 8���� �÷��� sal,comm �÷��� ������ 6�� �÷��� �����ϴ� v_emp view����;

CREATE OR REPLACE VIEW v_emp AS 
SELECT empno,ename, job, mgr, hiredate , deptno
FROM emp;

�ý��� �������� wano �������� view �������� �߰�
GRANT CREATE VIEW TO wano;

���� �ζ��� ��� �ۼ���;
SELECT* 
FROM (SELECT empno,ename,job,mgr,hiredate ,deptno
from emp);

view ��üȰ��
select*
from v_emp;

emp���̺��� �μ����� ���� ==> dept ���̺�� ������ ����ϰ� ����
���ε� ����� view�� ���� �س����� �ڵ带 �����ϰ� �ۼ��ϴ°� ����;

dname(�μ���),empno(������ȣ),ename(�����̸�),job(������),hiredate(�Ի�����);

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT dept.dname, emp.empno,emp.job,emp.hiredate
FROM emp,dept
WHERE emp.deptno = dept.deptno;

�ζ��� ��� �ۼ���;
select*
from (SELECT dept.dname, emp.empno,emp.job,emp.hiredate
FROM emp,dept
WHERE emp.deptno = dept.deptno);

view Ȱ���;
select*
from v_emp_dept;

smith ���� ������ v_emp_dept view �Ǽ� ��ȭ�� Ȯ��;
delete emp
WHERE ename = 'SMITH';

view �� �������� �����͸� ���� ������ , ������ �������� ���� ����(SQL) �̱� ������
VIEW ���� �����ϴ� ���̺��� �����Ͱ� ������ �Ǹ� VIEW�� ��ȸ ����� ������ �޴´�.
rollback;

SEQUENCE : ������ - �ߺ����� �ʴ� �������� �������ִ� ����Ŭ ��ü
CREATE SEQUENCE ������_�̸�
[OPTION....]
����Ģ: seq_���̺��;

create sequence seq_emp;

������ ���� �Լ�
nextval : ���������� ���� ���� �����Ë� ��� 
currval : newxtval �� ����ϰ��� ���� �о� ���� ���� ��Ȯ��;


������ ������
rollback�� �ϴ��� nextval�� ���� ���� ���� �����ǣ� �ʴ´�.
nextval�� ���� ���� �޾ƿ��� �� ���� �ٽ� ����� �� ����.;
select seq_emp.nextval
from dual;

select*
from emp_test;

INDEX ; 

SELECT ROWID, emp.*
from emp;

SELECT*
FROM emp 
WHERE ROWID= 'AAAE5dAAFAAAACLAAH';

�ε����� ������ empno ������ ��ȸ�ϴ� ��� ;
emp ���̺��� pk_emp ���������� �����Ͽ� empno �÷����� �ε����� �������� �ʴ� ȯ���� ����;

alter table emp drop constraint pk_emp;

explain plan for
select*
from EMP
where empno = 7782;

select*
from table (dbms_xplan.display);


emp ���̺��� empno �÷����� pk������ �����ϰ� ������ sql�� ���� 
pk : unique + not null
    (unique �ε����� �������ش�)
    ==> empno �÷����� unique �ε����� ������
    
    �ε����� sql �� �����ϰ� �Ǹ��ε����� ���� ���� ��� �ٸ��� �������� Ȯ��;
    
alter table emp add constraint pk_emp primary key (empno);    

select rowid,emp.*
from emp;

select empno,rowid
from emp
order by empno;

explain plan for
SELECT*
FROM EMP 
WHERE empno = 7782;

select *
from table (dbms_xplan.display);
-- ���� �ᤩ�� index �� ������ ���Ǵ� ������ ���͸� ��ġ�� �ǰ� 
-- index�� ������ access ������ ��ġ�Ƿ� �ӵ��鿡�� �� ����ϵ�! ��!

SELECT*
FROM emp 
WHERE ename = 'SMITH';

SELECT ��ȸ�÷��� ���̺� ���ٿ� ��ġ�� ���� 
SELECT *FROM emp WHERE  depno = 7782
 ==>
 SELECT empno FROM emp WHERE empno = 7782
 
 EXPLAIN PLAN FOR
 SELECT empno
 FROM emp
  WHERE empno =7782;
  
  select *
  from table (dbms_xplan.display);
   
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
--------------------------------------------------;


unique vs non-unique �ε����� ���� Ȯ�� 
1.pk_emp ����
2.empno �÷����� non-unique �ε��� ����
3.���� ��ȹ Ȯ��;

alter table emp drop constraint pk_emp;
create index idx_n_emp_01 on emp (empno);


explain plan for
select * 
from emp where empno = 7782; 

select *
from table(dbms_xplan.display);

Plan hash value: 2778386618
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)
   
emp ���̺� job �÷��� �������� �ϴ� ���ο� non-unique �ε����� ����;

create index idx_n_emp_02 on emp (job);

select job, rowid
from emp
order by job;

���ð����� ����
1. emp ���̺��� ��ü�б� 
2. idx_n_emp_01 �ε��� Ȱ��
3. idx_n_emp_02 �ε��� Ȱ�� 

EXPLAIN PLAN FOR
select* 
from emp
where job = 'MANAGER';

SELECT* 
FROM TABLE (DBMS_XPLAN.DISPLAY);

Plan hash value: 1112338291
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     3 |   114 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     3 |   114 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')
   
   COMMIT;
   
   
   