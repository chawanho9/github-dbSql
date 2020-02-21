


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANANGER'
AND ename LIKE 'C%';

SELECT*
FROM TABLE(dbms_xplan.display);
Plan hash value: 1112338291
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_02 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANANGER');

create index idx_n_emp_03 on emp(job,ename);   

EXPLAIN PLAN FOR
select*
from emp
where job = 'MANAGER' AND ename LIKE 'C%';

SELECT*
FROM TABLE(dbms_xplan.display);
Plan hash value: 4225125015


--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%');

1.table full
2.idx1 : empno
3.idx2 : job
4.idx3 : job + ename
5.idx4 : ename + job;

create index idx_n_emp_04 on emp(ename, job);


select ename, job, rowid
from emp 
order by ename, job;

3���� �ε����� ������ 
3,4, ���� �ε����� �÷� ������ �����ϰ� ������ �ٸ���

drop index idx_n_emp_03;
explain plan for
select*
from emp
where job = 'MANAGER'
AND ename like 'c%';

select*
from table(dbms_xplan.display);

Plan hash value: 1173072073
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_04 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("ENAME" LIKE 'c%' AND "JOB"='MANAGER')
       filter("JOB"='MANAGER' AND "ENAME" LIKE 'c%');
       
- �������� �����ϴ��ε����� �ִٰ� �ؼ� �׻� �ε����� ����ϴ� ���� �ƴ�;

emp - table full, pk_emp(empno)
dept - table full, pk_dept(deptno)

(emp-talbe full, dept-table full)
(emp-table full, dept-pk_dept)
(emp-pk_emp,dept-table full)
(emp-pk_emp,dept-pk_dept)

1���� 

2�� ���̺� ���� 
������ ���̺� �ε��� 5���� �ִٸ� 
�� ���̺� ���� ����: 6
36 * 2 = 72
oralce - �ǽð� ���� : oltp (on line transaction processing)
         ��ü ó�� �ð�: olap (on line analysis processing) - ������ ������ �����ȹ�� ����µ�
                                                            30��~1�ð� �ɸ�
                                                            
emp ���� ������ dept ���� ������??
explain plan for
select ename,dname,loc
from emp, dept
where emp.deptno = dept.deptno
and emp.empno= 7788;

select *
from table(dbms_xplan.display);

Plan hash value: 3070176698
 
----------------------------------------------------------------------------------------------
| Id  | Operation                     | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |              |     1 |    32 |     3   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                 |              |       |       |            |          |
|   2 |   NESTED LOOPS                |              |     1 |    32 |     3   (0)| 00:00:01 |
|   3 |    TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    13 |     2   (0)| 00:00:01 |
|*  4 |     INDEX RANGE SCAN          | IDX_N_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN          | PK_DEPT      |     1 |       |     0   (0)| 00:00:01 |
|   6 |   TABLE ACCESS BY INDEX ROWID | DEPT         |     1 |    19 |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")

--idx1 
--create table dept_test2 as select * from dept where 1=1
--�������� dept_test ���̺� ������ ���� ���ǿ� �´� �ε����� �����ۼ��� '
create table dept_test2 as select * from dept where 1=1;
create unique index idx_u_dept_test_01 on dept_test2(deptno);
create index idx_n_dept_test_02 on dept_test2(dname);
create index idx_n_dept_test_03 on dept_test2(deptno, dname);
drop index idx_u_dept_test_01 ;
CTAS 
�������� ���簡 NOT NULL �� �ȴ�
����̳� �׽�Ʈ ������ ��� ;

create table dept_test2 as select* from dept where 1=1;                --where 1=1  �ึ�� 1=1 ���Ѵ� ?  true�� �ǹ� 
create unique index idx_dept_test_01 on dept_test2 (deptno);
create index idx_n_dept_test_02 on dept_test2 (dname);
create index idx_dept_test_03 on dept_test (dname,deptno);
--SEM
 CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2(deptno);
 CREATE INDEX idx_n_dept_test2_02 ON dept_test2(dname);
 CREATE INDEX idx_n_dept_test2_03 ON dept_test2(deptno,dname);
 
 
 --idx2
 drop index idx_dept_test_01;
 drop index idx_n_dept_test_02;
 drop index idx_dept_test_03;
 
 --idx3
 �ý��ۿ��� ����ϴ� ������ ������ ���ٰ� �� �� ������ emp ���̺� �ʿ��ϴٸ� �����Ǵ� �ε����� ���� ��ũ��Ʈ�� ��������;
 
 --1.empno ������ ��ȣ (�ߺ��� �Ǹ� �ȵ�);-------------------------------------------
 alter table emp add constraint pk_emp_empno primary key (empno);
 --�����̸Ӹ� Ű�� ���� ���ָ� �ڵ������� unique index�� ������ �Ǿ�
 --empno�� �ߺ��� �ɼ� ���� ����
 select*
 from emp
 where  empno = :empno;
 ----------------------------------------------------------------------------------
 --2.enme�� �ߺ��� �Ǿ���ϹǷ� (��������) ���������� �������� �ʰ� �ε����� ������������ 
 
 select *
 from emp
 where ename = : ename;
 -----------------------------------------------------------------------------------
 --3.join������ ������ empno�� '%', full table ��ȸ 
 -- ���� empno �� 1�ﰳ�� �����͸� ������ ������ �δ��� �ɼ��ִ�.
 select *
 from emp,dept
 where emp.deptno = dept.deptno
 and emp.deptno = : deptno;
 
  2.sal ,deptno index ����;
 create index idx_n_emp_01 on emp(sal, deptno);
 ----------------------------------------------------------------------
 --4.
 explain plan for
 select *
 from emp 
 where sal between : st_sal and : ed_sal
 and deptno  = : deptno ;
 
 select* from table(dbms_xplan.display);
 -------------------------------------------------------------------------------------------------
 Plan hash value: 825334541
 
---------------------------------------------------------------------------------------------
| Id  | Operation                    | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |              |     1 |    38 |     2   (0)| 00:00:01 |
|*  1 |  FILTER                      |              |       |       |            |          |
|   2 |   TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  3 |    INDEX RANGE SCAN          | IDX_N_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
---------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_NUMBER(:ST_SAL)<=TO_NUMBER(:ED_SAL))
   3 - access("SAL">=TO_NUMBER(:ST_SAL) AND "DEPTNO"=TO_NUMBER(:DEPTNO) AND 
              "SAL"<=TTNO)O_NUMBER(:ED_SAL))
       filter("DEPTNO"=TO_NUMBER(:DEP);
 ---------------------------------------------------------------------------------------------------
--5.  emp ���� ���� �����̴�. �������� �Ŵ��� �ѹ��� �����ѹ��� ���ٴ� ������ ����
-- �μ����� ������ ���ֱ� ���� �ε��� ����
create index idx_n_emp_02 on emp(deptno);

explain plan for
 select B.*
 from emp A, emp B
 WHERE A.mgr = B.empno
 AND A.deptno = : deptno;
 
 select *
 from table (dbms_xplan.display);
 
 Plan hash value: 2381361690
 6-5-3
----------------------------------------------------------------------------------------------
| Id  | Operation                     | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |              |     4 |   180 |     5  (20)| 00:00:01 |
|   1 |  MERGE JOIN                   |              |     4 |   180 |     5  (20)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID | EMP          |    14 |   532 |     2   (0)| 00:00:01 |
|   3 |    INDEX FULL SCAN            | PK_EMP_EMPNO |    14 |       |     1   (0)| 00:00:01 |
|*  4 |   SORT JOIN                   |              |     4 |    28 |     3  (34)| 00:00:01 |
|*  5 |    TABLE ACCESS BY INDEX ROWID| EMP          |     4 |    28 |     2   (0)| 00:00:01 |
|*  6 |     INDEX RANGE SCAN          | IDX_N_EMP_02 |     5 |       |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("A"."MGR"="B"."EMPNO")
       filter("A"."MGR"="B"."EMPNO")
   5 - filter("A"."MGR" IS NOT NULL)
   6 - access("A"."DEPTNO"=TO_NUMBER(:DEPTNO))
   ---------------------------------------------------------------------------------
 
 
 
 
 
 
 
 
 select deptno, TO_CHAR(hiredate , ' yyyymm'),
        count(*) cnt
from emp
group by deptno, to_char(hiredate, 'yyyymm');
 

 --sem
 access pattarn
 
 ename(=)
 dpetno(=), empno(LIKE ������ȣ%) ==> empno, deptno 
 
 DEPTNO(=), Sal(BETWWN);
 deptno (=) / mgr �����ϸ� ����,
 deptno,hiredate �� �ε��� �����ϸ� ����
 
 deptno, sal, mhr, hiredate
 
 
 --idx3;
 
select*
from emp
where empno = :empno;

SELECt *
FROM emp
WHERE empno = :empno ;

 
 
 

 