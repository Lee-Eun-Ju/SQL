-- 04-3 SQL 프로그래밍
use market_db;

-- 스토어드 프로시저 구조
delimiter $$
create procedure example()
	begin
	-- sql 코딩
	end $$
delimiter ;
call example;

-- IF 문
drop procedure if exists ifProc1;
delimiter $$
create procedure ifProc1()
begin
	if 100=100 then
		select '100은 100과 같습니다';
	end if;
end $$
delimiter ;
call ifProc1();

drop procedure if exists ifProc2;
delimiter $$
create procedure ifProc2()
begin
	declare myNum int;
    set myNum = 200;
    if myNum =100 then
		select "100입니다.";
	else 
		select "100이 아닙니다.";
	end if ;
end $$
delimiter ;
call ifProc2();

-- IF문의 활용
drop procedure if exists ifProc3;
delimiter $$
create procedure ifProc3()
begin 
	declare debutDate date;
    declare curDate date;
    declare days int;
    
    select debut_date into debutDate from market_db.member where mem_id="APN";
    set curDate = current_date();
    set days = datediff(curDate, debutDate );
    
    if (days/365) >= 5 then
		select concat("데뷔한 지", days, "일이나 지났습니다. 핑순이들 축하합니다!");
	Else
		select concat("데뷔한 지", days, "일밖에 안되었네요. 핑순이들 화이팅~");
    end if;
end $$
delimiter ;
call ifProc3();

-- CASE 문
drop procedure if exists caseProc;
delimiter $$
create procedure caseProc()
begin
	declare point int;
    declare credit char(1);
    set point = 88;
    
    case
		when point >= 90 THEN
			set credit = "A";
		when point >= 80 then
			set credit = "B";
		when point >= 70 then
			set credit = "C";
		when point >= 60 then
			set credit = "D";
		else
			set credit = "F";
	end case;
    select concat("취득점수==>",point, "학점==>",credit);
end $$
delimiter ;
call caseProc();

-- CASE문의 활용
 select m.mem_id, m.mem_name, sum(b.price*b.amount) "총구매액",
	case
		when (sum(b.price*b.amount) >= 1500) then "최우수고객"
        when (sum(b.price*b.amount) >= 1000) then "우수고객"
        when (sum(b.price*b.amount) >= 1) then "일반고객"
        else "유령고객"
	end "회원등급"
	from buy b
	right outer join member m on m.mem_id=b.mem_id
    group by m.mem_id
    order by sum(b.price*b.amount) desc;

-- While 문
 drop procedure if exists whileProc2;
 delimiter $$
 create procedure whileProc2()
 begin 
	declare i int;
    declare hap int;
    set i = 1 ;
    set hap = 0 ;
    
    mywhile:
    while (i<=100) do
		if (i % 4 = 0) then
			set i = i+1;
            iterate mywhile;
		end if;
        set hap = hap + i;
        if (hap > 1000) then
			leave mywhile;
		end if;
        set i = i + 1;
	end while ;
    select hap;
end $$
delimiter ;
call whileProc2();

-- 동적 SQL
prepare myquery from "select * from member where mem_id='BLK'";
execute myquery;
deallocate prepare myquery;

 drop table if exists gate_table;
 create table gate_table (id int auto_increment primary key, entry_time datetime);
 set @curDate = current_timestamp();
 prepare myquery from "insert into gate_table values (Null, ?)";
 execute myquery using @curDate;
 deallocate prepare myquery;
 select * from gate_table;