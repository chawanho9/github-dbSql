1. PRIMARY KEY ���� ���� ������ ����Ŭ dbms�� �ش� �÷����� unique index �� �ڵ����� �����Ѵ�.
   (***��Ȯ���� UNIQUE ���࿡ ���� UNIQUE �ε����� �ڵ����� �����ȴ�.
        PRIMARY KEY = UNIQUE + NOT NULL )
index : �ش� �÷����� �̸� ������ �س��� ��ü
������ �Ǿ� �ֱ� ������ ã���� �ϴ� ���� �����ϴ��� ������ �˼��� �ִ�.
���࿡ �ε����� ���ٸ� ���ο� �����͸� �Է��� ��  �ߺ��Ǵ� ���� ã�� ���ؼ� ���̺��� ��� �����͸�
ã�ƾ� �Ѵ�. ������ �ε����� ������ �̹� ������ �Ǿ� �ֱ� ������ �ش� ���� ���� ������ ������ �˼��ִ�.

2. FOREIGN KEY �������ǵ�
�����ϴ� ���̺� ���� �ִ����� Ȯ�� �ؾ��Ѵ�.
�׷��� �����ϴ� �÷��� �ε����� �־������ FOREIGN KEY ������ ������ ���� �ִ�.

FOREIGN KEY ������ �ɼ�
FOREIGN KEY (���� ���Ἲ) : �����ϴ� ���̺��� �÷��� �����Ѵ� ���� �Է� �� �� �ֵ��� ����
(ex : emp ���̺� ���ο� �����͸� �Է½� deptno �÷����� dept ���̺� �����ϴ� �μ���ȣ�� �Է� �� �� �ִ�);

FOREIGN KEY �� �����ʿ� ���� �����͸� ������ �� ������
� ���̺��� �����ϰ� �ִ� �����͸� �ٷ� ������ �ȵ�
(EX : EXMP.deptno  ==> DEPT.deptno �÷��� ���� �ϰ� ���� ��
      �μ� ���̺��� �����͸� ���� �� ���� ����);
      
SELECT *
FROM dept_test;
INSERT INTO dept_test VALUES (99,'ddit2','����');
INSERT INTO emp_test (empno,ename, deptno) VALUES (9999,'brown',99);
commit;

emp : 9999,99
dept : 98,99
==> 98�� �μ��� �����ϴ� emp���̺��� �����ʹ� ����
    99�� �μ��� �����ϴ� emp ���̺��� �����ʹ� 9999�� brown ����� ���� 
    
���࿡ ���� ������ �����ϰ� �Ǹ� ;
delete dept_test
where deptno 99;

emp ���̺��� �����ϴ� �����Ͱ� ���� 98�� �μ��� �����ϸ�??;
DELETE dept_test
WHERE deptno = 99;

SELECT * 
FROM emp_test;
--���̺� ���� ������ ����� , �����͸� � ������ �־������ ����� , ���� ������ ����ؾ���

FOREIGN KEY �ɼ�
1. ON DELETE CASCADE : �θ� ������ ��� (dept) �����ϴ� �ڽ� �����͵� ���� �����Ѵ�(emp);
2. ON DELETE SET NULL : �θ� ������ ��� (dept) �����ϴ� �ڽ� �������� �÷��� NULL �� ����;

emp_test���̺��� DROP �� �ɼ��� ������ ���� ������ �׽�Ʈ;

DROP TABLE emp_test;
CREATE TABLE  emp_tset(
    emp NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY(empno),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno) ON DELETE CASCADE
    );
INSERT INTO emp_test VALUES (9999,'brown',99);
commit;
emp ���̺��� deptno �÷��� dept ���̺��� deptno �÷��� ����(ON DELETE CASCADE)
�ɼǿ� ���� �θ����̺�(dept_test)������ �����ϰ� �ִ� �ڽ� �����͵� ���� �����ȴ�.;
DELETE dept_test
WHERE deptno = 99;

�ɼ� �ο����� �ʾ������� ���� delete ������ ������ �߻�;
�ɼǿ� ���� �����ϴ� �ڽ����̺��� �����Ͱ� ���������� ������ �Ǿ��µ� SELECT Ȯ��;

SELECT *
FROM emp_test;

FK ON DELET SET NULL �ɼ� �׽�Ʈ;
�θ� ���̺��� ������ ������ (dept_test) �ڽ����̺��� �����ϴ� �����͸� NULL�� ������Ʈ;
ROLLBACK;
SELECT *
FROM dept_test;

insert into dept_Test Values (99,'ddit','����');


SELECT*
FROM emp_test;
DROP TABLE emp_test;
CREATE TABLE  emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY(empno),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno) ON DELETE CASCADE
    );
INSERT INTO emp_test VALUES (9999,'brown',99);
commit;

dept_test ���̺��� 99�� �μ��� �����ϰ� �Ǹ� (�θ� ���̺��� �����ϸ�)
99�� �μ��� �����ϴ� emp_test ���̺��� 9999��(brown) �������� deptno �÷��� 
FK �ɼǿ� ���� NULL�� �����Ѵ�;

DELETE dept_test
WHERE deptno = 99;

�θ� ���̺��� ������ ���� �� �ڽ� ���̺��� �����Ͱ� NULL �� ����Ǿ����� Ȯ��;

SELECT * 
FROM emp_test;

CHECK �������� : �÷��� ���� ���� ������ ������ �� ���
ex : �޿� �÷��� ���ڷ� ����, �޿��� ������ �� �� ������?;
     �Ϲ����� ��� �޿����� > 0
     �޿����� 0���� ū ������ �˰���� EMP���̺��� job �÷��� ���� ���� ���� 4������ ���Ѱ��� 
     'SALESMAN','PRESIDENT','ANALYST','MANAGER';
���̺� ������ �÷� ����� �Բ� CHECK ���� ����
emp_test ���̺��� sal �÷��� 0���� ũ�ٴ� check �������� ����;

INSERT INTO dept_Test VALUES (99,'ddit','����');

DROP TABLE emp_Test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    sal NUMBER CHECK (sal > 0),
    
    CONSTRAINT PK_emp_test PRIMARY KEY (empno),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_Test (deptno)
);
INSERT INTO emp_test VALUES (9999,'brown',99,1000);
INSERT INTO emp_test VALUES (9999,'sally',99,-1000); sal üũ���ǿ� ���� 0���� ū ���� �Է°��� ;

���ο� ���̺� ����
CREATE TABLE ���̺�� (
    �÷�1....
);

CREATE TABLE ���̺�� AS
SELECT ����� ���ο� ���̺�� ����

emp ���̺��� �̿� �μ���ȣ�� 10�� ����鸸 ��ȸ�Ͽ� �ش� �����ͷ� 
emp_test2 ���̺��� ����;

SELECT *
FROM emp 
WHERE deptno =10;
drop table emp_Test2;
CREATE TABLE emp_test2 AS
SELECT *
FROM emp 
WHERE deptno =10;

SELECT *
FROM emp_test2;

SELECT *
FROM emp_20200210;

create table emp_20200201 AS
SELECT *
FROM emp 
WHERE deptno = 10;
--���� �����͸� ��ȣ

TABLE ����
1. �÷��߰�
2. �÷� ������ ����, Ÿ�Ժ���
3. �⺻�� ����
4. �÷����� RENAME
5. �÷��� ���� 
6. �������� �߰�/����

TABLE ���� 1. �÷� �߰�;

DROP TABLE emp_Test;

CREATE TABLE emp_Test (
    empno NUMBER(4),
    ename varchar2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY (empno),
    CONSTRAINT FK_emp_Test_dept_test FOREIGN KEY (deptno) REFERENCES dept_Test (deptno)
);    
--1.�÷� �߰�
ALTER TABLE ���̺�� ADD (�ű��÷��� �ű� �÷� Ÿ��);

ALTER TABLE emp_test ADD ( hp  VARCHAR2(20));

DESC emp_test;

--2.�÷� ������ ����, Ÿ�� ����
ex : �÷� VARCHAR2(20) ==> VARCHAR2(2)
     ������ �����Ͱ� ������ ��� ���������� ������ �ȵ� Ȯ���� �ſ� ���� 
     �Ϲ������� �����Ͱ� �������� �ʴ� ����, �� ���̺��� ������ ���Ŀ� �÷��� ������, Ÿ���� �߸� �� ���
     �÷�������, Ÿ���� ������.
     �����Ͱ� �Էµ� ���ķδ� Ȱ�뵵�� �ſ� ������(������ �ø��°͸� ����);   
     ex : hp VARCHAR2(20) ==> hp VARCHAR2(30);     
     
ALTER TABLE ���̺�� MODIFY (���� �÷��� ��ť �÷� Ÿ�� (������));
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));    

�÷� Ÿ�� ����
ex : hp VARCHAR2(20) ==> hp NUMBER;

ALTER TABLE emp_test MODIFY (hp NUMBER);
DESC emp_Test;

�÷� �⺻�� ����;
ALTER TABLE ���̺�� MODIFY (�÷��� DEFAULT �⺻��);
HP NUMBER==>VARCHAR2(20);

ALTER TABLE emp_test MODIFY (hp VARCHAR2(20) DEFAULT '010');
DESC emp_test;

hp �÷����� ���� ���� �ʾ����� DEFAULT ������ ���� '010' ���ڿ��� �⺻������ ����ȴ�;
INSERT INTO emp_test (empno, ename, deptno ) VALUES (9999,'brown',99);

SELECT *
FROM emp_test;

TABLE 4. ����� �÷� ����
ALTER TABLE ���̺�� RENAME COLUMN ���� �÷��� TO �ű� �÷���;
hp ==> hp_n;

ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;
SELECT *
FROM emp_Test;

--5. �÷� ����
ALTER TABLE ���̺�� DROP COLUMN �÷���
emp_test ���̺��� hp_n �÷� ����;

emp_test�� hp_a �÷��� �ִ� ���� Ȯ��;
SELECT*
FROM emp_test;


ALTER TABLE emp_test DROP COLUMN hp_n;
emp_test�� hp_a �÷��� �����Ǿ� �ִ��� Ȯ�� 
SELECT*
FROM emp_test;


--������ ���� 
1. emp_test ���̺��� drop�� empno,ename,deptno,hp 4���� �÷����� ���̺� ����
2. empno, ename,deptno 3���� �÷����� (9999,'brown',99) �����ͷ� INSERT
3. emp_test ���̺��� hp �÷��� �⺻���� '010'���� ����
4. 2�������� �Է��� �������� hp �÷� ���� ��� �ٲ���� Ȯ��
--defult���� ���� �̸� �������� deulft ���Ŀ� �ٲ��� ����
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;

TABLE ���� : 6. ���� ���� �߰� /����;
ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� �������� Ÿ�� (PRIMARY KEY , FOREIGN KEY) (�ش��÷�);
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

1. emp_test ���̺� ������ 
2. �������� ���� ���̺��� ����
3. PRIMARY KEY, FOREIGN KEY ������ ALTER TABLE ������ ���� ����;

DROP TABLE emp_Test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2)
    );
ALTER TABLE emp_test ADD CONSTRAINT PK_emp_test PRIMARY KEY (empno);
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno);

PRIMARY KEY �׽�Ʈ;
INSERT INTO emp_test VALUES (9999,'brown',99);
INSERT INTO emp_test VALUES (9999,'sally',99); ù���� insert ������ ���� �ߺ��ǹǷ� ����;

FOREIGN KEY �׽�Ʈ;
INSERT INTO emp_test VALUES (9998,'sally',98); dept_test ���̺� �������� �ʴ� �μ���ȣ�̹Ƿ� ����;

�������� ���� : PRIMARY KEY,FORIGN KEY;
ALTER TABLE emp_test DROP CONSTRAINT PK_emp_test;
ALTER TABLE emp_test DROP CONSTRAINT FK_emp_test_dept_test;

���������� �����Ƿ� empno�� �ߺ��� ���� �� �� �ְ�, dept_test���̺� �������� �ʴ� 
deptno ���� �� ���� �ִ�;

--�ߺ��� empno������ �������Է�
INSERT INTO emp_test VALUES (9999,'brown',99);
INSERT INTO emp_test VALUES (9999,'sally',99); ù���� insert ������ ���� �ߺ������� ����;

--�������� �ʴ� 98���μ��� ������ �Է�
INSERT INTO emp_test VALUES (9998,'sally',98);

SELECT*
FROM emp_Test;

primary key, foreign key 

not null, check,unique;

�������� Ȱ��ȭ/ ��Ȱ��ȭ 
ALTER TABLE ���̺�� ENABLE | DISABLE CONSTRAINT �������Ǹ�;

1.emp_test ���̺� ����
2.emp_test ���̺� ����
3.ALTER TABLE PRIMARY KEY(empno), FOREIGN KEY(dept_test) �������� ����
4.�ΰ��� ���������� ��Ȱ��ȭ
5.��Ȱ��ȭ�� �Ǿ����� INSERT�� ���� Ȯ��
6.���������� ������ �����Ͱ� �� ���¿��� �������� Ȱ��ȭ;

DROP TABLE emp_test;

CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2)
    );
ALTER TABLE emp_test ADD CONSTRAINT PK_emp_test PRIMARY KEY (empno);
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test FOREIGN KEY(deptno)
                                                          REFERENCES dept_test (deptno);
--4�� �ΰ��� �������� ��Ȱ��ȭ
ALTER TABLE emp_test DISABLE CONSTRAINT PK_emp_test;
ALTER TABLE emp_test DISABLE CONSTRAINT FK_emp_test_dept_test;

INSERT INTO   emp_test VALUES (9999,'brown',99);
INSERT INTO   emp_test VALUES (9999,'sally',98);    
commit;

SELECT*
FROM emp_test;

ALTER TABLE emp_test ENABLE CONSTRAINT PK_emp_test;
emp_test ���̺��� empno�÷��� ���� 9999�� ����� �θ� �����ϱ� ������
PRIMARY KEY ���������� Ȱ��ȭ �� ���� ����.
==> empno�÷��� ���� �ߺ����� �ʵ��� �����ϰ� �������� Ȱ��ȭ �� �� �ִ�.

SELECT*
FROM emp_test;

empno�ߺ� ������ ����;
DELETE emp_test
WHERE ename = 'brown';

PRIMARY KEY �������� Ȱ��ȭ
ALTER TABLE emp_test ENABLE CONSTRAINT PK_emp_test;


ALTER TABLE emp_test ENABLE CONSTRAINT FK_emp_test_dept_test;
dept_test ���̺� �������� �ʴ� �μ���ȣ98�� emp_test���� ������̶� ������ ��
1.dept_test���̺� 98�� �μ��� ����ϰų�
2.sally�� �μ���ȣ�� 99������ �����ϰų�
3.sally�� ����ų� 

UPDATE emp_test SET deptno = 99
WHERE ename = 'sally';
ALTER TABLE emp_test ENABLE CONSTRAINT FK_emp_test_dept_test;


