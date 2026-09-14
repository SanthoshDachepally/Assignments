use sakila;

#1. Get all customers whose first name starts with 'J' and who are active.
select * from customer;
select * from customer where first_name like 'J%' and active = 1;

#2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.
select * from film;
select * from film where title like '%ACTION%' or description like '%WAR%';

#3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
select * from customer where last_name !='SMITH' and first_name like '%a';

#4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
select * from film where rental_rate > 3.0 and replacement_cost != 'null';
#5. Count how many customers exist in each store who have active status = 1.
select store_id, count(*) as num_of_customers from customer where active = 1 group by store_id;

#6. Show distinct film ratings available in the film table.
select distinct(rating) from film;

#7. Find the number of films for each rental duration where the average length is more than 100 minutes.
select count(*) as lengthy_film_count from film where length > 100;

#8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
select * from payment;
select date(payment_date) as date, sum(amount) as total_amount from payment group by date(payment_date) having count(*) > 100;

#9. Find customers whose email address is null or ends with '.org'.
select * from customer where email = null or email like '%.org';

#10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
select * from film where rating = 'PG' or rating = 'G' order by rental_rate desc;

#11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
select length, count(*) as count from film where title like 'T%' group by length having count(*) > 5;

#12. List all actors who have appeared in more than 10 films.
select * from film_actor;

#13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
select * from film order by rental_rate desc,length desc limit 5;

#14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
select * from rental;
select customer_id, count(*) as num_of_rentals from rental group by customer_id order by count(*) desc;

#15. List the film titles that have never been rented.
select title from film where rental_duration = 0 or null;

#Builtin Functions

#1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
select store_id, first_name, last_name, email, address_id, active, count(*)as num_of_duplicates from customer 
group by store_id, first_name, last_name, email, address_id, active having count(*) > 1;

#2. Number of times letter 'a' is repeated in film descriptions
select sum(length(description) - length(replace(lower(description),'a', ''))) as a_count from film;

#3. Number of times each vowel is repeated in film descriptions 
select sum(length(description) - length(replace(lower(description),'a', ''))) as a_count,
sum(length(description) - length(replace(lower(description),'e', ''))) as e_count,
sum(length(description) - length(replace(lower(description),'i', ''))) as i_count,
sum(length(description) - length(replace(lower(description),'o', ''))) as o_count,
sum(length(description) - length(replace(lower(description),'u', ''))) as u_count 
from film;

#4. Display the payments made by each customer
        #1. Month wise
        #2. Year wise
        #3. Week wise
select customer_id, year(payment_date) as year,month(payment_date) as month, sum(amount) from payment group by customer_id, year(payment_date), month(payment_date);
select customer_id, year(payment_date) as year, sum(amount) from payment group by customer_id, year(payment_date);
select customer_id, year(payment_date) as year,week(payment_date) as week, sum(amount) from payment group by customer_id, year(payment_date), week(payment_date);

#5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date
select 
	case 
		when MOD(2024,400) = 0 or MOD(2024,4) = 0 and MOD(2024,100) !=0 then 'Leap Year' else 'Not a Leap Year'
    end as result;

select 
	case
		when day(last_day('2024-02-14')) = 29 then 'Leap year' else 'Not a Leap Year'
	end as result;
    
#6. Display number of days remaining in the current year from today.

select 
		datediff(
				concat(year(curdate()), '-12-31'), 
                curdate()
                    ) + 1 as remaining_days;

#7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.

select payment_date, concat('Q', quarter(payment_date)) from payment;