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
제약조건 확인 방법
1. tool
2. dictrionary view
제약조건 : USER_CONSTRAINTS
제약 조건 - 컬럼 : UWER_CONS_COLUMNS
제약조건이 몇개의 컬럼에 관련되어 있는지 알수 없기 떄문에 테이블을 별도로 분리하여 설계;


SELECT* 
FROM USER_CONSTRAINTS
WHERE table_name IN('EMP','DEPT','EMP_TEST','DEPT_TEST');

EMP, DEPT PK, FK 제약이 존재하지 않음
테이블 수정으로 제약조건 추가;
2.EMP : pk(empno)
3.      fk (depno) - dept.deptno (fk 제약을 생성하기 위해서는 참조하는 테이블 컬럼에 인덱스가 존재 해야 한다);

1. dept : pk (deptno);

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept ( deptno);


--테이블,컬럼,주석
SELECT*
FROM member;

테이블, 컬럼 주석 : DICTIONARY 확인 가능
테이블 주석 : USER_TAB_COMMENTS
컬럼 주석 : USER_COL_COMMENTS;


주석 생성
테이블 주석 : COMMENT ON TABLE 테이블명 IS '주석'
컬럼 주석 : COMMENT ON COLUMN 테이블.컬럼 IS '주석';

emp :  직원;
dept : 부서;

COMMENT ON TABLE emp IS '직원';
COMMENT ON TABLE dept IS '부서';
SELECT*
FROM user_tab_comments
WHERE table_name in ('EMP','DEPT');

SELECT *
FROM USER_COL_COMMENTS;

SELECT*
FROM user_COL_comments
WHERE table_name in ('EMP','DEPT');
DEPT	DEPTNO  : 부서번호
DEPT	DNAME   : 부서명
DEPT	LOC     : 부서위치
EMP	EMPNO       : 직원번호
EMP	ENAME       : 직원이름
EMP	JOB         : 담당업무
EMP	MGR         : 매니저 직원번호
EMP	HIREDATE    : 입사일자    
EMP	SAL         : 급여 
EMP	COMM        : 성과급   
EMP	DEPTNO      : 소속부서번호

COMMENT ON COLUMN dept.deptno IS '부서번호';
COMMENT ON COLUMN dept.dname IS '부서명';
COMMENT ON COLUMN dept.loc IS '부서위치';

COMMENT ON COLUMN emp.deptno IS '직원번호';
COMMENT ON COLUMN emp.ename IS '직원이름';
COMMENT ON COLUMN emp.job IS '담당업무';
COMMENT ON COLUMN emp.mgr IS '매니저 직원번호';
COMMENT ON COLUMN emp.hiredate IS '입사일자';
COMMENT ON COLUMN emp.sal IS '급여';
COMMENT ON COLUMN emp.comm IS '성과급';
COMMENT ON COLUMN emp.deptno IS '소속부서번호';


select*
from user_tab_comments;

select *
from user_col_comments;

select*
from user_tab_comments t join user_col_comments c
on (t.table_name= c.table_name)
where t.table_name in ('CUSTOMER','PRODUCT','CYCLE','DAILY');

VIEW = QUERY 
TABLE 처럼 DBMS에 미리작성한 객체
==> 작성하지 않고 QUERY에서 바로 작성한 VIEW : IN-LINEVUEW ==> 이름이 없기 때문에 재활용이 불가
VIEW 는 테이블이다 (X)

사용목적
1. 보안 목적(특징 컬럼을 제외하고 나머지 결과만 개발자에 제공)
2. INLINE -VIEW 를 VIEW로 생성하여 재활용
    . 쿼리 길이 단축
    
생성방법
CREATE [OR REPLACE] VIEW 뷰 명칭 [ (column1, column2 ....)] AS
SUBQUERY;

emp 테이블에서 8개의 컬럼중 sal,comm 컬럼을 제외한 6개 컬럼을 제공하는 v_emp view생성;

CREATE OR REPLACE VIEW v_emp AS 
SELECT empno,ename, job, mgr, hiredate , deptno
FROM emp;

시스템 계정에서 wano 계정으로 view 생성권한 추가
GRANT CREATE VIEW TO wano;

기존 인라인 뷰로 작성시;
SELECT* 
FROM (SELECT empno,ename,job,mgr,hiredate ,deptno
from emp);

view 객체활용
select*
from v_emp;

emp테이블에는 부서명이 없음 ==> dept 테이블과 조인을 빈번하게 진행
조인된 결과를 view로 생성 해놓으면 코드를 간결하게 작성하는게 가능;

dname(부서명),empno(직원번호),ename(직원이름),job(담당업무),hiredate(입사일자);

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT dept.dname, emp.empno,emp.job,emp.hiredate
FROM emp,dept
WHERE emp.deptno = dept.deptno;

인라인 뷰로 작성시;
select*
from (SELECT dept.dname, emp.empno,emp.job,emp.hiredate
FROM emp,dept
WHERE emp.deptno = dept.deptno);

view 활용시;
select*
from v_emp_dept;

smith 직원 삭제후 v_emp_dept view 건수 변화를 확인;
delete emp
WHERE ename = 'SMITH';

view 는 물리적은 데이터를 갖지 ㅇ낳고 , 논리적인 데이터의 정의 집합(SQL) 이기 떄문에
VIEW 에서 참조하는 테이블의 데이터가 변경이 되면 VIEW의 조회 결과도 영향을 받는다.
rollback;

SEQUENCE : 시퀀스 - 중복되지 않는 정수값을 리턴해주는 오라클 객체
CREATE SEQUENCE 시퀀스_이름
[OPTION....]
명명규칙: seq_테이블명;

create sequence seq_emp;

시퀀스 제공 함수
nextval : 시퀀스에서 다음 값을 가져올떄 사용 
currval : newxtval 을 사용하고나서 현재 읽어 들인 값을 재확인;


시퀀스 주의점
rollback을 하더라도 nextval을 통해 얻은 값이 원복되짆 않는다.
nextval을 통해 값을 받아오면 그 값을 다시 사용할 수 없다.;
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

인덱스가 없을떄 empno 값으로 조회하는 경우 ;
emp 테이블에서 pk_emp 제약조건을 삭제하여 empno 컬럼으로 인덱스가 존재하지 않는 환경을 조성;

alter table emp drop constraint pk_emp;

explain plan for
select*
from EMP
where empno = 7782;

select*
from table (dbms_xplan.display);


emp 테이블의 empno 컬럼으로 pk제약을 생성하고 동일한 sql을 실행 
pk : unique + not null
    (unique 인덱스를 생성해준다)
    ==> empno 컬럼으로 unique 인덱스가 생성됨
    
    인덱스로 sql 을 실행하게 되면인덱스가 없을 떄의 어떻게 다른지 차이점을 확인;
    
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
-- 나의 결ㄹ론 index 가 없으면 계산되는 과정이 필터링 거치게 되고 
-- index가 있으면 access 과정을 거치므로 속도면에서 더 우월하돠! 왁!

SELECT*
FROM emp 
WHERE ename = 'SMITH';

SELECT 조회컬럼이 테이블 접근에 미치는 영향 
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


unique vs non-unique 인덱스의 차이 확인 
1.pk_emp 삭제
2.empno 컬럼으로 non-unique 인덱스 생성
3.실행 계획 확인;

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
   
emp 테이블에 job 컬럼을 기준으로 하는 새로운 non-unique 인덱스를 생성;

create index idx_n_emp_02 on emp (job);

select job, rowid
from emp
order by job;

선택가능한 사항
1. emp 테이블을 전체읽기 
2. idx_n_emp_01 인덱스 활용
3. idx_n_emp_02 인덱스 활용 

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
   
   
   