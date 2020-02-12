drop table tb_grade;
CREATE TABLE tb_grade(
    g_cd VARCHAR2(20) not null,
    g_nm VARCHAR2(50) not null,
    ord NUMBER,
    CONSTRAINT PK_tb_grade primary key(g_cd)
);
drop table tb_dept;
CREATE TABLE tb_dept(
    d_cd VARCHAR2(20) not null ,
    d_nm VARcHAR2(50) not null,
    d_d_cd varchar2(20),
    CONSTRAINT PK_tb_dept PRIMARY KEY(d_cd)
);
drop table tb_job;
create table tb_job(
    j_cd varchar2(20) not null,
    j_nm varchar2(20) not null,
    ord number,
    constraint pk_tb_job primary key(j_cd)
);
drop table tb_cs_cd;
create table tb_cs_cd(
    cs_cd varchar(20) not null,
    cs_nm varchar(20) not null,
    p_cs_cd varchar2(20),
    constraint pk_tb_cs_cd primary key(cs_cd)
);    

--CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno)
drop table tb_emp;
create table tb_emp(
    e_no number  not null,
    e_nm varchar2(50) not null,
    g_cd varchar2(20) not null,
    j_cd varchar(20) not null,
    d_cd varchar(20) not null,
    constraint pk_tb_emp primary key (e_no),
    constraint fk_tb_emp_tb_grade foreign key (g_cd) REFERENCES tb_grade(g_cd),
    constraint fk_tb_emp_tb_job foreign key (j_cd) references tb_job(j_cd),
    constraint fk_tb_emp_tb_dept foreign key (d_cd) references tb_dept(d_cd)
);  

drop table tb_counsel;
create table tb_counsel(
    cs_id varchar(20) not null,
    cs_reg_dt date not null,
    cs_cont varchar2(4000) not null,
    e_no number not null,
    cs_cd varchar2(20) not null,
    cs_cd2 varchar2(20),
    cs_cd3 varchar2(20),
    constraint pk_tb_counsel primary key (cs_cd),
    constraint fk_tb_counsel_tb_cs_cd foreign key (cs_cd) references tb_cs_cd(cs_cd),
    constraint fk_tb_counsel_tb_cs_cd2 foreign key (cs_cd2) references tb_cs_cd(cs_cd),
    constraint fk_tb_counsel_tb_cs_cd3 foreign key (cs_cd3) references tb_cs_cd(cs_cd)
);
