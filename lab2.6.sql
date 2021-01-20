-- Lab 2.6
show databases;
use sakila;
show tables;

-- 1 Get release years.
select distinct release_year from film;

-- 2 Get all films with ARMAGEDDON in the title.
select title from film
where title like '%ARMAGEDDON%';

-- 3 Get all films which title ends with APOLLO.
select title from film
where title like '%APOLLO';

-- 4 Get 10 the longest films.
select title, length from film
order by length desc
limit 10;

-- 5 How many films include Behind the Scenes content?
select count(*) as 'behind_the_scenes_content' from film
where special_features like '%Behind the Scenes%';

-- 6 Drop column picture from staff.
select * from staff limit 3;
alter table staff drop column picture;
select * from staff limit 3;

-- 7 A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from customer
where first_name = 'TAMMY' and last_name = 'SANDERS';
select * from staff limit 3;
insert into staff(staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
values(3, 'Tammy', 'Sanders', 5, 'Tammy.Sanders@sakilastaff.com', 2, 1, 'Tammy', 'password123', '2021-01-20 20:48:39');
select * from staff limit 3;

-- 8 Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.

select * from rental
order by rental_id desc
limit 3;

select * from staff
where first_name = 'MIKE' and last_name = 'HILLYER';

select film_id from film where title = 'ACADEMY DINOSAUR';

select * from inventory
where film_id = 1;

insert into rental(rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
values(16050, '2021-01-20 16:57:22', 1, 130, NULL, 1, '2021-01-20 21:43:28');

select* from rental
where rental_id = 16050;

-- 9 Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
        -- Check if there are any non-active users
        -- Create a table backup table as suggested
        -- Insert the non active users in the table backup table
        -- Delete the non active users from the table customer

select distinct active from customer;
select * from customer
where active = 0;

drop table if exists deleted_users;

create table deleted_users (
	customer_id int unique not null,
    first_name varchar(45),
    last_name varchar(45),
    email varchar(50),
    deletion_date datetime
    );

insert into deleted_users
select customer_id, first_name, last_name, email, '2021-01-20 22:12:41'
from customer 
where active = 0;

delete from customer
where active = 0;

select * from customer
where active = 0;