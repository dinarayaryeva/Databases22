CREATE FUNCTION my_function()
 RETURNS table(id integer, address varchar(50)) as
$$

BEGIN
    RETURN QUERY 
    SELECT a.address_id, a.address 
    from address a 
    where a.address like '%11%' and a.city_id between 400 and 600;
end;

$$

LANGUAGE plpgsql;

