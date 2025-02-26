create table memebrTBL(
 memberID varchar(8) not null,
 memberName varchar(10) not null,
 memberAddress varchar(20),
 primary key(memberID)
);

create table productTBL(
	productID int auto_increment ,
    productName varchar(4) not null,
    cost int not null,
    makeDate date,
     primary key(produCtID)
);

desc productTbl;

-- 테이블 수정 (새로운 컬럼 추가)
ALTER TABLE productTBL Add column productID int not null unique;
-- 테이블 수정 (컬럼 삭제)
alter table producttbl drop column producttbl;

alter table producttbl change column cost price int;

-- productName 컬럼 앞에 productID 컬럼을 추가 
alter table producttbl add column productID int not null first;

-- 테이블에 지정 컬럼 뒤에 추가
alter table producttbl add column descript varchar(100) not null after price;

-- 컬럼 타입 변경 
alter table producttbl modify COLUMN price smallint;


-- pratice03
alter table book change column cost price int;


