# Solutions to SQL challenges

### Question 1

34% of the films have a rental rate of $0.99.

Query: `SELECT (COUNT(rental_rate)*100)/1000 AS percentage FROM film WHERE rental_rate = 0.99;`

### Question 2

| Rating        | Percentage           
| ------------- |:-------------:|
| PG            | 19            |
| G             | 17            |
| R             | 19            |
| PG-13         | 22            |
| NC-17         | 21            |

Query: `SELECT DISTINCT rating, COUNT(rating) * 100 / 1000 AS percentage FROM film GROUP BY rating;`

### Question 3

The actor who has appeared in the most films is Gina Degeneres.

Query: 
```
SELECT first_name, last_name 
FROM actor_info 
WHERE actor_id = (
    SELECT actor_id 
    FROM film_actor 
    GROUP BY actor_id 
    ORDER BY COUNT(actor_id) 
    DESC LIMIT 1
    );
 ```
 
### Question 4

Eleanor Hunt has the most movie rentals

Query: 
``` 
SELECT first_name, last_name 
FROM customer 
WHERE customer_id = (
    SELECT customer_id 
    FROM rental 
    GROUP BY customer_id 
    ORDER BY COUNT(customer_id) 
    DESC LIMIT 1
    );
```

### Question 5

The longest rental period was 18 days, 0 hours, and 0 minutes.

Query: 
```
SELECT rental_id, max(age(return_date, rental_date)) AS rental_period 
FROM rental GROUP BY rental_id 
ORDER BY rental_period 
LIMIT 1;
```

### Question 6

The address of the store with the largest inventory of movies is

Query:
```
SELECT inventory.store_id, COUNT(inventory.store_id) AS stock, address.address
FROM inventory
INNER JOIN store ON inventory.store_id = store.store_id
INNER JOIN address ON store.address_id = address.address_id
GROUP BY inventory.store_id, address.address
ORDER BY stock DESC LIMIT 1;
```

### Question 7
The sports category has the most films with 74 in it.

Query:
```
SELECT category.category_id, COUNT(film_category.category_id), category.name 
FROM film_category 
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY film_category.category_id, category.category_id
ORDER BY count
DESC LIMIT 1
```
### Question 8

Margaret Moore's address is 613 Korolev Drive.

Query:
```
SELECT address.address 
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
WHERE customer.first_name = 'MARGARET';
```

### Question 9

That customer's address is  1378 Alvorada Avenue.

Query:
```
SELECT address.address 
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
WHERE customer.email = 'CARMEN.OWENS@sakilacustomer.org';
```
### Question 10

Store 2 is located in Australia.

Query:
```
SELECT country.country 
FROM store
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
WHERE store.store_id = 2;
```
### Question 11

| Store         | Replace Cost  |    
| ------------- |:-------------:|
| 1             | $46,205.30    |
| 2             | $46,415.89    |


Query:
```
SELECT store_id, SUM(cost)
FROM (
    SELECT COUNT(inventory.film_id) * film.replacement_cost AS cost, inventory.store_id                   
    FROM inventory
    INNER JOIN film ON inventory.film_id = film.film_id
    GROUP BY inventory.film_id, film.replacement_cost, inventory.store_id) AS inventory_sums
GROUP BY store_id;
```