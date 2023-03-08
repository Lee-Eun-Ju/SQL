-- 07-3 자동 실행되는 트리거
use market_db;
create table if not exists trigger_table (id int, txt varchar(10));
insert into trigger_table values(1, "레드벨벳");
insert into trigger_table values(2, "잇지");
insert into trigger_table values(3, "블랙핑크");

-- 트리거 기본작동
drop trigger if exists mytrigger;
delimiter $$
create trigger mytrigger
	after delete -- delete문이 시행된 이후
    on trigger_table
    for each row -- 각 행마다 적용(트리거에 주로 사용)
begin 
	set @msg = "가수 그룹이 삭제됨"; -- 트리거 실행 시 작동
end $$
delimiter ;

set @msg = "";
insert into trigger_table values(4, "마마무");
select @msg ;
update trigger_table set txt="블핑" where id=3;
select @msg ;
delete from trigger_table where id=4;
select @msg ;

-- [ 트리거 활용 ]
create table singer (select mem_id, mem_name, mem_number, addr from member);

-- 백업 테이블 : 변경되기 전의 테이블 저장
create table backup_singer(
	mem_id char(8) not null,
    mem_name varchar(10) not null,
    mem_number int not null,
    addr char(2) not null,
    modtype char(2), -- 변경된 타입(수정, 삭제) 
    moddate date, -- 변경된 날짜
    moduser varchar(30) );-- 변경한 사용자 

-- 변경이 발생하였을 때 트리거
drop trigger if exists singer_updatetrg;
delimiter $$
create trigger singer_updatetrg
	after update
    on singer
    for each row
begin
	insert into backup_singer values( old.mem_id, old.mem_name, old.mem_number, old.addr, "수정", curdate(), current_user());
end $$
delimiter ;

-- 삭제하였을 때 트리거
drop trigger if exists singer_deletetrg;
delimiter $$
create trigger singer_deletetrg
	after delete
    on singer
    for each row
begin 
	insert into backup_singer values(old.mem_id, old.mem_name, old.mem_number, old.addr, "삭제", curdate(), current_user());
end $$
delimiter ;

-- 적용
update singer set addr="영국" where mem_id="BLK";
delete from singer where mem_number >=7;
select * from backup_singer;
truncate table singer; -- delete문으로 삭제할 때만 트리거 작용
select * from backup_singer;
