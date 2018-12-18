USE Sakila;

#1a
SELECT first_name,last_name FROM actor; 

#1b
SELECT UPPER(CONCAT(c.first_name,',',c.last_name)) as 'Actor Name' FROM actor;

#2a
SELECT actor_id,first_name,last_name 
FROM actor 
WHERE first_name LIKE "Joe%"; 

#2b
SELECT first_name,last_name 
FROM actor
WHERE last_name LIKE "%GEN%";

#2c
SELECT first_name,last_name 
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name,first_name;

#2d
SELECT country_id,country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

#3a
ALTER TABLE actor
ADD COLUMN description BLOB;

#3b
ALTER TABLE actor
DROP COLUMN description;

#4a
SELECT last_name, COUNT(*) as 'Number of Actors'
FROM actor
GROUP BY last_name;


#4b
SELECT last_name, COUNT(*) as 'Number of Actors'
FROM actor
GROUP BY last_name
WITH COUNT(*) >=2;

#4c
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' and last_name = 'WILLIAMS';

#4d
UPDATE actor
SET first_name = 'Groucho'
Where frist_name = 'HARPO' and last_name = 'WILLIAMS';

#5a
DESCRIBE sakila.address;

#6a
SELECT first_name, last_name, address
FROM staff
JOIN address
ON staff.address_id = address.address_id;

#6b
SELECT payment.staff_id, staff.first_name, staff.last_name, payment.amount, payment.payment_date
FROM staff 
INNER JOIN payment 
ON staff.staff_id = payment.staff_id 
AND payment_date LIKE '2005-08%';

#6c
SELECT f.title as 'FILM TITLE', COUNT(fa.actor_id) as 'Number of Actors'
FROM film_actor as fa
INNER JOIN film as f
ON fa.film_id = f.film_id
GROUP BY f.title;

#6d
SELECT title, (
	SELECT COUNT(*) FROM inventory
	WHERE film.film_id = inventory.film_id
				) as 'NUMBER OF COPIES'
FROM film
WHERE title = 'Hunchback Impossible';

#6e
SELECT c.first_name, c.last_name, sum(p.amount) as 'Total Paid'
FROM customer c
JOIN payment p
on c.customer_id = p.customer_id
GROUP BY c.last_name;

#7a
SELECT title 
FROM film 
WHERE title
LIKE 'K%' OR title Like 'Q%'
AND TITLE IN 
(
	SELECT title
	FROM film
	WHERE language_id = 1);
    
#7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
	SELECT actor_id
    FROM film_actor
    WHERE film_id IN
    (
		SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
        ));

#7c
SELECT cust.first_name, cust.last_name, cust.email
FROM customer as cust
JOIN address as a
ON (cust.address_id = a.address_id)
JOIN city as city
ON (city.city_id = a.city_id)
JOIN country as ctry
ON (ctry.country_id = city.country_id)
WHERE ctry.country = 'CANADA';

#7d
SELECT title, description 
FROM film
WHERE film_id IN
(
	SELECT film_id FROM film_category
    WHERE category_id IN
    (
		SELECT category_id FROM category
        WHERE name = 'Family'
        ));

#7e
SELECT f.title, COUNT(rental_id) as 'Times Rented'
FROM rental as rent
JOIN inventory as i
ON (rent.inventory_id = i.inventory_id)
JOIN film as f
ON (i.film_id = f.film_id)
GROUP BY f.title
ORDER BY 'Times Rented' DESC;

#7f
SELECT s.store_id, SUM(amount) as 'Revenue'
FROM payment as p
JOIN rental as r
ON (p.rental_id = r.rental_id)
JOIN inventory as i
ON (i.inventory_id = r.inventory_id)
JOIN store as s
ON (s.store_id = i.store_id)
GROUP BY s.store_id;

#7g
SELECT s.store_id, city.city, country.country
FROM store as s
JOIN address as a 
ON (s.address_id = a.address_id)
JOIN city as cty
ON (cty.city_id = a.city_id)
JOIN country as ctry
ON (ctry.country_id = cty.country_id);

#7h
SELECT c.name AS 'Genre', SUM(p.amount) AS 'Gross'
FROM category as c
JOIN film_category as fc
ON (c.category_id = fc.category_id)
JOIN inventory as i
ON (fc.film_id = i.film_id)
JOIN rental as r
ON (i.inventory_id = r.inventory_id)
JOIN payment as p
ON (r.rental_id = p.rental_id)
GROUP BY c.name ORDER BY Gross LIMIT 5;

#8a
CREATE VIEW top_five_revenue as
SELECT c.name as 'Genre', SUM(p.amount) as 'Gross'
FROM category as cat
JOIN film_category as fc
ON (cat.category_id = fc.category_id)
JOIN inventory as i
ON (fc.film_id = i.film_id)
JOIN rental as r
ON (i.inventory_id = r.inventory_id)
JOIN payment as p
ON (r.rental_id = p.rental_id)
GROUP BY c.name ORDER BY Gross LIMIT 5;

#8b
SELECT * FROM top_five_revenue;

#8c
DROP VIEW top_five_revenue;


