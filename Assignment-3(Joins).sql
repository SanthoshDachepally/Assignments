Use sakila;
#1. List all customers along with the films they have rented.
select cr_inv.customer_id, cr_inv.first_name, cr_inv.last_name, f.title, cr_inv.inventory_id, cr_inv.film_id from (select cr.customer_id, cr.first_name, cr.last_name, cr.inventory_id, i.film_id from 
(select c.customer_id, c.first_name, c.last_name, r.inventory_id from customer c join rental r on c.customer_id = r.customer_id ) 
as cr join inventory i on cr.inventory_id = i.inventory_id) as cr_inv join film f on cr_inv.film_id = f.film_id;

#2. List all customers and show their rental count, including those who haven't rented any films.
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as rental_acount from customer c left join rental r on c.customer_id = r.customer_id group by c.customer_id, c.first_name, c.last_name;

#3. Show all films along with their category. Include films that don't have a category assigned.

select film_cn. film_id, film_cn.title, c.name from
(select f.film_id, f.title, fc.category_id from film f left join film_category fc on f.film_id = fc.film_id) 
as film_cn left join category c on film_cn.category_id = c.category_id ;

#4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).

SELECT  c.first_name AS customer_first_name, c.last_name AS customer_last_name, c.email AS customer_email, s.first_name AS staff_first_name, s.last_name AS staff_last_name, s.email AS staff_email FROM customer AS c LEFT JOIN staff AS s ON c.email = s.email
UNION
SELECT c.first_name, c.last_name, c.email, s.first_name, s.last_name, s.email FROM customer AS c
RIGHT JOIN staff AS s ON c.email = s.email;

#5. Find all actors who acted in the film "ACADEMY DINOSAUR".

select fa_id.title, a.first_name, a.last_name from (select f.film_id, f.title, fa.actor_id from film f join film_actor fa on f.film_id = fa.film_id) as fa_id
join
actor a on fa_id.actor_id = a.actor_id where fa_id.title = "ACADEMY DINOSAUR";

#6. List all stores and the total number of staff members working in each store, even if a store has no staff.

select store_count.store_id, count(store_count.staff_id) as no_of_staff from
(select s.store_id, sf.staff_id from store s left join staff sf on s.store_id = sf.store_id) as store_count
group by store_count.store_id;

#7. List the customers who have rented films more than 5 times. Include their name and total rental count.

select c.customer_id, c.first_name, c.last_name, count(*) as rental_count from customer c join rental r on c.customer_id = r.customer_id group by c.customer_id, c.first_name, c.last_name having count(*) > 5;