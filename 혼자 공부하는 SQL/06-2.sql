-- 06-2 인덱스의 내부 작동
use market_db;

-- 클러스터형 인덱스 구성
create table cluster(
	mem_id char(8),
    mem_name varchar(10));
insert into cluster values ("TWC", "트와이스");
insert into cluster values ("BLK", "블랙핑크");
insert into cluster values ("WMN", "여자친구");
insert into cluster values ("OMY", "오마이걸");
insert into cluster values ("GRL", "소녀시대");
insert into cluster values ("ITZ", "잇지");
insert into cluster values ("RED", "레드벨벳");
insert into cluster values ("APN", "에이핑크");
insert into cluster values ("SPC", "우주소녀");
insert into cluster values ("MMU", "마마무"); 
select * from cluster;

alter table cluster add constraint primary key (mem_id);
select * from cluster;    

-- 보조 인덱스 구성
create table second(
	mem_id char(8),
    mem_name varchar(10));
insert into second values ("TWC", "트와이스");
insert into second values ("BLK", "블랙핑크");
insert into second values ("WMN", "여자친구");
insert into second values ("OMY", "오마이걸");
insert into second values ("GRL", "소녀시대");
insert into second values ("ITZ", "잇지");
insert into second values ("RED", "레드벨벳");
insert into second values ("APN", "에이핑크");
insert into second values ("SPC", "우주소녀");
insert into second values ("MMU", "마마무"); 
select * from second;

alter table second add constraint unique(mem_id);
select * from second;

