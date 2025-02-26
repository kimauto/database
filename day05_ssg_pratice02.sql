create table salesperson(
	name varchar(10) primary key,
    age integer not null,
    salary integer not null
);
drop table orders;
desc orders;
select * from orders;
create table orders(
	number integer auto_increment primary key,
    custname varchar(10),
    salesperson varchar(10),
    amount integer not null
);

alter table orders add constraint fk_orders_customer foreign key(custname) references customer(name);
alter table orders add constraint fk_orders_saleperson foreign key(salesperson) references salesperson(name);


create table customer(
	name varchar(10) primary key,
    city varchar(10),
    industrytype varchar(10)
);

insert into salesperson values("김병곤", 28, 10000);
insert into salesperson values("김두킴", 26, 30000);
insert into salesperson values("지렁이", 22, 4000);
insert into customer values("고객1", 'LA', '전자');
insert into customer values("고객2", 'LAS', 'LG');
insert into orders values(null,"고객1","김병곤", 10000);
insert into orders values(null,"고객2","김두킴", 100001);

-- 2
select distinct name, salary
from salesperson;

-- 3
select name 
from salesperson
where age < 30;

-- 4
select name
from customer
where city like "%s";

-- 5
select count(number)
from orders;

-- 6
select count(salesperson) as '주문 수'
from orders ;

-- 7
 select name, age
 from salesperson s
 where name in
(	select salesperson
	from orders	
	where  salesperson is not null and custname in(
	select name 
	from customer 
	where city = 'LA'));

select * from salesperson;
select * from orders;
select * from customer;

-- 8 
select s.name, s.age
from orders o, salesperson s, customer c
where o.custname = s.name and o.custname = c.name and c.city = 'LA';

-- 9
 
 select name
from salesperson
where name in (
select salesperson
from orders
group by salesperson
having count(salesperson) > 1
) ;

-- 10 






