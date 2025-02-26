-- 데이터조작어(DML) : SELECT, DELETE,UPDATE,INSERT 
-- 데이터 정의어 (DDL) : CREATE, DROP,ALTER

-- testdb database를 생성하여 ssg@localhost 계정이 객체에 대한 모든 권한을 처리할 수 있도록  
use testdb;

-- 테이블명: test_create_table 생성하시오, 컬럼은 co1_1 int, col_2 varchar(50), col_3 datetime 이다.
create table test_create_table(col_1 int, col_2 varchar(50), col_3 datetime);

-- test_create_table 에   1, 'testSQL' , '2025-01-01' 데이터를 입력하세요 
   INSERT INTO test_create_table(col_1,col_2,col_3) values (1, 'testSQL' , '2025-01-01');
   INSERT INTO test_create_table(col_1,col_2,col_3) values (1, 'testSQL' , now());
   INSERT INTO test_create_table(col_1,col_2,col_3) values (1, 'testSQL' , now());
   INSERT INTO test_create_table(col_1,col_2,col_3) values (1, 'testSQL' , now());
   INSERT INTO test_create_table(col_1,col_2,col_3) values (1, 'testSQL' , now());
   
   
   
   INSERT INTO test_create_table values (1, 'testSQL' , now());
  
   INSERT INTO test_create_table(col_1,col_2) values (1,'3');
   
    INSERT INTO test_create_table(col_2,col_1,col_3) values ('testSQL', 1 , now());
   
-- 입력된 데이터 확인하세요 
   SELECT * FROM test_create_table;
   rollback;
   commit;
   
-- 여러 데이터를 한번에 삽입 
   INSERT INTO test_create_table
   VALUES(8, 'testSQL' , now()),(9, 'testSQL' , now()),(null, 'testSQL' , now());
   
--   test_create_table 의 col_1의 컬럼속성을 변경  col_1 의 속성을 int => smallint  not null 속성 추가  
	alter table test_create_table modify col_1 smallint not null;
    desc test_create_table;
    
    
 -- UPDATE 문으로 데이터 수정 
  -- UPDATE 테이블이름 SET 열1, 열2, 열3 (WHERE  [열 = 조건]);
   SELECT * FROM test_create_table;

UPDATE test_create_table SET col_2 = 'testSQL_UPDATE'  where col_1 = 5;


-- COMMIT 시에는 반영된 데이터 값을 되돌릴 수 없다. 
-- DML 작업시 특히 DELETE 작업시 COMMIT 작업은 신중히, 최소시 ROLLBACK 하면 한단계 취소 

-- DELETE FROM 테이블 이름;   
-- DELETE FROM 테이블 이름 WHERE  열 = 조건;

CREATE TABLE NEWBOOK(
   bookid integer,
   bookname varchar(20),
   publisher varchar(20),
   price integer,
   primary key(bookid)
);

ALTER TABLE NEWBOOK modify BOOKNAME varchar(20) NOT NULL;
ALTER TABLE NEWBOOK modify PUBLISHER varchar(20) UNIQUE;
ALTER TABLE NEWBOOK modify PRICE INTEGER DEFAULT 10000 CHECK(PRICE > 1000);

   
-- ALTER TABLE newbook
-- MODIFY COLUMN bookname VARCHAR(20) NOT NULL,
-- MODIFY COLUMN publisher VARCHAR(20) UNIQUE,
-- MODIFY COLUMN price INTEGER DEFAULT 10000 CHECK(PRICE > 1000);


CREATE TABLE NEWCUSTOMER(
    custid integer primary key,
    name varchar(40),
    address varchar(40),
    phone varchar(30)
);

CREATE TABLE NEWOrders(
    ORDERID INTEGER,
    custid integer not null,
    bookid integer not null,
    saleprice integer,
    orderdate date,
    primary key (orderid)
    
  );

drop table newbook;
drop table newcustomer;

-- foreign key (관계 해제)  => 테이블을 기준, 데이터베이스 기준 외래키 확인 

select * from information_schema.table_constraints where table_name = 'neworders';

alter table neworders drop foreign key neworders_ibfk_1;
alter table neworders drop foreign key fk_custid;

-- 테이블 마다 스키마가 생성됨 해당 테이블의 제약조건이 명시되어있음 constraint_name을 보기 쉽게 바꿔줌 
alter table neworders add constraint fk_bookid foreign key(bookid) references newbook(bookid) on delete cascade; 
alter table neworders add constraint fk_custid foreign key(custid) references newcustomer(custid) on delete cascade; 

insert into newcustomer values(1,'sss','korea','010-2323-3232');

update newcustomer set custid = null where custid = 1;

select * from newbook;
select * from neworders;
select * from newcustomer;
rollback;
delete from neworders where ORDERID =1;
insert into newbook values(2,"최문규는 뭘까","김곤출판사",5000);

-- neworders 테이블에 orderid에 auto_increment
alter table neworders modify orderid int not null auto_increment; 
insert into neworders values(null,1,1,9000,now());
insert into neworders values(null,1,2,8000,now());

update neworders set bookid = 2 where custid =1;
