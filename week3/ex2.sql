--//Tables creation
create table author(
author_id int primary key,
first_name text not null,
last_name text not null
);

create table pub(
pub_id int primary key,
title text not null,
book_id text not null
);

create table book(
book_id text primary key,
book_title text not null,
"month" text not null,
"year" int not null,
editor int
);

create table author_pub(
author_id int not null,
pub_id int not null,
author_position int not null,
primary key(author_id, pub_id)
);

insert into author (author_id, first_name, last_name)
values (1, 'John', 'McCarthy'), (2, 'Dennis', 'Ritchie'), (3, 'Ken', 'Thompson'), (4, 'Claude', 'Shannon'),
(5, 'Alan', 'Turing'), (6, 'Alonzo', 'Church'), (7, 'Perry', 'White'), (8, 'Moshe', 'Vardi'), (9, 'Roy', 'Batty');

insert into book (book_id, book_title, "month", "year", editor) 
values (1 ,'CACM', 'April', 1960, 8), (2, 'CACM', 'July', 1974, 8),(3, 'BTS', 'July', 1948, 2),
(4, 'MLS', 'November', 1936, 7), (5, 'Mind', 'October', 1950, null), (6, 'AMS', 'Month', 1941, null),
(7, 'AAAI', 'July', 2012, 9), (8, 'NIPS', 'July', 2012, 9);

insert into pub (pub_id, title, book_id) 
values (1, 'LISP', 1), (2, 'Unix', 2), (3, 'Info Theory', 3), (4, 'Turing Machines', 4),
(5, 'Turing Test', 5), (6, 'Lambda Calculus', 6);

insert into author_pub (author_id, pub_id, author_position)
values (1, 1, 1), (2, 2, 1), (3, 2, 2), (4, 3, 1), (5, 4, 1), (5, 5, 1), (6, 6, 1);

--// 1
select *
from author a, book b 
where author_id = editor;
--// 2
select k.first_name, k.last_name
from (((select author_id  from author)
	except (select editor from book)) as v join author a1 on v.author_id = a1.author_id) as k;
--// 3
select *
from ((select author_id from author) except (select editor from book)) as c;
