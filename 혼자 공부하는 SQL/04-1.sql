-- MySQL의 데이터 형식
use market_db;

-- 정수형
create table hongong4 (
	tinyint_col tinyint,
    smallint_col smallint,
    int_col int,
    bigint_col bigint );
insert into hongong4 values (127,32767,2147483647,9000000000000000000);

-- 문자형 및 대량의 데이터 형식
create database netflix_db;
use netflix_db;
create table movie
	(movie_id int,
    movie_title varchar(30), -- 가변길이 문자형
    movie_director varchar(20),
    movie_star varchar(20),
    movie_script longtext, -- 대량의 문자형 데이터 
    movie_film longblob); -- 이미지, 동영상 데이터
    
-- 변수의 사용
use market_db;
set @myVar1 = 5;
set @myVar2 = 4.25;
select @myVar1 + @myVar2;
set @txt = "가수 이름 ==> "; 
set @height = 166;
select @txt, mem_name from member where height > @height;

-- prepare과 execute의 사용
set @count = 3;
prepare mySQL from "select mem_name, height from member order by height limit ?";
execute mySQL using @count;

-- 데이터 형 변환 (명시적 변환)
select avg(price) "평균가격" from buy;
select cast(avg(price) as signed) "평균가격" from buy;
select convert(avg(price), signed) "평균가격" from buy;
select cast("2022%12%12" as date) "날짜";
select num, concat(cast(price as char),"x",cast(amount as char),"=") "가격x수량", price*amount "구매액" from buy;

-- 데이터 형 변환 (암시적 변환)
select "100" + 200;
select concat(100, "200");