-- 05-2 제약조건으로 테이블을 견고하게
use naver_db;

-- 기본키 제약조건
drop table if exists buy, member;
create table member (
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null);
describe member;

drop table if exists buy, member;
create table member (
mem_id char(8) not null,
mem_name varchar(10) not null,
height tinyint unsigned null);
alter table member
	add constraint primary key (mem_id);

-- 외래키 제약조건
drop table if exists buy, member;
create table member(
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null);
create table buy(
num int auto_increment not null primary key,
mem_id char(8) not null, 
prod_name char(6) not null,
foreign key (mem_id) references member(mem_id));

drop table if exists buy;
create table buy(
num int auto_increment not null primary key,
mem_id char(8) not null,
prod_name char(6) not null);
alter table buy 
	add constraint foreign key (mem_id) references member(mem_id);
    
-- 기준 테이블의 열 변경 X (delete, update) => on update cascade, on delete cascade
insert into member values ("BLK", "블랙핑크", 163);
insert into buy values (Null, "BLK", "지갑");
insert into buy values (Null, "BLK", "맥북");
select m.mem_id, m.mem_name, b.prod_name from buy b
	inner join member m on m.mem_id=b.mem_id;
update member set mem_id="PINK" where mem_id="BLK"; 
delete from member where mem_id="BLK";

drop table if exists buy;
create table buy(
num int auto_increment not null primary key,
mem_id char(8) not null,
prod_name char(6) not null);
alter table buy 
	add constraint foreign key (mem_id) references member(mem_id)
    on update cascade on delete cascade;

-- 고유키 제약조건
drop table if exists buy, member;
create table member(
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null,
email char(30) null unique);

insert into member values("BLK", "블랙핑크", 163, "pink@gmail.com");
insert into member values("TWC", "트와이스", 167, Null); -- null값 허용 
insert into member values("APN", "에이핑크", 164, "pink@gmail.com"); -- 중복값 허용X

-- 체크 제약조건
drop table if exists member;
create table member(
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null check(height>=100),
phone1 char(3) null) ;
insert into member values("BLK", "블랙핑크", 163, Null);
insert into member values("TWC", "트와이스", 99, Null);

alter table member
	add constraint check (phone1 in ("02", "031", "032", "054", "055", "061"));
insert into member values("TWC", "트와이스", 167, "02");
insert into member values("OMY", "오마이걸", 167, "010");

-- 기본값 제약조건
drop table if exists member;
create table member(
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null default 160,
phone1 char(3) null);
alter table member 
	alter column phone1 set default "02";

insert into member values ("RED", "레드벨벳", 161, "054");
insert into member values ("SPC", "우주소녀", default, default);
select * from member;

