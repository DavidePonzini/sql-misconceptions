create table dept(
	deptno numeric(2) primary key,
	dname  varchar(20) not null,
	loc    varchar(20));

create table emp(
	empno  numeric(4) primary key,
	ename  varchar(20) not null,
	job    varchar(20) not null,
	sal    numeric(4) not null,
	comm   numeric(4) null,
	mgr    numeric(4) references emp,
	deptno numeric(2) not null references dept);

$e

select distinct empno, x.ename, 2, job hihi, dname, dept.loc, x.deptno
from   emp x, dept
where  job = 'manager';

select ename, deptno
from   emp
where  (empno = 2 or empno = 3) and (job = 'a' or job = 'b');

select distinct empno
from emp;

select distinct empno
from emp
where 1=2;

