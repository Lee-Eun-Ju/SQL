use market_db;

-- order by 절
select mem_id,mem_name,debut_date from member order by debut_date; -- 오름차순
select mem_id,mem_name,debut_date from member order by debut_date desc; -- 내림차순
select mem_id,mem_name,debut_date,height from member where height>=164 order by height desc; -- [순서] where -> order by
select mem_id,mem_name,debut_date,height from member where height>=164 order by height desc, debut_date;

-- limit 절 (order by와 함께 자주 쓰임)
select * from member limit 3; -- 0번째부터 3건 의미
select mem_name, debut_date from member order by debut_date limit 3;
select mem_name, height from member order by height desc limit 3, 2; -- 3번째부터 2건 의미

-- distinct 절
select addr from member;
select addr from member order by addr;
select distinct addr from member;

-- group by 절 (+집계 함수 sum,avg,min,max,count,count(distinct) )
select mem_id, sum(amount) from buy group by mem_id;
select mem_id "회원 아이디", sum(amount) "총 구매 개수" from buy group by mem_id;
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액" from buy group by mem_id;
select mem_id "회원 아이디", avg(amount) "평균 구매 개수" from buy group by mem_id;
select count(*) from member; -- 모든 행의 개수
select count(phone1) "연락처가 있는 회원" from member; -- 해당 열에 관측치가 있는 행의 개수(NULL값이 아닌 경우의 행)

-- having 절 : group by 절과 관련된 조건절 (group by절 -> having절)
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액" from buy group by mem_id;
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액" from buy group by mem_id having sum(price*amount) > 1000;
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액" 
	from buy group by mem_id 
    having sum(price*amount) >1000
    order by sum(price*amount) desc;