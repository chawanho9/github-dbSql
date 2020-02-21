상향식 계층쿼리 ( leaf ==> root node(상위 node))
전체 노드를 방문하는게 아니라 자신의 부모노드만 방굼 ( 하향식과 다른점 )
시작점 : 디자인팀
연결은 : 상위부서;

select dept_h.*,level, lpad(' ',(level-1) * 4) || deptnm   --디자인팀이 레벨 1 거쳐갈떄마다 레벨 up 
from dept_h
start with deptnm = '디자인팀'
connect by prior p_deptcd = deptcd;    상위 코드 = 하위 코드;

--h_4 LPAD 이용해 계층 표시하기 PPT
select lpad(' ',(level-1)*4) || s_id s_id,value
from h_sum
start with s_id = '0'
CONNECT BY PRIOR s_id = ps_id; 

--h_5
select *
from no_emp;

select LPAD(' ',(LEVEL-1)*4) || ORG_CD ORG_CD,NO_EMP
from no_emp
start with org_cd = 'XX회사'
connect by prior org_cd = parent_org_cd;

--PPT ( pruning branch 가지 치기 )
WHERE 절을 만들어사용하는 경우와 CONNECT BY PRIOR 에 쓰는 경우가 다름 
from => start with, connect by => where
1. where : 계층 연결을 하고 나서 행을 제한
2. connect by : 계층 연결을 하는 과정에서 행을 제한 ;

where 절 기술전 : 총 9개의 행이 조회되는 것 확인 

where 절 ( org_cd != '정보기획부')              : 정보기획부를 제외한 8개의 행 조회되는 것 확인;
select LPAD(' ',(LEVEL-1)*4) || ORG_CD ORG_CD,NO_EMP
from no_emp
where org_cd != '정보기획부'
start with org_cd = 'XX회사'
connect by prior org_cd = parent_org_cd;  --정보 기획부만 없어짐 

connect by 절에 조건을 기술;
select LPAD(' ',(LEVEL-1)*4) || ORG_CD ORG_CD,NO_EMP
from no_emp
start with org_cd = 'XX회사'
connect by prior org_cd = parent_org_cd and org_cd != '정보기획부'; --정보기획부이하에 속에있는 녀석들 한테 자객보냄


--PPT
connect_by_toor(컬럼) : 해당 컬럼의 최상위 행의 값을 반환;
sys_connect_by_path(컬럼, 구분자) : 해당 행의 컬럼이 거쳐온컬럼 값을 추천, 구분자로 이어준다;
connect_by_isleaf : 해당 행이 leaf 노드인지(연결된 자식이 없는지) 값을 리턴 [1:leaf,0: no leaf] (최하위 노드에 대해서 1로 리턴);

select LPAD(' ',(LEVEL-1)*4) || ORG_CD ORG_CD,NO_EMP,
        connect_by_root(org_cd) root,
        ltrim(sys_connect_by_path(org_cd, '-'),'-') path ,--ltrim 으로 제일 왼쪽 구분자 삭제
        connect_by_isleaf leaf
from no_emp
start with org_cd = 'XX회사'
connect by prior org_cd = parent_org_cd ; --정보기획부이하에 속에있는 녀석들 한테 자객보냄


?
select *
from board_test;
select lpad(' ',(level-1)*4) || title
from board_test
start with seq = 1 
connect by prior seq=parent_seq

union all

select lpad(' ',(level-1)*4) || title
from board_test
start with seq = 2 
connect by prior seq=parent_seq

union all 

select lpad(' ',(level-1)*4) || title
from board_test
start with seq = 3
connect by prior seq=parent_seq

union all

select lpad(' ',(level-1)*4) || title
from board_test
start with seq = 4
connect by prior seq=parent_seq;


select  board_test.*
from board_test
start with seq in(1,2,4)
connect by prior seq=parent_seq
order siblings by seq desc ;

order siblings by 계층순서유지하면서 정렬;

그룹번호를 저장할 컬럼을 추가;
alter table board_test add( gn number);

update board_Test set gn = 4
where seq in (4,5,6,7,8,10,11);

update board_Test set gn = 2
where seq in (2,31);

update board_Test set gn = 1
where seq in (1,9);

commit;

select gn,seq, lpad(' ',(level-1)*4) || title title
from board_Test
start with parent_seq is null
connect by prior seq = parent_seq
order siblings by gn desc , seq asc;

select seq, lpad(' ',(level-1)*4) || title title, decode(parent_seq, null, seq, parent_seq) root
from board_Test
start with parent_seq is null
connect by prior seq = parent_seq
order siblings by root desc , seq asc;

select *
from emp order by deptno desc, empno asc;

--ana0
select ename,sal,deptno,rownum
from emp
where deptno =10

union all

select ename,sal,deptno,rownum
from emp
where deptno =20

union all

select ename,sal,deptno,rownum
from emp
where deptno =30;


select ename , sal ,deptno,rownum
from emp
group by ename, sal, deptno
order by deptno;


select *
from
(select level lv
from dual 
connect by level <= 14) a,

(select deptno, count(*) cnt
from emp
group by deptno) b
where b.cnt >= a.lv
order by b.deptno , a.lv;