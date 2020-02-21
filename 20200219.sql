--�м��Լ�
SELECT ENAME, SAL, DEPTNO, row_number() over(partition by DEPTNO order by Sal DESC) rank
from emp;.--row_number �ϰ�� ������ �°� / rank �϶� ���� �����ϰ�� ��������

����¡ó�� (�������� 10���� �Խñ�)
1����¡ : 1~ 10
2����¡ : 11~20
���ε� ���� : page, :pageSize;;


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

--ppt �м��Լ� 
*���� ���� (=�׷����)

�м��Լ� ����
�м��Լ���([����]) over ( [partition by �÷�] [order by �÷�] [windowing] ) ;
partition by �÷� : �ش� �÷��� ���� row ���� �ϳ��� �׷����� ���´�.
order by �÷� : partition by �� ���� ���� �׷� ������ order by �÷����� ����;

row_number () over ( partition by deptno order by sal desc) rank;

--ppt���� ���� �м��Լ� 
rank () :���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ� ����ŭ ������ ������ ����
        2���� 2���̸� 3���� ���� 4����� �ļ����� �����ȴ�
dense_rank() : ���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ� ���� �������� ����
               2���� 2���̴��� �ļ����� 3����� ����
row_number() :rownum�� ����, �ߺ��� ���� ������� ����;

�μ���, �޿� ������ 3���� ��ŷ �����Լ��� ����
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

������ �м��Լ� (group �Լ����� �����ϴ� �Լ� ������ ����)
sum(�÷�)
count(*),count(�÷�), 
min(�÷�)
max(�÷�)
avg(�÷�)

no_ana2�� �м��Լ��� ����ؼ� �ۼ�
�μ��� ���� �� ;
select empno, ename, deptno,count(*) over(partition by deptno) cnt 
from emp;

--ana2
������ȣ, �����̸�, ���α޿�,�ҼӺμ�,�ҼӺμ��� �޿� ���( �Ҽ��� �Ѥ��ڸ�);
select empno,ename,sal,deptno,round (avg(sal) over (partition by deptno),2) avg_sal
from emp;

--ana3
select empno,ename,sal,deptno,round (max(sal) over (partition by deptno),2) max_sal
from emp;

�޿��� �������� �����ϰ�, �޿��� ���� ���� �Ի����ڰ� ��������� �����켱������ �ǵ��� �����Ͽ�
�������� ������(LEAD)�� SAL �÷��� ���ϴ� ���� �ۼ�;
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
rownum,��������;
--window�Լ����
select empno,ename,sal,sum(sal)over(order by sal,empno rows between unbounded preceding and current row)comm_sal
from emp;

--ppt first_value / last_value

�������� �������� �Ѿ� �պ��� ���� �ڱ��� �� 4������ sal�հ豸�ϱ�;
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

windwing �� range, rows��
range : ������ ���� ����, ���� ���� ������ �÷����� �ڽ��� ������ ���
rows : �������� ���� ����;


select empno, ename, deptno ,sal,
    sum(sal) over (partition by deptno order by sal rows unbounded preceding )row_,
    sum(sal) over (partition by deptno order by sal rows unbounded preceding )range_,
    sum(sal) over (partition by deptno order by sal  ) default_
from emp;