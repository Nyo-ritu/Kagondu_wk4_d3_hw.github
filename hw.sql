-- q1. All the customers who live in texas.
--Ans = 5 customers; Jenn Davis, Kim Cruz, Richard Mccrary, Bryan Hardison and Ian Still

SELECT first_name, last_name, district
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--q2. All payments above 6.99 with customers full name.
--Ans = 1406 records of payments above 6.99.

SELECT first_name, last_name, amount
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

--q3. customer names who've made payments above $175 using subqueries.
--Ans = 6 people; Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, Tommy Collazo and Karl Seal.
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

--q4. List all the customers who live in Nepal (use the city table)
--Ans Kevin Schuler ives in Nepal.

SELECT first_name, last_name, country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

--q5. Which staff member has the most transactions
--Mike Hillyer has the most transactions

SELECT staff_id, COUNT(rental_id)
FROM rental
GROUP BY staff_id
ORDER BY COUNT(rental_id) DESC;


--q6. How many movies of each rating are there?
-- Ans 195 R, 210 NC -17, 178 G, 194 PG, 223 PG-13

SELECT rating, COUNT(title)
FROM film
GROUP BY rating;

--q7. All customers who made a single payment above 6.99
-- ANS = 686 customers made only a single payment above 6.99

SELECT first_name, last_name, amount
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY first_name, last_name, amount
HAVING COUNT(amount) = 1 AND amount > 6.99;

--q8. How many free rentals did our store give away
--store gave away free rentals 24 times 

SELECT COUNT(amount)
FROM payment
WHERE amount = 0
