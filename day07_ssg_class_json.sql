set @myvar1 = 5;
set @myvar2 = 6;
set @myvar3 = 7;
set @myvar4 = 8;
set @myvarName = '이름 ==>';

SELECT @myvar1 + @myvar2;
SELECT @myvarName, memberName FROM membertbl; 
select * from membertbl;
insert into membertbl values (1,'ssg','서울');
commit;

use 극장;
create table movie(
  movie_id int,
  movie_title varchar(50),
  movie_director varchar(30),
  movie_star varchar(30),
  movie_script longtext,
  movie_film longblob
) default charset=utf8mb4;   -- LONGBLOB,LONGTEXT 형식의 한글 처리 문제가 없게 하기 위해 설정 

INSERT INTO movie values(1,'쉰들러 리스트','스필버그','리암 니슨',load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Schindler.txt'),load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Schindler.mp4'));
INSERT INTO movie values(2,'쇼생크탈출','프랭크 다라본트','팀 로빈슨/모건 프리먼',load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shawshank.txt'),load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shawshank.mp4'));
INSERT INTO movie values(3,'라스트모히칸','마이클 만','다니엘 데이 루이스',load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Mohican.txt'),load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Mohican.mp4'));
commit;
select * from movie;

-- movie_script 와 movie_film 이 null 인 이유 
-- 1) 최대 패킷 크기가 설정된 시스템 변수  max_allowed_packet 값 확인 
 SHOW variables like 'max_allowed_packet';    -- 4MByte 기본 설정 
 -- my.ini(my.cnf) 시스템 변수값=>  내가 원하는 값으로 max_allowed_packet = 1024M;   
-- 2) 파일 업로드/다운로드 할 폴더 경로를 별도로 허용해 주어야 한다. 시스템 변수 secure_file_priv 확인 
SHOW variables like 'secure_file_priv'; 
-- # Secure File Priv.
-- my.ini(my.cnf) 시스템 변수값=>  내가 원하는 값으로 secure-file-priv="C:/movies/";
use 극장;
select * from movie;
TRUNCATE movie;
drop table movie;


-- ------------------------------------------------------------
use shopdb;

-- 피벗 테이블 : 한 열에 여러값을 출력하고, 이를 여러 열로 변환하여 테이블로 반환하는 방식 

create table pivotTest(
      userName CHAR(10),
      season CHAR(2),
      amount int
);

 insert into pivotTest values
               ('김범수','겨울',10),('유노윤호','여름',15),
               ('김범수','가을',25),('김범수','봄',3),
               ('김범수','봄',37),('윤종신','겨울',40),
               ('김범수','여름',14),('김범수','겨울',22),('윤종신','여름',64);
               commit;
               select * from pivotTest;

SELECT username, 
       SUM(if(season='봄',amount,0)) AS 봄,
       SUM(if(season='여름',amount,0)) AS 여름,
       SUM(if(season='가을',amount,0)) AS 가을,
       SUM(if(season='겨울',amount,0)) AS 겨울,
       SUM((amount)) AS 합계 
FROM pivotTest Group by username;

-- JSON 데이터 (JavaScript Object Notation) : 웹과 모바일 응용 프로그램에서 데이터 교환을 위한 개방형 표준 데이터 포맷
-- 속성 : 값   
  -- { 
--      "아이디" : "winder",
--      "이름" : "ssg"
--   }
-- MYSQL JSON 관련된 다양한 내장 함수 제공 
  select * from membertbl;
  select json_object('memberID',memberid,'memberName',membername) as 'json값' from membertbl;
  
  SET @json = '{
             "membertbl" :
             [
                      {"memberID":2,"membername":"신세계1"},
                      {"memberID":3,"membername":"신세계1"},
                      {"memberID":4,"membername":"신세계3"}
             ]
     }';

 SELECT JSON_VALID(@json) as JSON_VALID;         -- JSON_VALID() : 
 SELECT JSON_SEARCH(@json,'one','신세계1') as JSON_SEARCH;  -- 해당 member의 저장 위치를 확인 
 SELECT JSON_SEARCH(@json,'all','신세계1') as JSON_SEARCH;

CREATE TABLE usertbl -- 회원 테이블
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr	  	CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 키
  mDate    	DATE  -- 회원 가입일
);
CREATE TABLE buytbl -- 회원 구매 테이블(Buy Table의 약자)
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES usertbl(userID)
);

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT COUNT(*) FROM USERTBL;   -- result : 10 row 
SELECT COUNT(*) FROM BUYTBL;    -- result : 12 row

COMMIT;

-- @json_user 변수에 usertbl 이름으로  윤종신, 이승기, 임재범의 이름과 키를 저장하는 json 객체를 생성하세요 
  SET @json_user = '
      {
         "usertbl":
         [
             {"name":"윤종신", "height":170, "address":"서울시 성북구"},
             {"name":"이승기", "height":178,"address":"경기도 성남시"},
             {"name":"임재범", "height":185,"address":"서울시 동작구"}
             
          ]
      
      } ';
-- 여러분들이 생성하신 json_user 객체가 json형식에 맞게 정의되었는지 확인해주세요 .   result => 1 
  SELECT JSON_VALID(@json_user) as 형식확인;

SELECT JSON_INSERT(@json_user,'$.usertbl[0].mDate','2024-03-26');
SELECT JSON_REMOVE(@json_user,'$.usertbl[0]') as 윤종신삭제;
SELECT JSON_REPLACE(@json_user,'$.usertbl[0].name','김승기');


create table jsontest(person json);
desc jsontest;
insert into jsontest values('{"name":"윤종신", "height":170, "address":"서울시 성북구"}');
select * from jsontest;



SELECT * FROM USERTBL WHERE NAME ='김범수'; 
-- 김범수 회원이 구매한 물품리스트를 출력 => 김범수 회원이 여러명 있을 수 있으므로 김범수 회원의 아이디를 확인 후 쿼리문을 작성하는게 정확합니다.
SELECT  * 
    FROM buytbl 
       inner join usertbl 
           on buytbl.userid = usertbl.userid
       WHERE buytbl.userid = 'KBS';    

-- 구매한 기록이 있는 회원들의 정보만 출력하세요 

SELECT  distinct usertbl.name 
    FROM buytbl 
       inner join usertbl 
           on buytbl.userid = usertbl.userid
       order by usertbl.userid;    
-- 우리 쇼핑몰에서 한번이라도 구매한 기록이 있는 회원들에게 쿠폰지급, 안내문 발송 

SELECT  distinct u.name 
    FROM usertbl u
        where exists(
          select * from buytbl b where u.userid = b.userid
        );

-- 전체회원의 구매 기록을 출력 (단, 구매 기록이 없는 회원도 출력)
SELECT u.userid, u.name, b.prodname
FROM usertbl u
     LEFT OUTER JOIN buytbl b
       on u.userid = b.userid
       order by u.userid;
       
       
       
SELECT u.userid, u.name, b.prodname
FROM buytbl b
     RIGHT OUTER JOIN usertbl u
       on u.userid = b.userid
       order by u.userid;
              
-- 구매이력이 아예 없는 회원 출력 
       
 SELECT u.userid, u.name, b.prodname
FROM usertbl u
     LEFT OUTER JOIN buytbl b
       on u.userid = b.userid
	   WHERE b.prodname is null
       order by u.userid;
             