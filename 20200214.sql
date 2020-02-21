select decode ( grouping (job) || grouping(deptno), '11','��',
                                                    '00',job,
                                                    '01',job) job,
       decode ( grouping (job) || grouping(deptno), '11','��',
                                                    '00',deptno,
                                                    '01','�Ұ�') deptno
from emp
group by rollup (job,deptno);
                                                                                             
1
merge : select �ϰ� ���� �����Ͱ� ��ȸ�Ǹ� update
        select �ϰ� ���� �����Ͱ� ��ȸ���� ������ insert

select + update / select + insert == > merge ;


report group function
1.rollup
    - group by rollup (�÷�1, �÷�2)
    - rollup ���� ����� �÷��� �����ʿ��� �ϳ��� ������ �÷����� subgroup����
    
    - group by �÷�1, �÷�2
      union
      group by �÷�1
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
select decode (grouping(dept.dname),1,'����',0,dept.dname),emp.job,sum(sal)
from emp join dept on (emp.deptno = dept.deptno)
group by rollup (dept.dname,emp.job);

select*
from emp join dept on (emp.deptno =dept.deptno)


report group function
1.rollup
2.cube
3.grouping sets
Ȱ�뵵
3,1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>cube;
--ppt
grouping sets 
������ ������� ���� �׷��� ����ڰ� ���� ����
����� : group by grouping sets (col1,col2...)
==>
group by col1
union all 
group by col2
--ppt
group by grouping sets ( ( col1, col2))
group by grouping sets ( ( col2, col1))
sets�� ���  �÷������� �ٸ��� �ϴ��� ���� �÷��� ������ ����� ���� ;
rollup�� �÷� ��� ������ ����� 

group by grouping sets ( ( col1, col2),col3,col4 )
==>
group by  col1, col2
union all
group by col3
union all
group by col4;
������ ��ģ��.;

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

job, deptno�� group by �Ѱ����
mgr�� group by �� ����� ��ȸ �ϴ� sql�� grouping sets�� �ۼ�;

select job,deptno,mgr,sum(sal)sal
from emp
group by grouping sets ((job,deptno), mgr);

--ppt
cube
������ ��� �������� �÷��� ������ sub group �� �����Ѵ�.
�� ����� �÷��� ������ ��Ų��.

ex : group by cube ( col1, col2);

(col1, col2) == > 
(null,col2) == group by (col2)
(null, null) == group by ��ü
(col1, null) == group by col1
(col1,col2) == group by col1, col2;

--ppt
���� �÷�3���� cube ���� ����� ��� ���ü� �ִ� �������� ??; 8;

select job, deptno ,mgr, sum(sal) sal
from emp
group by job,rollup(deptno), cube(mgr);

group by job, deptno, mgr == group by job, deptno ,mgr
group by job, deptno ==group by job, deptno 
group by job, null,mgr == group by job, mgr
group by job, null,null ==group by job

���� ���� update ; 
1. emp_Test ���̺� drop
2. emp���̺��� �̿��ؼ� emp_Test ���̺� ���� (��� �࿡ ���� ctas)
3. emp_test ���̺� dname varchar2(14)�÷� �߰�
4. emp_test.dname �÷��� dept ���̺��� �̿��ؼ� �μ����� ������Ʈ;

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
2.���̺� ����� ;

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
dept_Test���̺� �ִ� �μ��߿� ������ ������ �ʴ� �μ� ������ ����
*dept_test.empcnt �÷��� ������� �ʰ� 
emp ���̺��� �̿��Ͽ� ����;
insert into dept_test values(99,'it1','daejeon',0);                            
insert into dept_test values(99,'it2','daejeon',0);
commit;

������ ������ �ʴ� �μ� ���� ��ȸ?
������ �ִ� ���� ....?
10�� �μ��� ���� �� �ִ� ���� ??
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

--������ ���� �μ��� ��� ���� �޿��� ���� �޿�
select ename
from emp;
1. �μ��� ���;
select avg(sal)
from emp_Test
group by deptno;
2.�μ���պ��� ���� �޿�;
select ename
from emp_Test a
where sal < (select avg(sal)
             from emp_Test b
             where a.deptno = b.deptno
             group by b.deptno);
3.�μ���պ��� ���� �޿��� ���޿����� +200  ������Ʈ;
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
                
with �� 
�ϳ��� �������� �ݺ��Ǵ� subquery �� ���� �� 
�ش� subquery�� ������ �����Ͽ� ����.

main������ ����� �� with ������ ���� ���� �޸𸮿� �ӽ������� ���� 
==> main ������ ���� �Ǹ� �޸� ���� 

subquery �ۼ��ÿ��� �ش� subquery�� ����� ��ȸ�ϱ� ���ؼ� I/O �ݺ������� �Ͼ����
WHITH ���� ���� �����ϸ� �ѹ��� SUBQUERY�� ����ǰ� �� ����� �޸𸮿� ������ ���� ���� 
��, �ϳ��� �������� ������ SUBQUERY�� �ݺ������� �����°Ŵ� �߸� �ۼ��� SQL�� Ȯ���� ����;

�����
WITH ��������̸� AS (
    ��������
)
SELECT *
FROM ��������̸�; 

������ �μ��� �޿� ��� ;
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

with ���� �̿��� �׽�Ʈ ���̺� �ۼ�;
with temp as ( 
    select sysdate -1 from dual UNION ALL
    select sysdate -1 from dual UNION ALL
    select sysdate -1 from dual )
SELECT*
FROM temp;

--�ٸ������ ������ ���� �ַ� with���� �̿��ؼ� �����ش�.
select *
from (
    select sysdate -1 from dual UNION ALL
    select sysdate -1 from dual UNION ALL
    select sysdate -1 from dual )

�޷¸����;
connect by level < [=]����
�ش� ���̺��� ���� ���� ��ŭ �����ϰ�, ������ ���� �����ϱ� ���ؼ� level�� �ο� 
level�� 1���� ���� ;

select dummy, level,level,level
from dual
connect by level <= 10;

select dept.*, level
from dept connect by level <=5;

select sysdate 
from dual
connect by level <= 5;

2020�� 2���� �޷��� ����
:dt = 202002,202003;
�޷�
��  ��  ȭ  ��  ��  ��  ��
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





