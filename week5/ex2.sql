CREATE FUNCTION retrieve_customers(start_ int, end_ int)
 RETURNS TABLE(id integer) as 
 $$
 
begin
	
    if start_ < 0 or end_ < 0 then
       RAISE EXCEPTION 'Negative value';
      end if;
   
   
    if end_ > 600 then
       RAISE EXCEPTION 'Out of boundaries';
    end if;


    RETURN QUERY 
    SELECT c.customer_id  
    from customer c 
   	order by c.address_id
   	offset start_ - 1
   	limit end_ - start_ + 1;

end;

$$

LANGUAGE plpgsql;

select retrieve_customers(4,10);
select retrieve_customers(-4,10);
select retrieve_customers(4,1000);

