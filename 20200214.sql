select decode ( grouping (job) || grouping(deptno), '11','총',
                                                    '00',job,
                                                    '01',job) job,
       decode ( grouping (job) || grouping(deptno), '11','계',
                                                    '00',deptno,
                                                    '01','소계') deptno
from emp
group by rollup (job,deptno);
                                                                                             
1
merge : select 하고 나서 데이터가 조회되면 update
        select 하고 나서 데이터가 조회되지 않으면 insert

select + update / select + insert == > merge ;


report group function
1.rollup
    - group by rollup (컬럼1, 컬럼2)
    - rollup 절에 기술한 컬럼을 오른쪽에서 하나씩 제거한 컬럼으로 subgroup생성
    
    - group by 컬럼1, 컬럼2
      union
      group by 컬럼1
      union
      group by 
2.cube
3. grouping sets ; 

--group_ad3

select deptno , job,sum(sal)
from emp
group by rollup (deptno,job);


SELECT dept.dname, emp.job, sum(sal)
FROM emp,dept
WHERE emp.deptno=dept.deptno
--GROUP BY (dept.dname, emp.job)
GROUP BY rollup(dept.dname, emp.job);

SELECT *
FROM emp;

SELECt *
FROM dept;
--group_ad4

select*
from emp;
select*
from dept;

select dept.dname, emp.job,sum(sal)
from emp join dept on (emp.deptno = dept.deptno)
group by rollup (dept.dname,emp.job);



select *
from emp
group by rollup deptno,ename;


--group_ad5
select decode (grouping(dept.dname),1,'총합',0,dept.dname),emp.job,sum(sal)
from emp join dept on (emp.deptno = dept.deptno)
group by rollup (dept.dname,emp.job);

select*
from emp join dept on (emp.deptno =dept.deptno)


report group function
1.rollup
2.cube
3.grouping sets
활용도
3,1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>cube;
--ppt
grouping sets 
순서와 관계없이 서브 그룹을 사용자가 직접 선언
사용방법 : group by grouping sets (col1,col2...)
==>
group by col1
union all 
group by col2
--ppt
group by grouping sets ( ( col1, col2))
group by grouping sets ( ( col2, col1))
sets의 경우  컬럼순서를 다르게 하더라도 구성 컬럼이 같으면 결과는 동일 ;
rollup은 컬럼 기술 순서가 결과에 

group by grouping sets ( ( col1, col2),col3,col4 )
==>
group by  col1, col2
union all
group by col3
union all
group by col4;
영향을 미친다.;

select job , deptno, sum(sal) sal
from emp
group by  CUBE(job, deptno);

group by grouping sets(job, deptno)
==>
group by job 
union all
group by deptno;

select job, sum(sal) sal
from emp
group by grouping sets(job,job);

job, deptno로 group by 한결과와
mgr로 group by 한 결과를 조회 하는 sql을 grouping sets로 작성;

select job,deptno,mgr,sum(sal)sal
from emp
group by grouping sets ((job,deptno), mgr);

--ppt
cube
가능한 모든 조합으로 컬럼을 조합한 sub group 을 생성한다.
단 기술한 컬럼의 순서는 지킨다.

ex : group by cube ( col1, col2);

(col1, col2) == > 
(null,col2) == group by (col2)
(null, null) == group by 전체
(col1, null) == group by col1
(col1,col2) == group by col1, col2;

--ppt
만약 컬럼3개를 cube 절에 기술한 경우 나올수 있는 가지수는 ??; 8;

select job, deptno ,mgr, sum(sal) sal
from emp
group by job,rollup(deptno), cube(mgr);

group by job, deptno, mgr == group by job, deptno ,mgr
group by job, deptno ==group by job, deptno 
group by job, null,mgr == group by job, mgr
group by job, null,null ==group by job

서브 쿼리 update ; 
1. emp_Test 테이블 drop
2. emp테이블을 이용해서 emp_Test 테이블 생성 (모든 행에 대해 ctas)
3. emp_test 테이블에 dname varchar2(14)컬럼 추가
4. emp_test.dname 컬럼을 dept 테이블을 이용해서 부서명을 업데이트;

drop table emp_Test;

create table emp_Test as 
select*
from emp;

alter table emp_Test add(dname varchar2(14));

select*
from emp_Test;

update emp_Test set dname = ( select dname
                              from dept
                              where dept.deptno = emp_Test.deptno
                            );
commit;

1.drop 
2.테이블 만들기 ;

drop table dept_Test;
create table dept_Test as
select*
from dept;

select*
from dept_Test;

alter table dept_Test add(empcnt number);

update  dept_Test  b set empcnt =nvl((select count(*)
                            from emp a
                            where a.deptno = b.deptno 
                            group by a.deptno),0);
                            

from dept_Test;
delete dept_Test
where deptno = 99;


--sub_a2
dept_Test테이블에 있는 부서중에 직원이 속하지 않는 부서 정보를 삭제
*dept_test.empcnt 컬럼은 사용하지 않고 
emp 테이블을 이용하여 삭제;
insert into dept_test values(99,'it1','daejeon',0);                            
insert into dept_test values(99,'it2','daejeon',0);
commit;

직원이 속하지 않는 부서 정보 조회?
직원이 있다 없다 ....?
10번 부서에 직원 이 있다 없다 ??
select count(*)
from emp
where deptno =10;

select*
from dept_test;

delete dept_test
where 0 = (select count (*)
            from emp
            where  deptno =dept_test.deptno);
            
--sub_a3
select*
from emp_Test;
drop table emp_Test;

create table emp_Test as select*
                         from emp;

--본인이 속한 부서의 평균 보다 급여가 작은 급여
select ename
from emp;
1. 부서의 평균;
select avg(sal)
from emp_Test
group by deptno;
2.부서평균보다 작은 급여;
select ename
from emp_Test a
where sal < (select avg(sal)
             from emp_Test b
             where a.deptno = b.deptno
             group by b.deptno);
3.부서평균보다 작은 급여를 현급여에서 +200  업데이트;
update emp_Test a set sal = select sal+200
                            from emp_test c
                            where a.ename = c.(select ename
                                                from emp_Test a
                                                where sal < (select avg(sal)
                                                             from emp_Test b
                                                             where a.deptno = b.deptno
                                                             group by b.deptno));
                                                             
--sem 
update emp_Test a set sal = sal + 200
where sal  < (select avg(sal)
                from emp_Test b 
                where a. deptno = b.deptno);

select*
from emp_test;
                
with 절 
하나의 쿼리에서 반복되는 subquery 가 있을 떄 
해당 subquery를 별도로 선언하여 재사용.

main쿼리가 실행될 떄 with 선언한 쿼리 블럭이 메모리에 임시적으로 저장 
==> main 쿼리가 종료 되면 메모리 해제 

subquery 작성시에는 해당 subquery의 결과를 조회하기 위해서 I/O 반복적으로 일어나지만
WHITH 절을 통해 선언하면 한번만 SUBQUERY가 실행되고 그 결과를 메모리에 저장해 놓고 재사용 
단, 하나의 쿼리에서 동일한 SUBQUERY가 반복적으로 나오는거는 잘못 작성한 SQL일 확류링 높음;

사용방법
WITH 쿼리블록이름 AS (
    서브쿼리
)
SELECT *
FROM 쿼리블록이름; 

직원의 부서별 급여 평균 ;
WITH sal_avg_dept AS(
                SELECT DEPTNO, ROUND(AVG(SAL),2) SAL
                FROM EMP
                GROUP BY DEPTNO
                ),
    dept_empcnt as(
    select deptno , count(*) empcnt
    from emp
    group by deptno)
    
SELECT*
FROM sal_avg_dept a, dept_empcnt b
where a.deptno = b.deptno;

with 절을 이욜한 테스트 테이블 작성;
with temp as ( 
    select sysdate -1 from dual UNION ALL
    select sysdate -1 from dual UNION ALL
    select sysdate -1 from dual )
SELECT*
FROM temp;

--다른사람과 소통할 때는 주로 with절을 이용해서 보여준다.
select *
from (
    select sysdate -1 from dual UNION ALL
    select sysdate -1 from dual UNION ALL
    select sysdate -1 from dual )

달력만들기;
connect by level < [=]정수
해당 테이블의 행을 정수 만큼 복제하고, 복제된 행을 구별하기 위해서 level을 부여 
level은 1부터 시작 ;

select dummy, level,level,level
from dual
connect by level <= 10;

select dept.*, level
from dept connect by level <=5;

select sysdate 
from dual
connect by level <= 5;

2020년 2월의 달력을 생성
:dt = 202002,202003;
달력
일  월  화  수  목  금  토
select to_date('202002','yyyymm')  + (level-1),
       to_char(to_date('202002','yyyymm')  + (level-1),'d'),
       decode (to_char(to_date('202002','yyyymm')  + (level-1),'d'),
                1,to_date('202002','yyyymm')  + (level-1)) s,
        decode (to_char(to_date('202002','yyyymm')  + (level-1),'d'),
                2,to_date('202002','yyyymm')  + (level-1)) m,                
        decode (to_char(to_date('202002','yyyymm')  + (level-1),'d'),
                3,to_date('202002','yyyymm')  + (level-1)) t,        
        decode (to_char(to_date('202002','yyyymm')  + (level-1),'d'),
                4,to_date('202002','yyyymm')  + (level-1)) w,
        decode (to_char(to_date('202002','yyyymm')  + (level-1),'d'),
                5,to_date('202002','yyyymm')  + (level-1)) t2,
        decode (to_char(to_date('202002','yyyymm')  + (level-1),'d'),
                6,to_date('202002','yyyymm')  + (level-1)) f,
        decode (to_char(to_date('202002','yyyymm')  + (level-1),'d'),
                7,to_date('202002','yyyymm')  + (level-1)) s2
from dual
connect by level <= to_char(last_day(to_Date ('202002','yyyymm')),'dd');

select to_char(last_day(to_Date ('202002','yyyymm')),'dd')
from dual;





