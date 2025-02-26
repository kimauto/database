
CREATE TABLE 극장 (
    극장번호 INT PRIMARY KEY,
    극장이름 VARCHAR(10) NOT NULL,
    위치 VARCHAR(10) NOT NULL
);


CREATE TABLE 상영관 (
    극장번호 INT NOT NULL,
    상영관번호 INT NOT NULL,
    상영관이름 VARCHAR(10) NOT NULL,
    PRIMARY KEY (극장번호, 상영관번호) 
);
ALTER TABLE 상영관 
ADD CONSTRAINT fk_상영관_극장 FOREIGN KEY (극장번호) REFERENCES 극장(극장번호);

CREATE TABLE 고객 (
    고객번호 INT AUTO_INCREMENT PRIMARY KEY,
    이름 VARCHAR(10) NOT NULL,
    주소 VARCHAR(10) NOT NULL
);

CREATE TABLE 예약 (
    극장번호 INT NOT NULL,
    상영관번호 INT NOT NULL,
    좌석번호 INT NOT NULL,
    고객번호 INT NOT NULL,
    예약날짜 DATE NOT NULL,
    PRIMARY KEY (극장번호 , 상영관번호 , 좌석번호)
);

ALTER TABLE 예약 
ADD CONSTRAINT fk_예약_상영관 FOREIGN KEY (극장번호, 상영관번호) REFERENCES 상영관(극장번호, 상영관번호);


ALTER TABLE 예약 
ADD CONSTRAINT fkk_예약_고객 FOREIGN KEY (고객번호) REFERENCES 고객(고객번호);

-- ------------------------------

select * from information_schema.table_constraints where table_name = '상영관';


desc 고객;
-- 1 단순질의
select * from 극장 where 극장이름 ='잠실';

select *
from 고객
where 주소 = 잠실
order by 이름;

select 극장번호, 상영관번호, 영화제목
from 상영관
where price < 8000;

select *
from 고객 고
where 주소 = (
 select 위치
 from 극장 극
 where 극.위치 = 고.주소
);

-- 2 집계질의
select count(극장번호)
from 극장;

select avg(가격)
from 상영관;

select count(날짜)
from 예약
where 날짜 like '2024-09-01';

-- 3 부속질의
select 영화제목
from 상영관
where 극장번호 =
(select 극장번호
from 극장
where 위치 = '대한');

select 이름
from 고객 고, 예약 예, 극장 극
where 고.고객번호 = 예.고객번호 and 극.극장번호 = 예.극장번호 and 극.극장이름 ='대한';


-- 그룹 질의
select sum(가격)
from 상영관 상, 극장 극
where 상.극장번호 = 극.극장번호 and 극.극장이름 = '대한';

select 극장번호, count(극장번호) as '상영관 수' 
from 상영관
group by 극장번호;

select count(극장번호)
from 상영관
where 극장번호 =(
	select 극장번호
	from 극장
	where 극장이름 ='잠실');
    
select 극장번호 ,avg(좌석번호) as '평균 수'
from 예약
where 날짜 = '2024-09-01'
group by 극장번호;

SELECT 상영관.영화제목
FROM 상영관
WHERE (상영관.극장번호, 상영관.상영관번호) = (
    SELECT 예약.극장번호, 예약.상영관번호
    FROM 예약
    WHERE 예약.예약날짜 = '2024-09-01'
    GROUP BY 예약.극장번호, 예약.상영관번호
    ORDER BY COUNT(*) DESC
);

-- dml
select * from 극장;
select * from 상영관;
select * from 고객;
insert into 극장 values(null, '롯데' , '잠실');
insert into 고객 values(null, '김병곤' , '강남');
insert into 상영관 values(1, 1 , '어려운 영화', 15000,48);
INSERT INTO 예약 VALUES (1, 1,15, 1, '2024-09-01');

update 상영관 set 가격 = 가격 * 1.10;









