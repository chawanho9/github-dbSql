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

--sem insert ����
create or replace procedure registdept_test_wano (p_deptno in dept_test.deptno%type,
                                        p_dname in dept_test.dname%type,
                                        p_loc in dept_test.loc%type) is
begin
    insert into dept_test values(p_deptno,p_dname,p_loc,0);
end;
/
exec registdept_test_wano(96,'ddit','����');

select*
from dept_test;

--por_3   updatet ����
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


���պ��� %rowtype :  Ư�� ���̺��� ���� ��� �÷��� ������ �� �ִ� ����
����� : ������ ���̺��%rowtype
; -- �޸����� �̱�  
set serveroutput on;
Declare                         --����
    v_dept_row dept%rowtype;
begin                           --�����
    select* into v_dept_row
    from dept
    where deptno =10;
    
    dbms_output.put_line(v_dept_row.deptno || ' ' || v_dept_row.dname || ' ' || v_dept_row.loc);
end;
/

���պ��� record --PPT
�����ڰ� ���� �������� �÷��� ������ �� �ִ� Ÿ���� �����ϴ� ���
JAVA�� �����ϸ� Ŭ������ �����ϴ� ����
�ν��Ͻ��� ����� ������ ��������

����
TYPE Ÿ���̸�(�����ڰ� ����) IS  RECORD(
     ������1 ����Ÿ��,
     ������2 ����Ÿ��,
);

������ Ÿ���̸�;

DECLARE 
    TYPE dept_row IS RECORD(
        deptno NUMBER(2),
        dname Varchar2(14)
    );
    
    v_dept_row dept_row;
BEGIN 
    SELECT deptno, dname INTO v_dept_row
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE( v_dept_row.deptno || ' ' || v_dept_row.dname);
END;
/

declare
    type dept_row is record(
        deptno NUMBER(2),
        dname VARCHAR(14)
    );
    
    v_dept_row dept_row;
begin
    select deptno, dname into v_dept_row
    from dept
    where deptno = 10;
    
    DBMS_OUTPUT.put_line(v_dept_row.deptno || ' ' || v_dept_row.dname);
    
end;
/

table type ���̺� Ÿ�� 
�� : ��Į�� ���� 
�� : %rowtype, record type
�� : table type
    � ��(%rowtype, record type)�� ������ ���ִ��� �ε��� Ÿ���� ��������;

dept ���̺��� ������ ������ �ִ� table type�� ����
������ ��� ��Į�� Ÿ��, rowtype������ �� ���� ������ ���� �� �־�����
table Ÿ�� ������ �̿��ϸ� ���� ���� ������ ���� ���ִ�

pl/sql ������ �ڹٿ� �ٸ��� �迭�� ���� �ε����� ������ �����Ǿ� ���� �ʰ� 
���ڿ��� �����ϴ�

�׷��� table Ÿ���� ������ ���� �ε����� ���� Ÿ�Ե� ���� ���
binary_integer Ÿ���� pl/sql������ ��� ������ Ÿ������ 
number Ÿ���� �̿��Ͽ� ������ ��� �����ϰ� ���� number Ÿ���� ���� Ÿ���̴�;


declare 
    type dept_tab is table of dept%rowtype index by binary_integer;
    v_dept_tab dept_tab;
begin
    select * bulk collect into v_dept_tab
    from dept;
    --���� ��Į�󺯼�, record Ÿ���� �ǽ��ÿ��� 
    --�� �ุ ��ȸ �ǵ��� where ���� ���� �����Ͽ���
    
   --�ڹٿ����� �迭[�ε��� ��ȣ]
   --table����(�ε��� ��ȣ) �� ����
--   for( int i=0; i <10; i++){
--   }
   
   for i in 1..v_dept_tab.count loop
    dbms_output.put_line(v_dept_tab(i).deptno || ' ' || v_dept_tab(i).dname);
   end loop;
end;
/

�������� if
����

if ���ǹ� then 
    ���๮;
elsif ���ǹ� then
    ���๮;
else    
    ���๮;
end if;

declare
    p number(1) := 2; -- ���� ����� ���ÿ� ���� ���� 
begin
    if p = 1 then 
        dbms_output.put_line('1�Դϴ�');
    elsif p = 2 then    
        dbms_output.put_line('2�Դϴ�');
    else
        dbms_output.put_line('�˷����� �ʾҽ��ϴ�');
    end if;
end;
/

case ���� 
1.�Ϲ� ���̽� (java�� swithch�� ����)
2.�˻� ���̽� (if, else if, else);

case ecpression
    when value THEN
        ���๮;
    when value THEN
        ���๮;
    ELSE
        ���๮;
END CASE; 

DECLARE 
    p NUMBER(1) :=2;
BEGIN
    CASE p
        when 1 then 
            dbms_output.put_line('1�Դϴ�');
        when 2 then 
            dbms_output.put_line('2�Դϴ�');
        else
            dbms_output.put_line('�𸣴� ���Դϴ�');
    end case;
end;
/


for loop ����
for ��������/�ε������� in [reverse] ���۰�..���ᰪ loop
    �ݺ��� ����;
end loop;

1���� 5���� ���� ��� 

declare
begin
      for i in 1..5 loop
        dbms_output.put_line(i);
     end loop;
end;
/

�ǽ� : 2~9�� ������ �������� ���;

declare
begin 
    for i in 2..9 loop
        for j in 1..9 loop
        dbms_output.put_line(i||'*'||j||'='||i*j);
        end loop;
    end loop;    
end;
/

while loop ����
while ���� loop
    �ݺ������� ����;
end loop;

declare
    i number := 0;
begin
    while i <= 5 loop
        dbms_output.put_line(i);
        i := i+1;
    end loop;
end;
/

loop�� ����
loop
    �ݺ������� ����;
end loop;    

declare
    i number := 0;
begin
    loop
        dbms_output.put_line(i);
        exit when i >5;
        i := i +1;
    end loop;
end;
/