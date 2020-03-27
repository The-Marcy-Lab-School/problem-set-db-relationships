1. What percentage of films have a rental rate of $0.99?
**Answer: 34.1**
```sql
SELECT count(film_id)::DECIMAL / (SELECT count(film_id) FROM film)
* 100 FROM film WHERE rental_rate = 0.99 ;
```

2.What is the percentage breakdown of all films by rating? (Format this answer as a [table](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#tables) in Markdown)
Answer:
 
 rating | count
       
 NC-17  | 210

 R      | 195

 Pg     | 194

 G      | 178

 PG-13  | 223

 ```sql
SELECT rating, count(film_id) FROM film GROUP BY rating ;
```

3. Which actor appeared in the most films?
**Answer: Gina**
```sql
SELECT actor.actor_id,actor.first_name , actor.last_name, count(film_actor.actor_id)
FROM actor JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY count(film_actor.actor_id) DESC
LIMIT 1 ;

```
4.Which customer has the most movie rentals?
**Answer: Eleanor has 46 movies.**

```sql

SELECT customer.first_name , count(rental.rental_id)
FROM customer JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY count(rental.rental_id) DESC
LIMIT 1
;
```

5.What was the longest rental period? (Hint: See rental.rental_date and rental.return_date)
**Answer: 9 days**
```sql
 SELECT max(return_date - rental_date) FROM rental ;
```

6. What is the address of the store with the most films in their inventory?
**Answer: 28 MySQL Boulevard**
```sql
SELECT store_id , count(film_id) FROM inventory GROUP BY store_id ;
SELECT address FROM address WHERE address_id = 2 ;
```

7.Which category has the most films? How many films are in that category?
**Answer: Sports
```sql
SELECT category.name, count (film_category.film_id) AS "COUNT"
FROM film_category JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY count(film_category.film_id) DESC LIMIT 1
;

```

8.What is the address of the customer "Margaret Moore"? (Just the street address. Not the district, city, and ZIP code)
Answer: 613 Korolev Drive
```sql
SELECT customer.first_name , customer.email , address.address
FROM customer JOIN address
ON customer.address_id = address.address_id
WHERE customer.first_name = 'MARGARET'
;
```

9.There is a customer with the email "CARMEN.OWENS@sakilacustomer.org". What is the name of the city that they live in?
Answer: Caracas

```sql
SELECT customer.first_name , customer.address_id , city.city
FROM customer JOIN address
ON customer.address_id = address.address_id
JOIN city  ON city.city_id = address.city_id
WHERE customer.email = 'CARMEN.OWENS@sakilacustomer.org'
;

```

10.What country is Store #2 (store_id = 2) located in ?
**Answer: Australia**
```sql
SELECT * FROM store JOIN address
ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE store.store_id = 2;

```

11.What is the total replacement cost of each store's entire inventory? (**Hint**: Each store has multiple copies of many films that each have a replacement cost.) ?
**Answer: Store 1 : 2270 Store 2: 2311**
```sql
SELECT inventory.store_id , count(film.replacement_cost)
FROM inventory JOIN film
ON inventory.film_id = film.film_id
GROUP BY inventory.store_id ;
```




