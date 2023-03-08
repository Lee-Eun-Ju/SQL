-- 03-1 기본 중에 기본 select ~ from ~ where
use market_db;

-- select문
select * from member;
select * from shop_db.member;
select addr 주소 , debut_date "데뷔 일자" , mem_name from member;

-- where절
select * from member where mem_name="블랙핑크";
select * from member where mem_number=4;

-- 관계연산자/논리연산자
select mem_id, mem_name from member where height<=162;
select mem_id, mem_name, mem_number from member where height>=165 and mem_number>6;
select mem_id, mem_name, mem_number from member where height>=165 or mem_number>6;

-- Between ~ And ~
select mem_name, height from member where height>=163 and height<=165;
select mem_name, height from member where height between 163 and 165;

-- In()
select mem_name, addr from member where addr="경기" or addr="전남" or addr="경남";
select mem_name, addr from member where addr in("경기", "전남", "경남");

-- Like
select * from member where mem_name like "우%"; -- % : 어떤 글자, 개수 상관없음
select * from member where mem_name like "__핑크"; -- _(언더바) : 개수는 지정함

-- 서브 쿼리
select mem_name,height from member 
	where height > (select height from member where mem_name="에이핑크") 