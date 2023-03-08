-- 04-2 두 테이블을 묶는 조인
use marketdb;

-- Inner Join
select * from buy
	inner join member on buy.mem_id = member.mem_id
	where buy.mem_id="GRL";
select * from buy
	inner join member on buy.mem_id = member.mem_id;

-- 동일한 열이름 가지고 있을 경우 테이블 지정
select buy.mem_id, mem_name, prod_name, addr, concat(phone1, phone2) "연락처" from buy 
	inner join member on buy.mem_id = member.mem_id;
select b.mem_id, m.mem_name, b.prod_name, m.addr, concat(m.phone1, m.phone2) "연락처" from buy b
	inner join member m 
    on b.mem_id = m.mem_id; 
    
-- 내부 조인의 활용(구매한 기록이 있는 회원)
select m.mem_id, m.mem_name, b.prod_name, m.addr from buy b
	inner join member m
    on b.mem_id = m.mem_id
    order by m.mem_id;
select distinct m.mem_id, m.mem_name, m.addr from member m
	inner join buy b
    on b.mem_id = m.mem_id
    order by m.mem_id;

-- Outer Join
select m.mem_id, m.mem_name, b.prod_name, m.addr from member m
	left outer join buy b
    on m.mem_id = b.mem_id
    order by m.mem_id;
    
-- 외부 조인의 활용
select m.mem_id, m.mem_name, b.prod_name, m.addr from member m
	left outer join buy b
    on m.mem_id = b.mem_id
    where b.prod_name is null
    order by m.mem_id;
    
-- Cross Join(상호조인) : 데이터 내용에는 의미가 없으나 대용량 테이블 만들 때 사용
select * from buy cross join member;
select count(*) "데이터 개수" from sakila.inventory cross join world.city;

-- Self Join(자체조인) : 자신이 자신과 조인
create table emp_table (emp char(4), manager char(4), phone varchar(8));
insert into emp_table values ("대표", Null, "0000");
insert into emp_table values ("영업이사", "대표", "1111");
insert into emp_table values ("관리이사", "대표", "2222");
insert into emp_table values ("정보이사", "대표", "3333");
insert into emp_table values ("영업과장", "영업이사", "1111-1");
insert into emp_table values ("경리부장", "관리이사", "2222-1");
insert into emp_table values ("인사부장", "관리이사", "2222-2");
insert into emp_table values ("개발팀장", "정보이사", "3333-1");
insert into emp_table values ("개발주임", "정보이사", "3333-1-1");

select a.emp "직원", b.emp "직속상관", b.phone "직속상관연락처" from emp_table a
	inner join emp_table b on a.manager = b.emp
    where a.emp="경리부장";
