explain analyze
select id
from customer c
where c.address < '12343';

explain analyze
select "name"
from customer c
where id > 10 and id < 100;

explain analyze
select *
from customer c
where "name" = 'Chad Welch';

--create index name_index on customer ("name");

--create index id_index on customer using btree (id);

--create index address_index on customer using btree (address);