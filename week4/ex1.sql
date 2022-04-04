--Table creation
create table customer(
customerId int primary key,
customerName text not null,
city text not null
);


create table "order"(
orderId int primary key,
"date" date not null,
customerId int not null,
constraint custom_fk foreign key(customerId) references customer(customerId)
);

create table item(
itemId int primary key,
itemName text not null,
price numeric not null
);

create table order_list(
orderId int not null,
itemId int not null,
quant int not null,
primary key(orderId, itemId),
constraint item_fk foreign key(itemId) references item(itemId),
constraint order_fk foreign key(orderId) references "order"(orderId)
);

insert into customer(customerId, customerName,city)
values (101, 'Martin', 'Prague'), (107, 'Herman', 'Madrid'), (110, 'Pedro', 'Moscow');

insert into "order"(orderId, "date", customerId)
values (2301, '2011-02-23', 101), (2302, '2011-02-25', 107), (2303, '2011-02-27', 110);

insert into item(itemId, itemName, price)
values (3786, 'Net' ,35.00), (4011, 'Racket', 65.00), (9132, 'Pack-3', 4.75), 
(5794, 'Pack-6', 5.00), (3141, 'Cover', 10.00);

insert into order_list(orderId, itemId, quant)
values (2301, 3786, 3), (2301, 4011, 6), (2301, 9132, 8), 
(2302, 5794, 4), (2303, 4011, 2), (2303, 3141, 2);
-- query one
select orderId, sum(ol.quant) as total_num, sum(ol.quant*i.price) as total_price
from order_list ol, item i 
where ol.itemid = i.itemid
group by orderId;
-- query two
select a.customerid
from (
select o.customerid as customerid, sum(ol.quant*i.price) as total_price
from order_list ol, item i, "order" o 
where ol.itemid = i.itemid and ol.orderid = o.orderid
group by o.customerid
order by total_price desc) as a
limit 1;