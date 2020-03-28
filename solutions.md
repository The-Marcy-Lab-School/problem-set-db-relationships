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

SELECT  COUNT(store_id) AS stock FROM inventory GROUP BY store_id ORDER BY stock DESC LIMIT 1;