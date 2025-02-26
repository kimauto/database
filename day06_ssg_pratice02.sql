-- 1.숫자함수 
-- ABS() 숫자의 절댓값을 반환
-- 상수값 -78 과 +78 을 대상으로 ABS함수를 수행하여라 (절댓값)
SELECT ABS(-78) , ABS(+78) FROM DUAL;  -- 오라클일 경우 DUAL(가상테이블)
SELECT ABS(-78) , ABS(+78);  -- MYSQL일 경우 

-- 10   10.1  -10.1     10   11  -10   CEIL() => 올림함수
SELECT CEIL(10),CEIL(10.1),CEIL(-10.1);

SELECT ceiling(3.14) AS ceil_value;
SELECT floor(3.14) AS floor_value;

-- TRUNCATE() => 숫자를 지정한 소수점 자리수로 잘라낸다. (반올림을 하지 않는다.)
SELECT truncate(3.141592,2) as truncate_ex;

-- 4.875 를 소수 첫째 자리까지 반올림한 값을 구하시오 
SELECT ROUND(4.875,1);
-- MOD() => 숫자의 나머지를 반환하는 함수 
SELECT MOD(10,3) AS 나머지;

-- 고객별 평균 주문 금액을 (백원 단위)로 반올림한 값을 구하시오 
-- SELECT custid '고객번호',  ROUND(SUM(saleprice)/COUNT(*), -2) '평균금액'
SELECT custid '고객번호',  ROUND(AVG(saleprice), -2) '평균금액'
FROM Orders
GROUP BY custid;

SELECT TRIM('=' FROM '==FROM=FROM==');

-- 한문자가 차지하는 바이트의 기준은 데이터베이스시스템에 따라 다르게 적용되는데
-- UTF-8 환경에서는 알파벳 'a' 1byte,  한글 '가' =>  3바이트 로 저장된다. 
-- 그러므로 순수한 문자의 수를 알기위해서는 CHAR_LENGTH(문자열) 사용한다. 
-- 공백도 하나의 문자로 취급됩니다.

SELECT LENGTH('SSSSSGGGG ');
SELECT CHAR_LENGTH('신세계');
SELECT LENGTH('신세계');

SELECT * FROM BOOK;

SELECT bookid, replace(bookname,'야구','농구') bookname
FROM BOOK;

-- 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 확인하세요 
SELECT bookname '제목' , CHAR_LENGTH(bookname) 문자수, LENGTH(bookname) 바이트수
FROM Book
WHERE publisher = '굿스포츠';

SELECT SUBSTR(name,1,1) 성 , COUNT(*) 인원 from customer GROUP BY SUBSTR(name,1,1);

-- 3) 날짜 시간 함수 

SELECT SYSDATE();
SELECT NOW();

-- 
SELECT orderid 주문번호, orderdate 주문일, ADDDATE(orderdate, interval 10 DAY) 구매확정일
FROM Orders;

SELECT orderid 주문번호,  date_format(orderdate,'%Y-%m-%d') 주문일
FROM ORDERS
WHERE orderdate = STR_TO_DATE('20240707','%Y%m%d');

CREATE TABLE mybook(bookid int , price int);
INSERT INTO mybook values(1,10000), (2,20000),(3, null);
commit;
select * from mybook;



select price + 100 from mybook where bookid = 3;
select sum(price) , avg(price),count(*) ,count(price)
from mybook
where bookid >= 4;

-- NULL 값을 확인하는 방법  (IN NULL , IS NOT NULL) 아니다 => <>

SELECT * FROM MYBOOK WHERE PRICE IS NULL;
SELECT * FROM MYBOOK WHERE PRICE = '';

-- IFNULL 함수 => NULL값을 다른 값으로 치환하여 연산한다. 
SELECT * FROM CUSTOMER;

SELECT name 이름, ifnull(phone ,'연락처없음') 전화번호
FROM CUSTOMER;

SELECT BOOKID 북아이디, IFNULL(PRICE,0) FROM MYBOOK;

SET   @seq:=9;
SELECT (@seq:=@seq+1) 순번 ,custid , name, phone
FROM CUSTOMER;
-- WHERE  @seq < 2;

