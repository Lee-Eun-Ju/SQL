-- 07-2 스토어드 함수와 커서
use market_db;
set global log_bin_trust_function_creators = 1; -- 스토어드 함수 생성 권한 허용

-- 스토어드 함수(숫자 2개의 합계 사용)
drop function if exists sumFunc;
delimiter $$
create function sumFunc(number1 int, number2 int)
	returns int -- 반환할 값의 데이터 형식: int
begin 
	return number1 + number2;
end $$
delimiter ;
select sumFunc(100,200) as "합계";

-- 스토어드 함수(데뷔 연도 입력시, 활동 기간 출력)
drop function if exists calcYearFunc;
delimiter $$
create function calcYearFunc(dyear int)
	returns int
begin 
	declare runyear int;
    set runyear = year(curdate()) - dyear;
    return runyear;
end $$
delimiter ;
select calcYearFunc(2010) as "활동 햇수";

select calcYearFunc(2007) into @debut2007 ;
select calcYearFunc(2013) into @debut2013 ;
select @debut2007 - @debut2013 as "2007과 2013의 차이";
select mem_id, mem_name, calcYearFunc(year(debut_date)) as "활동 햇수" from member;
drop function calcYearFunc ;

-- 커서로 한 행씩 처리하기 
drop procedure if exists cursor_proc;
delimiter $$
create procedure cursor_proc()
begin
	-- 변수 준비하기
	declare memnumber int;
    declare cnt int default 0;
    declare totnumber int default 0;
    declare endofrow boolean default false;
    
    -- 커서 선언하기
    declare membercuror cursor for select mem_number from member;
    -- 반복 조건 선언하기
    declare continue handler for not found set endofrow=TRUE;
    -- 커서 열기
    open membercuror;
    
    -- 행 반복하기
    cursor_loop: LOOP
		fetch membercuror into memnumber;
        if endofrow then leave cursor_loop; 
        end if;
        set cnt = cnt+1;
        set totnumber = totnumber+memnumber;
	end LOOP cursor_loop;
    select (totnumber/cnt) as "회원의 평균 인원수";
    -- 커서 닫기
	close membercuror;
end $$
delimiter ;

call cursor_proc();
