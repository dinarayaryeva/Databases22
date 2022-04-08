--the list of movies that have not been rented yet by the clients is needed, whose rating is R or PG-13 and its category is Horror or Sci-fi 
select title
from film f
where (rating = 'R' or rating = 'PG-13') and film_id in (
	select film_id 
	from film_category fc 
	where category_id in 
		(select category_id
		from category c 
		where "name"='Horror' or "name" = 'Sci-Fi'));

--list of the stores that have made a greater number of sales in term of money during the last month recorded  in each of the cities.
	select n.store_id, total_cost, city_id
	from (select store_id, sum(replacement_cost) as total_cost
	from inventory as i join (select film_id, replacement_cost from film) as m on i.film_id = m.film_id 
	where i.inventory_id in (
		select inventory_id 
		from rental
		where rental_date between '20060116' and '20060216')
	group by store_id) as n join store s on n.store_id  = s.store_id
	join address a on s.address_id = a.address_id
	
