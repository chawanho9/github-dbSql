set SERVEROUTPUT on;
create or replace procedure printemp_p_wano(p_empno in emp.empno%type) is
    v_ename emp.ename%type;
    v_deptno emp.deptno%type;
    begin
    select ename, deptno dname into v_ename, v_deptno
    from emp join dept
    on emp.deptno = dept.deptno
    where empno = p_empno;
    dbms_outfut.put_line(v_ename || ':'|| V_DEPTNO);
    end;
/

exec printemp_p_wano(7499);
select*
from emp;


set serveroutput on;
create or replace procedure registdept_Test (p_deptno in dept.deptno%type,p_dname in DEPT.DNAME%type,p_loc in DEPT.LOC%type) is
    
    begin
    insert into dept_test (deptno,dname,loc) values (p_deptno, p_dname, p_loc);
    end;
    /
    
--hae
create or replace procedure registdept_test(p_deptno in dept.deptno%type, p_dname in dept.dname%type, p_loc in dept.loc%type) is
begin
    insert into dept_test (deptno, dname, loc) values (p_deptno, p_dname, p_loc);
end;
/
exec registdept_test(99, 'ddit','daejeon')

--sem insert 쿼리
create or replace procedure registdept_test_wano (p_deptno in dept_test.deptno%type,
                                        p_dname in dept_test.dname%type,
                                        p_loc in dept_test.loc%type) is
begin
    insert into dept_test values(p_deptno,p_dname,p_loc,0);
end;
/
exec registdept_test_wano(96,'ddit','대전');

select*
from dept_test;

--por_3   updatet 쿼리
set serveroutput on;
create or replace procedure updatedept_test_wano (
                                        p_deptno in dept_test.deptno%type,
                                        p_dname in dept_test.dname%type,
                                        p_loc in dept_test.loc%type) is
begin
    update dept_test 
    set dname = p_dname, 
        loc =p_loc
     where deptno = p_deptno;   
end;
/
exec updatedept_test_wano(96,'ddit_m','daejeon');

select*
from dept_test;


복합변수 %rowtype :  특정 테이블의 행의 모든 컬럼을 저장할 수 있는 변수
사용방법 : 변수명 테이블명%rowtype
; -- 쭈르를륵 뽑기  
set serveroutput on;
Declare                         --선언문
    v_dept_row dept%rowtype;
begin                           --실행부
    select* into v_dept_row
    from dept
    where deptno =10;
    
    dbms_output.put_line(v_dept_row.deptno || ' ' || v_dept_row.dname || ' ' || v_dept_row.loc);
end;
/




