use sakila;
#1. display all customer details who have made more than 5 payments.
select * from payment;
select * from customer;
select * from customer where customer_id in 
(select customer_id from payment group by customer_id having count(*) > 5);

#2.Find the names of actors who have acted in more than 10 films.

select actor_id, first_name, last_name from actor where actor_id in
(select actor_id from film_actor group by actor_id having count(*) > 10);

#3. Find the names of customers who never made a payment.

select customer_id, first_name, last_name from customer where customer_id not in 
(select customer_id from payment);

#4. List all films whose rental rate is higher than the average rental rate of all films.

select film_id, title from film where rental_rate > 
(select avg(rental_rate) from film);

#5. List the titles of films that were never rented.

select title from film where film_id not in 
(select film_id from inventory where inventory_id in
(select inventory_id from rental));

#6. Display the customers who rented films in the same month as customer with ID 5.

select first_name, last_name from customer where customer_id in
(select customer_id from rental where Month(rental_date) in 
(select Month(rental_date) from rental where customer_id = 5));


#7. Find all staff members who handled a payment greater than the average payment amount.

select first_name, last_name from staff where staff_id in
(select staff_id from payment where amount > 
(select avg(amount) from payment));

#8. Show the title and rental duration of films whose rental duration is greater than the average.

select title, rental_duration from film where rental_duration >
(select avg(rental_duration) from film);

#9. Find all customers who have the same address as customer with ID 1.

select customer_id, first_name, last_name from customer where address_id in
(select address_id from customer where customer_id = 1);

#10. List all payments that are greater than the average of all payments.

select * from payment where amount >
(select avg(amount) from payment);