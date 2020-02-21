--분석함수
SELECT ENAME, SAL, DEPTNO, row_number() over(partition by DEPTNO order by Sal DESC) rank
from emp;.--row_number 일경우 순서에 맞게 / rank 일때 동일 점수일경우 공동순위

페이징처리 (페이지당 10건의 게시글)
1페이징 : 1~ 10
2페이징 : 11~20
바인드 변수 : page, :pageSize;;


select *
from
            (select a.*,rownum rn
            from
            (select seq,lpad(' ' , (level-1)*4) || title title, decode(parent_seq,null,seq,parent_seq)root
            from board_test
            start with parent_seq is null
            connect by prior seq=parent_seq
            order siblings by root desc,seq asc) a)
where rn between (:page -1)*:pageSize + 1 and :page * :pageSize;

--ppt 분석함수 
*영역 설정 (=그룹바이)

분석함수 문법
분석함수명([인자]) over ( [partition by 컬럼] [order by 컬럼] [windowing] ) ;
partition by 컬럼 : 해당 컬럼이 같은 row 끼리 하나의 그룹으로 묶는다.
order by 컬럼 : partition by 에 의해 묶은 그룹 내에서 order by 컬럼으로 정렬;

row_number () over ( partition by deptno order by sal desc) rank;

--ppt순위 관련 분석함수 
rank () :같은 값을 가질떄 중복 순위를 인정, 후순위는 중복 값많큼 떨어진 값부터 시작
        2등이 2명이면 3등은 없고 4등부터 후수위가 생성된다
dense_rank() : 같은 값을 가질떄 중복 순위를 인정, 후순위는 중복 순위 다음부터 시작
               2등이 2명이더라도 후순위는 3등부터 시작
row_number() :rownum과 유사, 중복된 값을 허용하지 않음;

부서별, 급여 순위를 3개의 랭킹 관련함수를 적용
select ename ,sal , deptno,
        rank() over(partition by deptno  order by sal) sal_rank,
        dense_rank () over(partition by deptno  order by sal) sal_dense_rank,
        row_number () over(partition by  deptno order by sal) sal_row_number
from emp;


--ana1
select ename ,sal , deptno,
        rank() over(order by sal desc) sal_rank,
        dense_rank () over(order by sal desc ) sal_dense_rank,
        row_number () over(order by sal desc) sal_row_number
from emp;

--no_ana2
select emp.empno,emp.ename,emp.deptno,a.cnt
from emp join
                (select deptno, count(*) cnt
                from emp
                group by deptno) a
         on
            a.deptno = emp.deptno
order by deptno;

통계관련 분석함수 (group 함수에서 제공하는 함수 종류와 동일)
sum(컬럼)
count(*),count(컬럼), 
min(컬럼)
max(컬럼)
avg(컬럼)

no_ana2를 분석함수를 사용해서 작성
부서별 직원 수 ;
select empno, ename, deptno,count(*) over(partition by deptno) cnt 
from emp;

--ana2
직원번호, 직원이름, 본인급여,소속부서,소속부서의 급여 평균( 소수점 둘쨰자리);
select empno,ename,sal,deptno,round (avg(sal) over (partition by deptno),2) avg_sal
from emp;

--ana3
select empno,ename,sal,deptno,round (max(sal) over (partition by deptno),2) max_sal
from emp;

급여를 내림차순 정렬하고, 급여가 같을 떄는 입사일자가 빠른사람이 높은우선수뉘가 되도록 정렬하여
현재행의 다음행(LEAD)의 SAL 컬럼을 구하는 쿼리 작성;
--ana4
SELECT empno, ename, hiredate, sal , lead(sal) over (order by sal desc, hiredate) lead_sal
from emp;

--ana5
SELECT empno, ename, hiredate, sal , lag(sal) over (order by sal desc, hiredate) lead_sal
from emp;

--ana6
SELECT empno, ename, hiredate, sal , lag(sal) over (partition by job order by sal desc, hiredate) lead_sal
from emp;

--no_ana3
rownum,범위조인;
--window함수사용
select empno,ename,sal,sum(sal)over(order by sal,empno rows between unbounded preceding and current row)comm_sal
from emp;

--ppt first_value / last_value

현재행을 기준으로 한앞 앞부터 한행 뒤까지 총 4개행의 sal합계구하기;
select empno, ename, sal,sum(sal) over (order by sal, empno rows between 1 preceding and 1 following) c_sum
from emp;

--ana7
range  unboundeing;
range between unbounded preceding and current row;
select empno,ename,deptno,sal, sum (sal) over (partition  by deptno order by deptno,sal  rows between unbounded preceding and current row) c_sum
from emp
order by deptno , sal;
--sem
select empno, ename, deptno ,sal,
    sum(sal) over (partition by deptno order by sal, empno) c_sum
from emp;    

windwing 의 range, rows비교
range : 논리적인 행의 단위, 같은 값을 가지는 컬럼까지 자신의 행으로 취급
rows : 물리적인 행의 단위;


select empno, ename, deptno ,sal,
    sum(sal) over (partition by deptno order by sal rows unbounded preceding )row_,
    sum(sal) over (partition by deptno order by sal rows unbounded preceding )range_,
    sum(sal) over (partition by deptno order by sal  ) default_
from emp;