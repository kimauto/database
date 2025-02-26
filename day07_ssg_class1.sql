
create table pivotTest(
	userName char(10),
    season char(2),
    amount int
);

insert into pivotTest values
	                  ('김범수','겨울',10),('김야채','여름',10),
	                  ('김범수','가을',20),('김고기','겨울',10),
	                  ('김범수','여름',30),('김범수','여름',10),
	                  ('김범수','봄',15),('김범수2','가을',23);
                      select * from pivotTest;
                      
SELECT username,
       SUM(if(season='봄',amount,0)) AS 봄,
       SUM(if(season='여름',amount,0)) AS 여름,
       SUM(if(season='가을',amount,0)) AS 가을,
       SUM(if(season='겨울',amount,0)) AS 겨울,
       SUM((amount)) AS 합계
FROM pivotTest Group by username;
select * from memebrtbl;
-- json 데이터
select json_object('memberID', memberid,'memberName', membername) as 'json값' from memebrtbl;

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

