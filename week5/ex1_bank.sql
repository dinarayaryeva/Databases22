create table account(
id int primary key,
"name" text,
credit int,
currency text
);

insert into account
values (1, 'A', 1000, 'RUB'), (2, 'B', 1000, 'RUB'), (3, 'C', 1000, 'RUB');

CREATE or replace procedure fun( id_from int, id_to int, value int)
LANGUAGE plpgsql as
$$
declare "from" int;
declare "to" int;
declare new_from int;
declare new_to int;

begin

select a.credit into "from" from account a where a.id = id_from;
select a.credit into "to" from account a where a.id = id_to;

update account set credit = "to" + value where id = id_to;
update account set credit = "from" - value where id = id_from;

select a.credit into new_from from account a where a.id = id_from;
select a.credit into new_to from account a where a.id = id_to;

raise notice 'credit of % now is % but was %', id_from, new_from, "from" ;
raise notice 'credit of % now is % but was %', id_to,  new_to, "to" ;

end;
$$;

begin;
call fun(1, 3, 500);
call fun(2, 1, 700);
call fun(2, 3, 100);
rollback;

