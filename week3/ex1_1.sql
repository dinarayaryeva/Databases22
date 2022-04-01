--// Tables creation

create table catalog (
	sid int not null,
	pid int not null,
	cost decimal not null,
	primary key (sid, pid) 
);

create table parts (
	pid int primary key,
	pname text not null,
	color text not null 
);

create table suppliers (
	sid int primary key,
	sname text not null,
	address text not null  
);

insert into catalog (sid, pid, cost)
values (1, 1, 10), (1, 2, 20), (1, 3, 30), (1, 4, 40), (1, 5, 50), (2, 1, 9), (2, 3, 34), (2, 5, 48);

insert into parts (pid, pname, color)
values (1, 'Red1', 'Red'), (2, 'Red2', 'Red'), (3, 'Green1', 'Green'), (4, 'Blue1', 'Blue'), (5, 'Red3', 'Red');

insert into suppliers(sid, sname, address)
values (1, 'Yosemite Sham','Devil’s canyon, AZ'), (2, 'Wiley E. Coyote', 'RR Asylum, NV'), (3, 'Elmer Fudd', 'Carrot Patch, MN');

--//1 Find the names of suppliers who supply some red part
select distinct sname
from suppliers s, "catalog" c, parts p 
where c.sid = s.sid and p.pid = c.pid and p.color = 'Red';
--//2 Find the sids of suppliers who supply some red or green part
select distinct sid
from "catalog" c, parts p 
where p.pid = c.pid and (p.color = 'Red' or p.color = 'Green');
--//3 Find the sids of suppliers who supply some red part or are at 221 Packer Street
select distinct c.sid
from suppliers s, "catalog" c, parts p 
where c.sid = s.sid and p.pid = c.pid and p.color = 'Red' and s.address like '%221 Packer Street%';
--//4 Find the sids of suppliers who supply every red or green part. 
SELECT distinct sid 
FROM "catalog" c 
WHERE sid not in ( 
SELECT sid 
FROM (
(SELECT sid , pid 
FROM (select pid from parts where color = 'Red' or color = 'Green' ) as p cross join 
(select distinct sid from catalog) as sp)
EXCEPT
(SELECT sid , pid FROM "catalog") ) AS r );
--//5 Find the sids of suppliers who supply every red part or supply every green part. 
SELECT distinct sid 
FROM "catalog" c 
WHERE sid not in ( 
SELECT sid 
FROM (
(SELECT sid , pid 
FROM (select pid from parts where color = 'Red' ) as p cross join 
(select distinct sid from catalog) as sp)
EXCEPT
(SELECT sid , pid FROM "catalog") ) AS r )
union 
SELECT distinct sid 
FROM "catalog" c 
WHERE sid not in ( 
SELECT sid 
FROM (
(SELECT sid , pid 
FROM (select pid from parts where color = 'Green' ) as p cross join 
(select distinct sid from catalog) as sp)
EXCEPT
(SELECT sid , pid FROM "catalog") ) AS r );
--//6 Find pairs of sids such that the supplier with the first sid charges more for some part than the supplier with the second sid. 
select c1.sid, c2.sid
from "catalog" c1, "catalog" c2
where c1.pid = c2.pid and c1."cost" > c2."cost";
--//7 Find the pids of parts supplied by at least two different suppliers.
select s.pid
from (
	select pid, count(pid) as cnt
	from "catalog" c
	group by pid) as s
where s.cnt > 1;
--//8 Find the average cost of the red parts and green parts for each of the suppliers
select s.sid, s."avg"
from (
	select ss.sid, avg(ss."cost")
	from (
		select c.sid, c."cost"
		from "catalog" c, parts p
		where p.pid = c.pid and p.color = 'Red') as ss
	group by sid) as s;
--//9 Find the sids of suppliers whose most expensive part costs $50 or more
select s.sid
from (
	select sid, max("cost") as "max"
	from "catalog" c
	group by sid) as s
where s."max" > 49;

