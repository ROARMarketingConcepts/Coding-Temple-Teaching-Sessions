--1.  Fetch the first 10 rows of the actor table.

select * 
from actor
limit 10

--2. List all actors whose last name begins with 'B".

select *
from actor
where last_name like 'B%'

--3. List all actors whose first_name is 'John' or last_name is 'Bailey'.

select *
from actor
where first_name='John' or last_name='Bailey'

--4. List all films released in the years 2005-2007

select  *
from film
where release_year between 2005 and 2007

--5. List all customers who do not have an e-mail address.

select *
from customer
where email is null

-- 6. Get a count of the total number of films in the database.

select count(*) as num_films
from film

-- 7. Get a count of films by rating.

select 
	rating,
	count(*) as num_films
from film
group by rating

-- 8. Show the ratings that have a 200 or more film count.

select 
	rating,
	count(*) as num_films
from film
group by rating
having num_films >=200

-- 9. Find the average film length by rating.

select 
	rating,
	avg(length) as avg_length
from film
group by rating
order by avg_length desc

--10. Show all films with their category information.

select 
	f.film_id,
	f.title,
	c.Name as category_name
from film f
join film_category fc
on f.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id

--11. List all actors and a count of the the films in which they have starred. Include those actors who have not starred in a film as well.

select 
	a.first_name,
	a.last_name,
	count(f.film_id) as num_films
from actor a
left join film_actor fa
on a.actor_id=fa.actor_id
left join film f
on f.film_id=fa.film_id
group by a.first_name,a.last_name
order by num_films desc

-- 12. Get a list of films whose length is longer than the average film length for the database.

SELECT
	title,
	length
from film
where length >= (select avg(length) from film)
order by length desc

-- 13.  What are the Top 5 most rented films?

with rentals as (

select 
	f.title,
	count(r.rental_id) as num_rentals
from rental r
join inventory i
on r.inventory_id=i.inventory_id
join film f
on i.film_id=f.film_id
group by f.title
order by num_rentals desc
)

select title
from rentals
limit 5

