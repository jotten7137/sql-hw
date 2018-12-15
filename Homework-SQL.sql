USE Sakila;

#1a
SELECT first_name,last_name FROM actor; 

#1b
SELECT CONCAT(c.first_name,',',c.last_name) AS 'Actor Name' FROM actor;

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
#STILL NEEDS WORK!
SELECT CONCAT(c.first_name,',',c.last_name) 
FROM actor
WHERE(	
	SELECT 

)AS 'description' IN actor;

#3b
ALTER 'actor' DROP COLUMN 'description';

#4a
SELECT last_name
FROM actor;
SELECT COUNT(last_name)
FROM actor;

#4b





