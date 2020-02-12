Drop table emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(4),
    hp VARCHAR2(20) NOT NULL
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
WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE;

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
