
-- Lab 2.5

USE sakila;

-- 1 
##Select all the actors with the first name ‘Scarlett’.
SELECT first_name
FROM sakila.actor
WHERE first_name = 'Scarlett';

-- 2
##How many films (movies) are available for rent and how many films have been rented?
SELECT COUNT(DISTINCT inventory_id) AS rentable_films ## We interpreted it as the number of copies of movie titles available to rent.
FROM sakila.rental
;
SELECT COUNT(*)
FROM sakila.rental
WHERE rental_date IS NOT NULL AND rental_date NOT LIKE ' '; ## Copies of films that have been ever rented.

-- 3
##What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM sakila.film
HAVING min_duration = MIN(length) AND max_duration = MAX(length);

-- 4
##What's the average movie duration expressed in format (hours, minutes)?
SELECT DATE_FORMAT(SEC_TO_TIME(AVG(length)*60), '%H:%i') AS avg_duration
FROM sakila.film;

-- 5
##How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) AS lastnames_count
FROM sakila.actor;

-- 6
##Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(last_update),MIN(rental_date)) AS operation_days ## Last_update is considered the current date
FROM sakila.rental;

-- 7
##Show rental info with additional columns month and weekday. Get 20 results.
SELECT rental_date, DATE_FORMAT((rental_date), '%M') AS month
	, DATE_FORMAT((rental_date), '%W') AS weekday 
FROM sakila.rental
ORDER BY rental_date
LIMIT 20;

-- 8
##Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT rental_date, DATE_FORMAT(rental_date, '%M') AS month
	, DATE_FORMAT(rental_date, '%W') AS weekday
    , CASE
		WHEN DATE_FORMAT(rental_date, '%w') > 5 THEN 'weekend'
        ELSE 'workday' 
	END AS daytype
FROM sakila.rental;

-- 9
##Get release years.
SELECT title, release_year
FROM sakila.film
ORDER BY release_year;

-- 10
##Get all films with ARMAGEDDON in the title.
SELECT title
FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%';

-- 11
##Get all films which title ends with APOLLO.
SELECT title
FROM sakila.film
WHERE title LIKE '%APOLLO';

-- 12
##Get 10 the longest films.
SELECT title, length
FROM sakila.film
ORDER BY length DESC
LIMIT 10;

-- 13
##How many films include Behind the Scenes content?
SELECT COUNT(special_features)
FROM sakila.film
WHERE special_features LIKE '%Behind the Scenes%'