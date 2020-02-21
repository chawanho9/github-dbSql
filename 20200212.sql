


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

3번쨰 인덱스를 지우자 
3,4, 번쨰 인덱스가 컬럼 구성이 동일하고 순서만 다르다

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
       
- 조건절에 부합하는인덱스가 있다고 해서 항상 인덱스를 사용하는 것은 아님;

emp - table full, pk_emp(empno)
dept - table full, pk_dept(deptno)

(emp-talbe full, dept-table full)
(emp-table full, dept-pk_dept)
(emp-pk_emp,dept-table full)
(emp-pk_emp,dept-pk_dept)

1순서 

2개 테이블 조인 
각각의 테이블에 인덱스 5개씩 있다면 
한 테이블에 접근 전략: 6
36 * 2 = 72
oralce - 실시간 응답 : oltp (on line transaction processing)
         전체 처리 시간: olap (on line analysis processing) - 복잡한 쿼리의 실행계획을 세우는데
                                                            30분~1시간 걸림
                                                            
emp 부터 읽을까 dept 부터 읽을까??
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
--구문으로 dept_test 테이블 생성후 다음 조건에 맞는 인덱스를 생서앟세요 '
create table dept_test2 as select * from dept where 1=1;
create unique index idx_u_dept_test_01 on dept_test2(deptno);
create index idx_n_dept_test_02 on dept_test2(dname);
create index idx_n_dept_test_03 on dept_test2(deptno, dname);
drop index idx_u_dept_test_01 ;
CTAS 
제약조건 복사가 NOT NULL 만 된다
백업이나 테스트 용으로 사용 ;

create table dept_test2 as select* from dept where 1=1;                --where 1=1  행마다 1=1 비교한다 ?  true를 의미 
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
 시스템에서 사용하는 쿼리가 다음과 같다고 할 떄 적절한 emp 테이블에 필요하다면 생각되는 인덱스를 생성 스크립트를 만들어보세요;
 
 --1.empno 고유한 번호 (중복이 되면 안됨);-------------------------------------------
 alter table emp add constraint pk_emp_empno primary key (empno);
 --프라이머리 키를 설정 해주면 자동적으로 unique index가 생성이 되어
 --empno가 중복이 될수 없게 생성
 select*
 from emp
 where  empno = :empno;
 ----------------------------------------------------------------------------------
 --2.enme은 중복이 되어야하므로 (동명이인) 제약조건을 설정하지 않고 인덱스도 설정하지않음 
 
 select *
 from emp
 where ename = : ename;
 -----------------------------------------------------------------------------------
 --3.join쿼리로 조건은 empno가 '%', full table 조회 
 -- 만약 empno 가 1억개의 데이터를 가지고 있으면 부담이 될수있다.
 select *
 from emp,dept
 where emp.deptno = dept.deptno
 and emp.deptno = : deptno;
 
  2.sal ,deptno index 생성;
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
--5.  emp 내부 조인 쿼리이다. 조건절에 매니저 넘버랑 직원넘버가 같다는 조건이 있음
-- 부서별로 정렬을 해주기 위해 인덱스 생성
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
 dpetno(=), empno(LIKE 직원번호%) ==> empno, deptno 
 
 DEPTNO(=), Sal(BETWWN);
 deptno (=) / mgr 동반하면 유리,
 deptno,hiredate 가 인덱스 존재하면 유리
 
 deptno, sal, mhr, hiredate
 
 
 --idx3;
 
select*
from emp
where empno = :empno;

SELECt *
FROM emp
WHERE empno = :empno ;

 
 
 

 