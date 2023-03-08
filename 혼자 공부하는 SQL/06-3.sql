-- 06-3 인덱스의 실제 사용
use market_db;

-- 인덱스의 생성 실습
select * from member;
show index from member; -- 인덱스 정보
show table status like "member"; -- 인덱스 크기
 
create index idx_member_addr on member (addr);
show index from member;
show table status like "member"; -- 적용 X
analyze table member;
show table status like "member"; -- 적용 O

create unique index idx_member_mem_name on member (mem_name);
show index from member;
insert into member values ("MOO", "마마무", 2, "태국", "001", "12341234", 155, "2020.10.10"); 

-- 인덱스 활용 실습
analyze table member;
show index from member;

select * from member;
select mem_id, mem_name, addr from member;
select mem_id, mem_name, addr from member where mem_name="에이핑크";

create index idx_member_mem_number on member (mem_number);
analyze table member;
select mem_name, mem_number from member where mem_number >= 7 ; -- 인덱스 활용 검색
select mem_name, mem_number from member where mem_number >=1; -- 전체 테이블 검색
select mem_name, mem_number from member where mem_number*2 >= 14; -- 열에 연산이 가해지는 경우 인덱스 활용X
select mem_name, mem_number from member where mem_number >= 14/2; 

-- 인덱스 제거 실습
show index from member;
drop index idx_member_mem_name on member;
drop index idx_member_addr on member;
drop index idx_member_mem_number on member;

alter table member drop primary key;
select table_name, constraint_name 
	from information_schema.referential_constraints
    WHERE constraint_schema = "market_db";
alter table buy drop foreign key buy_ibfk_1;
alter table member drop primary key;