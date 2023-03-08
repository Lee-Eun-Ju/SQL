-- 07-1 스토어드 프로시저 사용 방법
use market_db;

drop procedure if exists user_proc;
delimiter $$
create procedure user_proc()
begin
	select * from member;
end $$
call user_proc();
drop procedure user_proc; -- 유의점 : 삭제시 괄호 X

-- 입력변수
drop procedure if exists user_proc1;
delimiter $$
create procedure user_proc1(in username varchar(10))
begin
	select * from member where mem_name = username;
end $$
delimiter ;
call user_proc1("에이핑크");

drop procedure if exists user_proc2;
delimiter $$
create procedure user_proc2(in usernumber int, in userheight int)
begin
	select * from member where mem_number > usernumber and height > userheight;
end $$
delimiter ;
call user_proc2(6, 165);

-- 출력변수
drop procedure if exists user_proc3;
delimiter $$
create procedure user_proc3(in txtvalue char(10), out outvalue int)
begin 
	insert into notable values (null, txtvalue);
    select max(id) into outvalue from notable;
end $$
delimiter ;

create table if not exists notable(
	id int auto_increment primary key,
	txt char(10));
    
call user_proc3("테스트1", @myvalue);
select concat("입력된 ID 값 ==>", @myvalue); 

-- SQL 프로그래밍의 활용
drop procedure if exists ifelse_proc;
delimiter $$
create procedure ifelse_proc( in memname varchar(10))
begin
	declare debutyear int ; -- 변수 선언
    select year(debut_date) into debutyear from member where mem_name=memname;
    if (debutyear >=2015) then select "신인 가수네요" as "메시지";
    else select "고참 가수네요" as "메시지";
    end if;
end $$
delimiter ;
call ifelse_proc("오마이걸");

drop procedure if exists while_proc;
delimiter $$
create procedure while_proc()
begin
	declare hap int;
    declare num int;
    set hap =0;
    set num =1;
    
    while (num<=100) do
		set hap = hap+num;
        set num = num+1;
	end while;
    select hap as "1~100 합계";
end $$
delimiter ;
call while_proc();

drop procedure if exists dynamic_proc;
delimiter $$
create procedure dynamic_proc( in tablename varchar(20))
begin
	set @sqlquery = concat("select * from ", tablename); -- 변수 sqlquery에 select문 저장
    prepare myquery from @sqlquery; -- select문 준비 및 실행
    execute myquery;
    deallocate prepare myquery; -- 준비한 myquery 해제
end $$
delimiter ;
call dynamic_proc ("member");