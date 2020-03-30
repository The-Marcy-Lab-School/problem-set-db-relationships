1. Percentage Answer: 34% of the films are at a .99 rental rate.
`SELECT count(film.rental_rate) / 10 AS "% of  0.99 Rental Films"
FROM film
WHERE film.rental_rate = 0.99`
Total number of films with a rental rate of .99:
`SELECT count(film.rental_rate) AS "% of  0.99 Rental Films" FROM film            
WHERE film.rental_rate = .99;`

2. Percentage answer:
`SELECT film_list.rating AS "Rating", count(fid)/10 AS "%"
FROM film_list
GROUP BY film_list.rating;`

|Rating | % |
|-------|---:|
|G      | 17|
|NC-17  | 21|
|R      | 19|
|PG     | 19|
|PG-13  | 22|

Breakdown:
`SELECT film_list.rating AS "Rating", count(fid) AS "Breakdown"
FROM film_list
GROUP BY film_list.rating;`
|Rating | Breakdown|
|--------+-----------|
|G      |       177|
|NC-17  |       210|
|R      |       193|
|PG     |       194|
|PG-13  |       223|

3. Gina Degeneres
`SELECT actor.actor_id, actor.first_name AS "First Name", actor.last_name AS "Last Name", count(film_actor.actor_id)
FROM actor JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY count(film_actor.actor_id) DESC
LIMIT 1;`

4. Eleanor Hunt
`SELECT customer.first_name AS "First Name", customer.last_name AS "Last Name", count(rental.customer_id)
FROM rental
JOIN customer ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY count(customer.customer_id) DESC
LIMIT 1;`

5. 9 days
`SELECT MAX(rental.return_date - rental.rental_date)
FROM rental;`

6. 28 MySQL Boulevard, Inventory total 2,311
`SELECT address.address AS "Store Address", count(inventory.store_id) as "Films in Inventory"
FROM store
JOIN inventory ON store.store_id = inventory.store_id
JOIN address ON address.address_id = store.address_id
GROUP BY address.address_id
ORDER BY count(inventory.store_id) DESC
LIMIT 1;`

7. Sports, 74 films
`SELECT category.name AS "Category", count(film_category.film_id) AS "# of Films"
FROM film_category
JOIN category ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY count(film_category.film_id) DESC
LIMIT 1;`

8. 613 Korolev Drive
`SELECT customer.first_name AS "First Name", customer.last_name AS "Last Name", address.address AS "Address"
FROM customer
JOIN address ON address.address_id = customer.address_id
WHERE customer.last_name = 'MOORE';`

9. Caracas
`SELECT city.city AS "City", customer.email
FROM customer
JOIN address ON address.address_id = customer.address_id
JOIN city ON city.city_id = address.city_id
WHERE customer.email = 'CARMEN.OWENS@sakilacustomer.org'`;

10. Australia
`SELECT store.store_id AS "Store #", country.country AS "Country"
FROM store
JOIN address ON address.address_id = store.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE store.store_id = 2;`

11.
|Replacement Cost for Each Store | Store # |
|---------------------------------+---------|
|                       46205.30 |       1|
|                       46415.89 |       2|
`SELECT sum(film.replacement_cost) AS "Replacement Cost for Each Store", inventory.store_id AS "Store #"
FROM inventory
JOIN film ON film.film_id = inventory.film_id
GROUP BY inventory.store_id;`
