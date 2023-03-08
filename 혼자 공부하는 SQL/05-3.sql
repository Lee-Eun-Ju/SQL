-- 05-3 가상의 테이블 : 뷰
use market_db;
select mem_id, mem_name, addr from member;

-- 뷰의 기본 생성
create view v_member
	as select mem_id, mem_name, addr from member;
select * from v_member;
select mem_name, addr from v_member where addr in ("서울","경기");

create view v_memberbuy
	as select b.mem_id, m.mem_name, b.prod_name, m.addr, concat(m.phone1, m.phone2) "연락처" from buy b
    inner join member m on m.mem_id = b.mem_id;
select * from v_memberbuy where mem_name="블랙핑크";

-- 뷰의 실제 생성, 수정, 삭제
create view v_viewtest1
	as select b.mem_id "Member ID", m.mem_name "Member name", b.prod_name "Product name", 
			  concat(m.phone1, m.phone2) "Office Phone" from buy b
	inner join member m on b.mem_id=m.mem_id;
select distinct `Member ID`, `Member name` from v_viewtest1;

alter view v_viewtest1
	as select b.mem_id "회원 아이디", m.mem_name "회원 이름", b.prod_name "제품 이름",
			  concat(m.phone1, m.phone2) "연락처" from buy b
	inner join member m on b.mem_id=m.mem_id;
select distinct `회원 아이디`, `회원 이름` from v_viewtest1;

drop view v_viewtest1;

-- 뷰의 정보 확인
create or replace view v_viewtest2 
	as select mem_id, mem_name, addr from member;
describe v_viewtest2; -- 뷰의 정보
show create view v_viewtest2; -- 뷰의 소스코드

-- 뷰를 통한 데이터의 수정/삭제
update v_viewtest2 set addr="부산" where mem_id="BLK";
insert into v_viewtest2(mem_id,mem_name,addr) values ("BTS","방탄소년단","경기");

create view v_height167
	as select * from member where height>=167;
select * from v_height167;
delete from v_height167 where height<167;

insert into v_height167 values("TRA", "티아라", 6, "서울", Null, Null, 159, "2005-01-01");
select * from v_height167;
alter view v_height167
	as select * from member where height>=167
    with check option;

-- 뷰가 참조하는 테이블 삭제
drop table if exists buy, member;
select * from v_height167;
check table v_height167;

