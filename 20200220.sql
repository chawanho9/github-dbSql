select *
from no_emp;

select *
from no_emp
start with parent_org_cd is null
connect by prior org_cd=parent_org_cd;

1.leaf 노드가 어떤데이터인지 확인
select org_cd,level lv, connect_by_isleaf leaf
from no_emp
start with parent_org_cd is null
connect by prior org_cd=parent_org_cd;
2.level>>>상향탐색시 그룹을 묶기위해 필요한값




3.leaf 노드부터 상향 탐색, rownum;
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
        
3. leaf 노드부터 상향 탐색, rownum;         
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


gis_dt의 dt 컬럼에서 2020년 2월에 해당한느 날짜를 중복되지 않게 구한다 : 최대 29건의 행 
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
                
pl/sql 블록 구조 
declare : 변수, 상수 선언[생략가능]
begin : 로직 기술 [생략불가]
exception : 예외 처리 [생략가능 ]

pl/sql 연산자
중복된 연산자 제외 특이점
대입연산자가 일반적인 프로그래밍 언어와 다르다
java = 
pl/sql :=
;
pl/sql 변수선언
java : 타입 변수명 (string str ; )
pl/sql : 변수명 타입 (deptno number(2);)


pl/sql 코드 라인의 끝을 기술은 java와 동일하게 세미콜론을 기술한다
java : string str;
pl/sql : deptno number(2);

pl/sql 블룩의 죵료 표시하는 문자열 /
sql의 종료 문자열 : ;
;
hello world 출력 ;

set serveroutput on;
declare 
    msg varchar2(50);
begin 
    msg := 'hello, world!';
    dbms_output.put_line(msg);
end;
/
    
    
부서 테이블에서 10번 부서의 부서번호와 , 부서이름을 pl/sql 변수에 저장하고 
변수를 출력;


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

pl/sql 참조 타입 
부서 테이블의 컬럼 부서번호 , 부서명을 조회하여 변수에 담는과정;
부서번호, 부서명의 타입은 부서테이블에 정의가 되어있음

number, varchar2 타입을 직접 명시하는게 아니라 해당 테이블의 커럼의 타입을 참조하도록 
변수 타입을 선언 할 수있다.
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

프로시져 블록 유형 
익명 블럭 (이름이 없는 블럭)
. 재사용이 불가능하다 (in-line view vs view)

프로시져 (이름이 있는 블럭)
. 재사용 가능하다
.이름이 있다.
.프로시져를 실행 할 떄 함수처럼 인자를 받을 수 있다.

함수 (이름이 있는 블럭)
.재사용 가능하다
.이름이 있다
.프로시져와 다른점은 리턴 값이 있다;
    
프로시져 형태
--프로시져 형태
--CREATE OR REPLACE PROCEDURE 프로시져이름 IS (IN param, OUT param, IN out Param)
-- 선언부 (declare절이 별도로 없다)
--   BeGIN
--   EXCEPRINT(옵션)
--END;
--/

--부서 테이블에서 10번 부서의 부서번호와 부서이름을 PL/SQL 변수에 저장하고 
--DBMS_OUTPUT.PUT_LINE 함수를 이용하여 화면에 출력하는 printdept프로시져를 생성

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

프로시져 실행 방법
exec printdept_wano;

printdept_p 인자로 부서번호를 받아서 
해당 부서번호에 해당하는 부서이름과 지역정보를 콘솔에 출력하는 프로시져;
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

