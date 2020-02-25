select *
from cycle;
1�� ���� 100�� ��ǰ�� �����ϳ� 1�� ����
2020�� 2���� ���� �Ͻ����� ����
1.2020�� 2���� �����Ͽ� ���� �Ͻ��� ����
1    200  2   1  ������ ���� 4���� ������ ���� �Ǿ�� �Ѵ�

1   100   2   1 ������ ���� 4���� ������ �����Ǿ�� �Ѵ�
1   100   20200203   1
1   100   20200210   1
1   100   20200217   1
1   100   20200224   1
--

select '202002'
from dual
connect by level <= 29 ;

select to_date('202002'||'01','yyyymmdd')
from dual
connect by level <= 29 ;


select to_date('202002'||'01','yyyymmdd') + (level-1)
from dual
connect by level <= to_char(last_day(to_date('202002'||'01','yyyymmdd')),'dd');


select to_char('202002'||'01','yyyymmdd') + (level-1) dt,
       to_char('202002'||'01','yyyymmdd') + (level-1), 'D')d
from dual
connect by level <= to_char(last_day(to_date('202002'||'01','yyyymmdd')),'dd');


--pro_4 1/2
create or replace procedure create_daily_sales(p_yyyymm in daily.dt%type) is
    TYPE cal_row IS RECORD(
        dt varchar2(8),
        d NUMBER);
    TYPE cal_tab IS TABLE OF cal_row INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
begin
    select to_char(to_date(p_yyyymm ||'01','yyyymmdd') + (level-1), 'yyyymmdd') dt,
           to_char(to_date ( p_yyyymm ||'01','yyyymmdd') + (level-1), 'D')d
           bulk collect into v_cal_tab
    from dual       
    connect by level <= to_char(last_day(to_date(p_yyyymm||'01','yyyymmdd')),'dd');
    
--    �Ͻ��� �����͸� �����ϱ� ���� ������ ������ �����͸� ����
    delete dily
    where dt like p_yyyymm
    --���� �ֱ� ������ ��ȸ (for -cursor)
    FOR daily_row IN (SELECT * FROM cycle) LOOP
        DBMS_OUTPUT.PUT_LINE(daily_row.cid || ' ' ||daily_row.pid || ' ' || daily_row.day || ' ' || daily_row.cnt);
        for i in 1..v_cal_tab.count loop
        
--            outer loopt(�ָ��ֱ�)���� ���� ���� �̶� innerloop(�޷�)dptj dlfrdms dydlfdl rkxdms epdlxjfmf cpzm
            if daily_row.day = v_cal_tab(i).d then
            insert into daily values (daily_row.cid, daily_row.pid, v_cal_tab(i).dt, daily_row.cnt);
            dbms_output.put_line(v_cal_tab(i).dt || ' ' || v_cal_tab(i).d);
            end if;
        end loop;     
    END LOOP;   
end;
/
set serveroutput on;
exec create_daily_sales('202002')

select *
from daily
where dt like '202002%';

delect daily
where dt like'202002%';

creata_daily_sales ���ν������� �Ǻ��� insert �ϴ� ������ INSERT SELECT ����, ONE-QUERY ���·� �����Ͽ� �ӵ��� ����;
--Create_daily_sales ���ν������� �Ǻ��� insert �ϴ� ������ INSERT SELECT ����, ONE_QUERY���·�
--���� �Ͽ� �ӵ��� ����;

DELETE daily
WHERE dt LIKE '202002%';


SELECT cycle.cid,cycle.pid,cal.dt,cycle.cnt
FROM cycle,
   (SELECT TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1),'YYYYMMDD')dt,
         TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1),'D')d
   FROM dual
   CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD'))cal
WHERE cycle.day = cal.d;



--PL/SQL ������ SELECT ����� ��� ���� : NO_DATA_FOUND;

DECLARE
   v_dname dept.dname%TYPE;
BEGIN
   SELECT dname INTO v_dname
   FROM dept
--   WHERE deptno = 70;
exception 
    where no_data_found then
        dbms_output.put_line('NO_DATA_FOUND');
    WHEN too_many_rouw then    
        dbms_output.put_line('TOO_MANY_ROWS');
END;
/

����� ���� ���� ����
NO_DATA_FOUND ==> �츮�� �������� ����� ���ܷ� �����Ͽ� ���Ӱ� ���ܸ� ������ ����;

DECLARE 
    no_emp EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN
    BEGIN
        SELECT ename INTO V_ENAME
        from EMP
        where EMPNO = 8000;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE no_emp;
    END;
EXCEPTION
    WHEN no_emp Then
        DBMS_OUTPUT.PUT_LINE('no_emp');
END;
/


pl/sql(funciont) --�ݵ�� ���� Ÿ���� ����

emp���̺��� ���ؼ��� �μ��̸��� �˼��� ���� ( �μ��̸� dept ���̺� ����)
==> 1.join
    2. ��������-��Į�� ��������(select)
    
select *
from emp,dept
where emp.deptno = dept.deptno;

SELECT emp.*, (SELECT dname FROM dept WHERE dept.deptno = emp.deptno ) dname
FROM emp

�μ���ȣ�� ���ڹް� �μ����� �������ִ� �Լ� ����;
detDeptName;

CREATE OR REPLACE FUNCTION getDeptName(p_deptno dept.deptno%TYPE) RETURN VARCHAR2 IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    return v_dname;
END;
/

select emp.*, getDeptName(emp.deptno) dname
FROM emp;

getEmpName �Լ��� ����
������ȣ�� ���ڷ� �ϰ� 
�ش� ������ �̸��� �������ִ� �Լ��� �����غ�����.

smith;
select *
from emp;

CREATE OR REPLACE FUNCTION getEmpName(p_empno emp.empno%TYPE) RETURN VARCHAR2 IS
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    return v_ename;
END;
/    
select emp.*, getDeptName(emp.empno) dname
FROM emp;

--semcreate or replace function getpadding(p_lv number,p_indent number,p_padding varchar2) return varchar2 is
    v_padding varchar(200);
begin
    select lpad(' ' , (p_lv-1)*p_indent,p_padding)into v_padding
    from dual;
    
    return v_padding;
end;
/

select '*' || lpad(' ',(:lv-1)*4) ||'*'
from dual;

select getPadding(level,10,'-')||deptnm
from dept_h
start with deptcd='dept0'
connect by prior deptcd=p_deptcd;


select*
from table(dbms_xplan.display)

--PACKAGE��
--PACKAGE - ������ PL/SQL ����� �����ִ� ����Ŭ ��ü
--�����
--��ü(������)�� ����
--getempname, getdeptname => names ��Ű���� ��ƺ���;

SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE names AS
   FUNCTION getEmpname(p_empno emp.empno%TYPE) RETURN VARCHAR2;
   FUNCTION getdeptname(p_deptno dept.deptno%TYPE) RETURN VARCHAR2;
end names;
/

--��Ű�� �ٵ�
CREATE or replace package body names as
   FUNCTION getDeptName(p_deptno dept.deptno%TYPE) RETURN VARCHAR2 AS
   v_dname dept.dname%TYPE;
BEGIN
   SELECT dname INTO v_dname
   FROM dept
   WHERE deptno = p_deptno;
   RETURN v_dname;
   END;
   
   FUNCTION getempName(p_empno emp.empno%TYPE) RETURN VARCHAR2 AS
   v_ename emp.ename%TYPE;
   
   BEGIN
      SELECT ename INTO v_ename
      FROM emp
      WHERE empno = p_empno;
      RETURN v_ename;
   END;
END;
/

SELECT emp.*, names.getdeptname(emp.deptno)dname
FROM emp;

--���� ��Ű�� �׽�Ʈ
SELECT names.getempname(empno),
names.getdeptname(deptno)
FROM emp;
