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

복합변수 record --PPT
개발자가 직접 여러개의 컬럼을 관리할 수 있는 타입을 생성하는 명령
JAVA를 비유하면 클래스를 선언하는 과정
인스턴스를 만드는 과정은 변수선언

문법
TYPE 타입이름(개발자가 지정) IS  RECORD(
     변수명1 변수타입,
     변수명2 변수타입,
);

변수명 타입이름;

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

table type 테이블 타입 
점 : 스칼라 변수 
선 : %rowtype, record type
면 : table type
    어떤 선(%rowtype, record type)을 저장할 수있는지 인덱스 타입은 무엇인지;

dept 테이블의 정보를 담을수 있는 table type을 선언
기존에 배운 스칼라 타입, rowtype에서는 한 행의 정보를 담을 수 있었지만
table 타입 변수를 이용하면 여러 행의 정보를 담을 수있다

pl/sql 에서는 자바와 다르게 배열에 대한 인덱스가 정수로 고정되어 있지 않고 
문자열도 가능하다

그래서 table 타입을 선언할 때는 인덱스에 대한 타입도 같이 명시
binary_integer 타입은 pl/sql에서만 사용 가능한 타입으로 
number 타입을 이용하여 정수만 사용 가능하게 끔한 number 타입의 서브 타입이다;


declare 
    type dept_tab is table of dept%rowtype index by binary_integer;
    v_dept_tab dept_tab;
begin
    select * bulk collect into v_dept_tab
    from dept;
    --기존 스칼라변수, record 타입을 실습시에는 
    --한 행만 조회 되도록 where 절을 통해 제한하였다
    
   --자바에서는 배열[인덱스 번호]
   --table변수(인덱스 번호) 로 접근
--   for( int i=0; i <10; i++){
--   }
   
   for i in 1..v_dept_tab.count loop
    dbms_output.put_line(v_dept_tab(i).deptno || ' ' || v_dept_tab(i).dname);
   end loop;
end;
/

조건제어 if
문법

if 조건문 then 
    실행문;
elsif 조건문 then
    실행문;
else    
    실행문;
end if;

declare
    p number(1) := 2; -- 변수 선언과 동시에 값을 대입 
begin
    if p = 1 then 
        dbms_output.put_line('1입니다');
    elsif p = 2 then    
        dbms_output.put_line('2입니다');
    else
        dbms_output.put_line('알려지지 않았습니다');
    end if;
end;
/

case 구문 
1.일반 케이스 (java의 swithch와 유사)
2.검색 케이스 (if, else if, else);

case ecpression
    when value THEN
        실행문;
    when value THEN
        실행문;
    ELSE
        실행문;
END CASE; 

DECLARE 
    p NUMBER(1) :=2;
BEGIN
    CASE p
        when 1 then 
            dbms_output.put_line('1입니다');
        when 2 then 
            dbms_output.put_line('2입니다');
        else
            dbms_output.put_line('모르는 값입니다');
    end case;
end;
/


for loop 문법
for 루프변수/인덱스변수 in [reverse] 시작값..종료값 loop
    반복할 로직;
end loop;

1부터 5까지 숫자 출력 

declare
begin
      for i in 1..5 loop
        dbms_output.put_line(i);
     end loop;
end;
/

실습 : 2~9단 까지의 구구단을 출력;

declare
begin 
    for i in 2..9 loop
        for j in 1..9 loop
        dbms_output.put_line(i||'*'||j||'='||i*j);
        end loop;
    end loop;    
end;
/

while loop 문법
while 조건 loop
    반복실행할 로직;
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

loop문 문법
loop
    반복실행할 문자;
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