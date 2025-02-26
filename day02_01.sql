select *
from book
where price < 20000;

select *
from book
where price between 10000 and 20000;
-- between을 더 권장
select *
from book
where price >= 10000 and price <= 20000;

-- not in 은 포함하지 않는 , or이랑 비슷 
select *
from book
where publisher in('굿스포츠', '대한미디어');

select bookname, publisher
from book
where bookname like '축구의 역사';

select bookname, publisher
from book 
where bookname like '축구%';

desc book;

select *
from book
where bookname like '_구%';

select * 
from book
where bookname like '%축구%' and price >= 20000;

select * 
from book
where publisher in('굿스포츠','대한미디어');

select *
from book
order by price ;

select *
from book
order by price, bookname;

select *
from book
order by price desc, publisher, bookname;

