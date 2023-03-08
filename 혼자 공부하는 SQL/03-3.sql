-- 데이터 변경을 위한 SQL문
use market_db;

-- Insert 문
create table hongong1 (toy_id int, toy_name char(4), age int);
insert into hongong1 values (1,"우디",25);
insert into hongong1 (toy_id, toy_name) values (2,"버즈");
insert into hongong1 (toy_name, age, toy_id) values ("제시",20,3);
select * from hongong1;

-- auto_increment : 1부터 증가하는 값 (primary key)
create table hongong2 (toy_id int auto_increment primary key, toy_name char(4), age int);
insert into hongong2 values (NULL,"보핍",25);
insert into hongong2 values (NULL,"슬링키",22);
insert into hongong2 values (NULL,"렉스",21);
select * from hongong2;

-- key 시작값 변경
select last_insert_id(); -- 마지막 key
alter table hongong2 auto_increment=100; -- key 다음값을 100부터 시작 
insert into hongong2 values (NULL,"재남",35);
select * from hongong2;

-- key 증가값 변경
create table hongong3 (toy_id int auto_increment primary key, toy_name char(4), age int);
alter table hongong3 auto_increment=1000;
set @@auto_increment_increment=3; -- 시스템 변수 변경: 증가값을 3으로
insert into hongong3 values (NULL,"토마스",20);
insert into hongong3 values (NULL,"제임스",23);
insert into hongong3 values (NULL,"고든",25);
select * from hongong3;

-- 다른 테이블의 데이터를 한 번에 입력 : insert into ~ select
select count(*) from world.city; -- 데이터베이스.테이블
desc world.city; -- desc: 테이블의 구조 출력
select * from world.city limit 5;
create table city_popul (city_name char(35), population int);
insert into city_popul select name, population from world.city;
select * from city_popul limit 5;

-- update 문 : 데이터 수정
update city_popul set city_name = "서울" where city_name ="Seoul";
select * from city_popul where city_name="서울";

update city_popul set city_name = "뉴욕", population = 0 where city_name = "New York"; -- 해당 행의 여러개 열 변경
select * from city_popul where city_name="뉴욕";

update city_popul set population = population/10000; -- where절을 사용하지 않는 경우
select * from city_popul limit 5;

-- delete 문 : 데이터 삭제 (행단위)
delete from city_popul where city_name like "New%";
delete from city_popul where city_name like "New%" limit 5;

