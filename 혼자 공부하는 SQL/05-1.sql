-- 05-1 테이블 만들기
drop database if exists naver_db;
create database naver_db;

-- 테이블 생성
use naver_db ;
drop table if exists member;
create table member(
mem_id char(8) primary key not null,
mem_name varchar(10) not null,
mem_number tinyint not null,
addr char(2) not null,
phone1 char(3),
phone2 char(8),
height tinyint unsigned,
debut_date date);

drop table if exists buy;
create table buy(
num int not null primary key auto_increment ,
mem_id char(8) not null,
prod_name char(6) not null,
group_name char(4) null,
price int unsigned not null  ,
amount smallint unsigned   not null ,
foreign key(mem_id) references member(mem_id));

-- 데이터 입력하기
insert into member values ("TWC", "트와이스", 9, "서울", "02", "11111111", 167, "2015-10-19");
insert into member values ("BLK", "블랙핑크", 4, "경남", "055", "22222222", 163, "2016-8-8");
insert into member values ("WMN", "여자친구", 6, "경기", "031", "33333333", 166, "2015-1-15");

insert into buy values (NULL, "BLK", "지갑", NULL, 30, 2);
insert into buy values (NULL, "BLK", "맥북프로", "디지털", 1000, 1);
-- insert into buy values (NULL, "APN", "아이폰", "디지털", 200, 1);


