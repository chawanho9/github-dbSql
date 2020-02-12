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
WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE WHERE;

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
