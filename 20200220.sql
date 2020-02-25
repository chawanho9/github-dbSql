select *
from no_emp;

select *
from no_emp
start with parent_org_cd is null
connect by prior org_cd=parent_org_cd;

1.leaf ��尡 ����������� Ȯ��
select org_cd,level lv, connect_by_isleaf leaf
from no_emp
start with parent_org_cd is null
connect by prior org_cd=parent_org_cd;
2.level>>>����Ž���� �׷��� �������� �ʿ��Ѱ�




3.leaf ������ ���� Ž��, rownum;
select org_cd,parent_org_cd,no_emp,lv,rownum rn,lv+rownum gno
from
        (select no_emp.*,level lv, connect_by_isleaf leaf
        from no_emp
        start with parent_org_cd is null
        connect by prior org_cd=parent_org_cd)
start with leaf =1
connect by prior parent_org_cd=org_cd;





select org_cd,parent_org_cd,no_emp,
        sum(no_emp) over (partition by gno order by rn rows between unbounded preceding and current row) total

from
        (select org_cd,parent_org_cd,no_emp,rownum rn,lv,lv+rownum gno
        from
                (select no_emp.*,level lv, connect_by_isleaf leaf
                from no_emp
                start with parent_org_cd is null
                connect by prior org_cd=parent_org_cd)
        start with leaf =1
        connect by prior parent_org_cd=org_cd);
        
        
        
        
        
        
        
        
select org_cd,parent_org_cd,no_emp,
        sum(no_emp) over (partition by gno order by rn rows between unbounded preceding and current row) total

from
        (select org_cd,parent_org_cd,rownum rn,lv,lv+rownum gno,
           no_emp / count(*) over(partition by org_cd) no_emp
        from
                (select no_emp.*,level lv, connect_by_isleaf leaf
                from no_emp
                start with parent_org_cd is null
                connect by prior org_cd=parent_org_cd)
        start with leaf =1
        connect by prior parent_org_cd=org_cd);
        
3. leaf ������ ���� Ž��, rownum;         
select lpad(' ', (level - 1) * 4) || org_cd org_cd, total
from
    ((select org_cd, parent_org_cd, sum(total) total
    from
        (select org_cd, parent_org_cd, no_emp, sum(no_emp) over (partition by gno order by rn rows between unbounded preceding and current row) total
        from
            (select org_cd, parent_org_cd, lv, rownum rn, lv + rownum gno,
                   no_emp / count(*) over (partition by org_cd) no_emp
            from
                (select no_emp.*, level lv, CONNECT_BY_ISLEAF leaf
                from no_emp
                start with parent_org_cd is null
                connect by prior org_cd = parent_org_cd)
            Start with leaf = 1
            connect by prior parent_org_cd = org_cd))
    group by org_cd, parent_org_cd))
start with parent_org_cd is null
connect by prior org_cd = parent_org_cd;


gis_dt�� dt �÷����� 2020�� 2���� �ش��Ѵ� ��¥�� �ߺ����� �ʰ� ���Ѵ� : �ִ� 29���� �� 
2020/02/01
2020/02/02
2020/02/03
...
2020/02/29;
select to_char(dt,'yyyy-mm-dd')
from gis_dt
where dt between to_date('20200201','yyyymmdd') and to_date('20200229 23:59:59','yyyymmdd hh24:mi:ss')
group by to_char(dt,'yyyy-mm-dd');

create index idx_n_gis_dt_02 on gis_dt (dt);
desc gis_dt;

select *
from
(select to_date('20200201','yyyymmdd')+(level-1) dt
from dual
connect by level<=29)a
where exists  (select 'X'
                from gis_dt
                where gis_dt.dt between dt and to_date(to_char(dt,'yyyymmdd')|| '235959','yyyymmddhh24miss'));
                
pl/sql ��� ���� 
declare : ����, ��� ����[��������]
begin : ���� ��� [�����Ұ�]
exception : ���� ó�� [�������� ]

pl/sql ������
�ߺ��� ������ ���� Ư����
���Կ����ڰ� �Ϲ����� ���α׷��� ���� �ٸ���
java = 
pl/sql :=
;
pl/sql ��������
java : Ÿ�� ������ (string str ; )
pl/sql : ������ Ÿ�� (deptno number(2);)


pl/sql �ڵ� ������ ���� ����� java�� �����ϰ� �����ݷ��� ����Ѵ�
java : string str;
pl/sql : deptno number(2);

pl/sql ����� �շ� ǥ���ϴ� ���ڿ� /
sql�� ���� ���ڿ� : ;
;
hello world ��� ;

set serveroutput on;
declare 
    msg varchar2(50);
begin 
    msg := 'hello, world!';
    dbms_output.put_line(msg);
end;
/
    
    
�μ� ���̺��� 10�� �μ��� �μ���ȣ�� , �μ��̸��� pl/sql ������ �����ϰ� 
������ ���;


desc dept;

declare 
    v_deptno number(2);
    v_dname varchar2(14);
begin
    select deptno , dname into v_deptno, v_dname
    from dept
    where deptno = 10;
    
    dbms_output.put_line(v_deptno || ':' || v_dname);
end;
/

pl/sql ���� Ÿ�� 
�μ� ���̺��� �÷� �μ���ȣ , �μ����� ��ȸ�Ͽ� ������ ��°���;
�μ���ȣ, �μ����� Ÿ���� �μ����̺� ���ǰ� �Ǿ�����

number, varchar2 Ÿ���� ���� ����ϴ°� �ƴ϶� �ش� ���̺��� Ŀ���� Ÿ���� �����ϵ��� 
���� Ÿ���� ���� �� ���ִ�.
v_deptno number(2) ==> dept.deptno%type;
DECLARE
    v_deptno dept.deptno%type;
    v_dname dept.dname%type;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;

    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
END;
/

���ν��� ��� ���� 
�͸� �� (�̸��� ���� ��)
. ������ �Ұ����ϴ� (in-line view vs view)

���ν��� (�̸��� �ִ� ��)
. ���� �����ϴ�
.�̸��� �ִ�.
.���ν����� ���� �� �� �Լ�ó�� ���ڸ� ���� �� �ִ�.

�Լ� (�̸��� �ִ� ��)
.���� �����ϴ�
.�̸��� �ִ�
.���ν����� �ٸ����� ���� ���� �ִ�;
    
���ν��� ����
--���ν��� ����
--CREATE OR REPLACE PROCEDURE ���ν����̸� IS (IN param, OUT param, IN out Param)
-- ����� (declare���� ������ ����)
--   BeGIN
--   EXCEPRINT(�ɼ�)
--END;
--/

--�μ� ���̺��� 10�� �μ��� �μ���ȣ�� �μ��̸��� PL/SQL ������ �����ϰ� 
--DBMS_OUTPUT.PUT_LINE �Լ��� �̿��Ͽ� ȭ�鿡 ����ϴ� printdept���ν����� ����

CREATE OR REPLACE PROCEDURE printdept_wano IS
      v_deptno dept.deptno%type;
      v_dname dept.dname%type;
     v_loc dept.loc%type;
      BEGIN
         SELECT deptno, dname, loc INTO v_deptno, v_dname , v_loc
         FROM dept
         WHERE deptno = 10;
         DbmS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname|| ' : ' || v_loc);
      END;
   /

���ν��� ���� ���
exec printdept_wano;

printdept_p ���ڷ� �μ���ȣ�� �޾Ƽ� 
�ش� �μ���ȣ�� �ش��ϴ� �μ��̸��� ���������� �ֿܼ� ����ϴ� ���ν���;
create or replace procedure printdept_p_wano(p_deptno in dept.deptno%type) is
    v_dname dept.dname%type;
    v_loc dept.loc%type;
begin
    select dname,loc into v_dname,v_loc
    from dept
    where deptno=p_deptno;
    DBMS_OUTPUT.PUT_LINE(v_dname ||','||v_loc);
end;
/
exec printdept_p_wano(10);

create or replace procedure wano(p_deptno in DEPT.DEPTNO%type) is
    v_dname dept.dname%type;
    v_loc dept.loc%type;
begin
    select dname, loc into v_dname, v_loc
    from dept 
    where deptno = p_deptno;
    dbms_output.put_line(v_dname || '   ' || v_loc);
    end;
/
exec wano(10);

