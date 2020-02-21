����� �������� ( leaf ==> root node(���� node))
��ü ��带 �湮�ϴ°� �ƴ϶� �ڽ��� �θ��常 ��� ( ����İ� �ٸ��� )
������ : ��������
������ : �����μ�;

select dept_h.*,level, lpad(' ',(level-1) * 4) || deptnm   --���������� ���� 1 ���İ������� ���� up 
from dept_h
start with deptnm = '��������'
connect by prior p_deptcd = deptcd;    ���� �ڵ� = ���� �ڵ�;

--h_4 LPAD �̿��� ���� ǥ���ϱ� PPT
select lpad(' ',(level-1)*4) || s_id s_id,value
from h_sum
start with s_id = '0'
CONNECT BY PRIOR s_id = ps_id; 

--h_5
select *
from no_emp;

select LPAD(' ',(LEVEL-1)*4) || ORG_CD ORG_CD,NO_EMP
from no_emp
start with org_cd = 'XXȸ��'
connect by prior org_cd = parent_org_cd;

--PPT ( pruning branch ���� ġ�� )
WHERE ���� ��������ϴ� ���� CONNECT BY PRIOR �� ���� ��찡 �ٸ� 
from => start with, connect by => where
1. where : ���� ������ �ϰ� ���� ���� ����
2. connect by : ���� ������ �ϴ� �������� ���� ���� ;

where �� ����� : �� 9���� ���� ��ȸ�Ǵ� �� Ȯ�� 

where �� ( org_cd != '������ȹ��')              : ������ȹ�θ� ������ 8���� �� ��ȸ�Ǵ� �� Ȯ��;
select LPAD(' ',(LEVEL-1)*4) || ORG_CD ORG_CD,NO_EMP
from no_emp
where org_cd != '������ȹ��'
start with org_cd = 'XXȸ��'
connect by prior org_cd = parent_org_cd;  --���� ��ȹ�θ� ������ 

connect by ���� ������ ���;
select LPAD(' ',(LEVEL-1)*4) || ORG_CD ORG_CD,NO_EMP
from no_emp
start with org_cd = 'XXȸ��'
connect by prior org_cd = parent_org_cd and org_cd != '������ȹ��'; --������ȹ�����Ͽ� �ӿ��ִ� �༮�� ���� �ڰ�����


--PPT
connect_by_toor(�÷�) : �ش� �÷��� �ֻ��� ���� ���� ��ȯ;
sys_connect_by_path(�÷�, ������) : �ش� ���� �÷��� ���Ŀ��÷� ���� ��õ, �����ڷ� �̾��ش�;
connect_by_isleaf : �ش� ���� leaf �������(����� �ڽ��� ������) ���� ���� [1:leaf,0: no leaf] (������ ��忡 ���ؼ� 1�� ����);

select LPAD(' ',(LEVEL-1)*4) || ORG_CD ORG_CD,NO_EMP,
        connect_by_root(org_cd) root,
        ltrim(sys_connect_by_path(org_cd, '-'),'-') path ,--ltrim ���� ���� ���� ������ ����
        connect_by_isleaf leaf
from no_emp
start with org_cd = 'XXȸ��'
connect by prior org_cd = parent_org_cd ; --������ȹ�����Ͽ� �ӿ��ִ� �༮�� ���� �ڰ�����


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

order siblings by �������������ϸ鼭 ����;

�׷��ȣ�� ������ �÷��� �߰�;
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