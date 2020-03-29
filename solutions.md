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
**Answer: Sports**
```sql
SELECT category.name, count (film_category.film_id) AS "COUNT"
FROM film_category JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY count(film_category.film_id) DESC LIMIT 1
;

```

8.What is the address of the customer "Margaret Moore"? (Just the street address. Not the district, city, and ZIP code)
**Answer: 613 Korolev Drive**
```sql
SELECT customer.first_name , customer.email , address.address
FROM customer JOIN address
ON customer.address_id = address.address_id
WHERE customer.first_name = 'MARGARET'
;
```

9.There is a customer with the email "CARMEN.OWENS@sakilacustomer.org". What is the name of the city that they live in?
**Answer: Caracas**

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

[pagila ERD](https://app.diagrams.net?lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=pagila-ERD#R7V1dc9o4FP01vOxMOrYl2%2FAYSLLb2XS3k%2Bxs26eMigWoNRZrRID%2B%2BpWMBLYExMWAPB21mYl1bcuS7tH9OJKdDhhMV7%2FnaDb5QBOcdgIvWXXAXScI%2FF7Y5b%2BEZC0lIYAbyTgnyUbm7QTP5AeWFyrpgiR4LmUbEaM0ZWRWFQ5pluEhq8hQntNl9bIRTZOKYIbG2BA8D1FqSj%2BRhE020m7o7eR%2FYDKeqCf7njwzRepiKZhPUEKXJRG474BBTinbHE1XA5yK0auOy8OBs9uG5ThjdW7499t%2FS%2FLtz9eYvvQ%2FfYq78C%2F05UbW8orShezww%2Ft02gmilNfZ%2F5rzo7E4uh0ympviAWJ4TPO1eeYRZeOFGFvjzPvslbd4701P%2FARKTfkzQ6PRPjHN9zxgsJgzOsV7mvtA0ukL2t%2BV4txw259CY2ytYMDwSlw0YdOUC3x%2BOGc5%2FY4HNOWVgbuMZvzK%2FoikqSZCKRlnvDjkfeNtAv1XnDPCAXYrT0xJkojH9JcTwvDzDA3FM5d8PnFZThdZgoUGPV6SyuIV4NVBFPhbbPFZiflAMNEfT95ww6fg5p7lDs58nm5kkzKUQSynkZxC421lO5TxAwm0nwBdCA3UGQOOEz4NZZF3jbD1E04RIzS7353pj2jGpM3wg6p%2BcJbcivnPi%2FdPU5StC52hnBlSXn2%2B%2FiyHuCh8EYV3oSrercon79YVbYiGHtcF7xdd5EN8ZESAtGwoH2N25DoY7lduWZfKAFV0qYR5MYiv1RbvU7B8xkdKeF%2B26AkUUJQ5j7vVKjY9lXeVjZFWEdAq0uvZjIRRTwG3bb8bIDD8JRCIV4R9Vk%2Fjx6W7eGl3kyhcALUQ1oRt1y5qwy7QUAtPQ20UafBXtvRKsI2ubji5D%2FuHfmiNnawLuENO8Gp20vMrQOGQOw1xvW6lHqDizmsB7up2sgy4czrYqC5yvI5V5MA4qGo8Ck5DTtjrVSvqaRC8NHQiq7bKrmesDTcQ2IabZmCgZmDqwi2Oq64R%2Ble2VPGvYqnimtCBli1V1PWqGocn%2BrhQM3lbp3cl6EBgQKdMFGggmi%2FJNEXZFinyjDAgwwlJk0e0pgsx1DzUH35Xpf6E5uQHLegNxR%2FwTEDiLIg07qATAOyJ%2F5U7n0WN8lk5nvN7PyqA%2BZroA1pVLnxEc6ZaSdMUzebka9FuceOUjy%2FJ%2BpQxOpUXqV4%2BVBs1Kv7tYzXKswaeh6oIYDVsD%2FcQF9EegOu55Nl4C2iG3wVGXkjym4ETyRjVpYnmMzQk2fgRj0Qv4E7yJDsmRJSP5ygt7M%2BEJAnOCoaIIYa%2BbkE4E9Ok6HnY5z98fAbC8YW8TQNe9ndl%2FiMuz9mAZryZiBRqwRwpSyzQYljCWjo9MsVMTasZH9XTrLru%2FJo149yRMAFOsc0UGwaWFatciyN6msQkUa9mTGKZntzWs02eTiR69NzJ05KwC0ck8dV5nrYT5H5d5mcDVZtcYzUoDk7Mp7o6DaC15MII9M2FwcGhtTEXEV8rIr4BYZVX9OOaMbHvwcNIbuRhfdPDqlVUFz69FT75B%2FTdlrjYN1PjDE2xU2oDpVqPiX0zukj5OLwsZgmfuE63DXSrqAd7%2BY5V1v2MAV9YM97zI7vx3nYJWJnssHdawOdrdCqIr0ugK%2BheNedI%2Ft7YDCPtkCea5sveu163nDPfeO98Lz6aNovCR5wTPp4ijDt3IhPUBTa0vISth5pRpNmsusCGWkWhXtGlgd1rI7BPIHRakIbXRu9ml69F9CrmR6H31I1qMKgm9GHvumZZ8QBtoYLsEpGq829v47CMv65fNXpApck%2Fva6uVQT1ii6MP2ASQXI3tmOBLLFAYU9zqFCW7ZFAwLRSc4ESxwC9lVCCljNAwGSARiSfsxfHAzVUrXUeCBzggZxmG2rWOgsEzJRn91KU89u2%2FLaWk0Dlju35bbXbs7x4I4HiXPebVuDAUnNbXDc0Q3fnus%2BiWuuuG5rxtnPd59CsdddtKlbsRXZe296eC22BR6wf2M6299h1t1n17bkftNxfG2plhKXOnjfQqXVHbe4rT%2FB8mJOZYOedZk%2FXrHVHHZnr5cc%2FIeJc9tVcdqCvvqhFO2uvDsVmou18dh0rEB34dkRbnHZkUm2l7a9Otw10a915%2B6b33n3Wyll3a9Y9qhh32KuJkwvugTd3XaYSKM7Cv7ml9sBLY22x8L75ZQFHszVUqn3Tbkbvbg%2F8eXRrPTMLTH5MfVjSOW1b33Lwq99yAFFNlFzOaQcm35YXMHEu%2B01qpuWfcwjMeKy0rO1020C31j13YCZlaquhU2wDxVp3277JpJQ%2BFe08ty3Prb9y3rXvuU0ylWSik%2B6d8zrhe8u3LamOmFS502sDvdp33MEex01z7BTbTLHWHTcwIzL5lxmc07a11RhU0%2B2gBZuWzJxMTX%2FnsI9vWWw5QQ5MgnyKMjTmybbLzM6gYOueG5hkOUoSbh3nTrXNVGvdd5tT99Z99diu64bVt4RC6557z%2Bx3Xz2uM%2Fnjdvttk29zrwedQ7HW%2FbVv8mPu7aAzKPaC3poXd38JcvPtjt0f1AT3%2FwM%3D)