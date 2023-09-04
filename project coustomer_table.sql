create database customerDetails

create table orderDetails
(
customer_id int not null,
customer_name varchar(10) not null,
region varchar(10) not null,
orderAmound int not null
)

insert into orderDetails values
(1,'ann','north',200),
(2,'bob','south', 400),
(3,'alice','south',200),
(4,'jane','south',500),
(5,'mike','north',700)

select top 3 customer_id, sum(orderAmound) as total_order_amount 
from orderDetails 
group by customer_id
order by  total_order_amount desc

