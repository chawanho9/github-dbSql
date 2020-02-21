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

--로그를 안남긴다. ==>복구가 안된다 -->테스트 용으로 많이 씀
TRUNCATE TABLE emp_test;

--emp테이블에서 emp_test테이블로 복사한다.(7369-SMITH)

INSERT INTO emp_test
SELECT empno, ename, deptno, '010'
FROM emp
WHERE empno = 7369;

--데이터가 잘 입력 되었는지 확인;
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

COMMIT;

--emp테이블의 모든 직원을 emp_test테이블로 통합을 하자
--emp테이블에는 존재하지만 emp_test에는 존재하지 않으면 insert
--emp테이블에는 존재하고 emp_test에는 존재하면 ename, deptno를 update


--emp테이블에 존재하는 14건의 데이터중 emp_test에도 존재하는  7369 를 제외한 13건의 데이터가 
--emp_test 테이블에 신규로 입력이 되고
--emp_test에 존재하는 7369번의 데이터는 ename(brown)이 emp 테이블에 존재하는 이름인 SMITH로 갱신
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


--해당 테이블에 데이터가 있으면 insert, 없으면 update
--emp_test테이블에 사번이 9999번인 사람이 없으면 새롭게 insert
--있으면 update
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
--MERGE, window function(분석함수)


--merge--
--MERGE INTO 테이블명 [alias]
--USING (TABLE | VIEW | IN-LINE-VIEW)
--ON (조인조건)                         
--WHEN MATCHED THEN    (만약에 여기서 만족하는 데이터가 있다면)
--  UPDATE SET coll = 컬럼값, col2 = 컬럼값
--WHEN NOT MATCHED THEN        (만약에 여기서 만족하는 데이터가 없다면)
--  INSERT (컬럼1, 컬럼2, 컬럼3...)VALUES (컬럼값1, 컬럼값2....);


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

--로그를 안남긴다. ==>복구가 안된다 -->테스트 용으로 많이 씀
TRUNCATE TABLE emp_test;

--emp테이블에서 emp_test테이블로 복사한다.(7369-SMITH)

INSERT INTO emp_test
SELECT empno, ename, deptno, '010'
FROM emp
WHERE empno = 7369;

--데이터가 잘 입력 되었는지 확인;
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

COMMIT;

--emp테이블의 모든 직원을 emp_test테이블로 통합을 하자
--emp테이블에는 존재하지만 emp_test에는 존재하지 않으면 insert
--emp테이블에는 존재하고 emp_test에는 존재하면 ename, deptno를 update


--emp테이블에 존재하는 14건의 데이터중 emp_test에도 존재하는  7369 를 제외한 13건의 데이터가 
--emp_test 테이블에 신규로 입력이 되고
--emp_test에 존재하는 7369번의 데이터는 ename(brown)이 emp 테이블에 존재하는 이름인 SMITH로 갱신
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


--해당 테이블에 데이터가 있으면 insert, 없으면 update
--emp_test테이블에 사번이 9999번인 사람이 없으면 새롭게 insert
--있으면 update
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
--MERGE, window function(분석함수)

--report group funcion
--부서별 합계, 전체 합계를 다음과 같이 구하려면??(실습(group_ad1)
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
--소계와 전체합을 합쳤다.



--I/O
--CPU CASHE > RAM > SSD > HDD > NETWORK
--REPORT GROUP FUNCTION
--ROLLUP
--CUBE
--GROUPING;

--------------------------------------------------ppt
rollup - 그룹바이를 확장한것, 서브 그룹을 생성한다, 
기술방법 : group by rollup (컬럼1,컬럼2....)
subgroup을 자동적으로 생성
subgroup을 생성하는 규칙 : roll에 기술한 컬럼을 오른쪽에서 부터 하나씩 제거하면서 
                         sub group을 생성
ek : group by rollup (deptno)
==>
첫번쨰 sub group : group by deptno 
두번쨰 sub group : group by null ==> 전제행을 대상

group_ad1을 group by rollup절을 사용하여 작성;
select deptno,sum(sal)
from emp
group by rollup (deptno);

select job, deptno, 
       grouping(job),
       grouping (deptno)+sum(sal + nvl(comm,0)) sal
from emp                                            
group by rollup (job,deptno);

1.group by job, deptno : 담당업무 , 부서별 급여함
2.group by job : 담당업무 급여함
3.group by  : 전체 급여합 



--gorup_ad2 쿼리 작성 
select case grouping(job)
            when  1 then '총합'
       else job 
       end job, deptno, 
       grouping (deptno),sum(sal + nvl(comm,0)) sal
       
from emp
group by rollup (job,deptno);

--decode사용



--group_ad2-1 쿼리  : 2중 decode , case;
Dcode(인자 ,조건x,)
select 
    decode (grouping(job),1,'총',0,job) job,   
    decode (grouping(deptno),1, decode (grouping(job),1,'계',0,'소계')  ,0,decode(grouping(job),0,deptno,1,deptno)) deptno
   ,grouping (deptno),sum(sal + nvl(comm,0)) sal
    
from emp
group by rollup (job,deptno);




