-- 1 . 운영자적 관점 SQL : 집계 (aggregate) ->  집계함수(aggregate function) 제공 
-- 집계함수란 테이블의 각 열에 대해 계산하는 함수 
desc book;
desc customer;
desc orders;
desc test;
-- 3-15 고객(customer)이 주문한 도서의 총판매액을 구해보자 
   SELECT sum(saleprice) as '총매출'
   FROM orders;
-- 3-16    
   select custid from customer where name ='김연아';
   select sum(saleprice)as '총매출' from orders where custid = 2;
 -- 3.17  
 SELECT SUM(saleprice) as 'Total',
		AVG(saleprice) as 'AVERAGE',
        MIN(saleprice) as 'MINIMUM',
        MAX(saleprice) as 'MAXIMUM'
 FROM orders;
 
 -- 3-18  count()-> 행의 개수를 셈  count(*) 전체 튜플의 수 반환하는데 Null을 제하고 반환
    SELECT COUNT(orderid) from orders;
    
-- group by절 사용하면 속성값이 같은 값끼리 그룹을 만들 수 있다.

select * from customer;

-- 3-19
select custid as 고객아이디, count(bookid) as 도서수향, sum(saleprice) as '총액'
from orders
group by custid;
select * from orders;
select * from customer;
select * from book;

	  select SYSDATE()  from DUAL; -- 현재 날짜와 시간 확인하기
      select concat(first_name, last_name) as 'Name', employee_id, hire_date
      from employees
      where hire_date between str_to_date('1995/05/20', '%Y/%m/%d') and str_to_date('1996/05/20', '%Y/%m/%d')
      order by hire_date;



select custid as '고객아이디', count(bookid) as 도서수량
from orders
where saleprice >= 8000
group by custid
having count(bookid) >= 2;
    
    
 