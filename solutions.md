## Answers:

1) 34% of films have a rental rate of 0.99

    SQL:
        ```
        SELECT count(film.rental_rate) / 10 AS "Percentage of rental rate of 0.99"
        from film                       
        where film.rental_rate = 0.99;
        ```
2) 
    | Rating        | Percentage    |
    | ------------- |:-------------:|
    | G             | 17%           |
    | NC-17         | 21%           |
    | R             | 19%           |
    | PG-13         | 22%           |
    | PG            | 19%           |
    
    SQL:
        ```
        SELECT film_list.rating AS "Rating",
        count(film_list.fid) / 10 AS "Percentage"
        FROM film_list
        GROUP BY film_list.rating;
        ```
        
3) Gina Degeneres appeared in the most films

    SQL:
        ```
        SELECT actor.first_name AS "First Name",
        actor.last_name AS "Last Name",
        count(film_actor.actor_id) AS "Total Movies"
        FROM actor JOIN film_actor
        ON actor.actor_id = film_actor.actor_id
        GROUP BY actor.actor_id 
        ORDER BY count(film_actor.actor_id) DESC 
        LIMIT 1;
        ```
        
4) Eleanor Hunt is who rented the most

    SQL:
        ```
        SELECT customer.first_name AS "First Name",
        customer.last_name AS "Last Name",
        count(rental.customer_id) AS "Total Rentals"
        FROM rental JOIN customer 
        ON rental.customer_id = customer.customer_id
        GROUP BY customer.customer_id
        ORDER BY count(rental.customer_id) DESC
        limit 1;
        ```
        
5) The longest rental was 9 days

    SQL:
        ```
        SELECT max (rental.return_date - rental.rental_date)
        FROM rental;
        ```
        
6) The address is "28 MySQL Boulevard" 

    SQL:
        ```
        SELECT address.address AS "Address of Store", 
        count(inventory.store_id) AS "Total Films in Inventory"
        FROM store JOIN inventory
        ON store.store_id = inventory.store_id
        JOIN address ON store.address_id = address.address_id
        GROUP BY address.address_id 
        ORDER BY count(inventory.store_id) DESC
        LIMIT 1;
        ```

7) The sports category has the most films and it has a total of 74 films

    SQL:
        ```
        SELECT category.name AS "Category",
        count (film_category.film_id) AS "Total Films"
        FROM film_category JOIN category
        ON film_category.category_id = category.category_id
        GROUP BY category.name
        ORDER BY count(film_category.film_id) DESC                                                                                                                                                               
        LIMIT 1;
        ```

8) The address is "613 Korolev Drive"

    SQL:
        ```
        SELECT address.address AS "Address",
        customer.first_name AS "First Name",
        customer.last_name AS "Last Name"
        FROM customer JOIN address
        ON address.address_id = customer.address_id
        WHERE customer.last_name = 'MOORE';
        ```
        
9) They live in Caracas

    SQL:
        ```
        SELECT customer.first_name AS "First Name",
        customer.last_name AS "Last Name",
        city.city AS "City", 
        customer.email AS "Email"
        FROM customer JOIN address
        ON customer.address_id = address.address_id
        JOIN city ON city.city_id = address.city_id
        WHERE customer.email = 'CARMEN.OWENS@sakilacustomer.org';
        ```
        
10) It is located in Australia

    SQL:
        ```
        SELECT store.store_id AS "Store #",
        country.country AS "Country"                                                                                                                                     
        FROM store JOIN address
        ON store.address_id = address.address_id
        JOIN city ON address.city_id = city.city_id
        JOIN country ON city.country_id = country.country_id
        WHERE store.store_id = 2;
        ```
        
11) Store 1's total replacement cost is $46205.30 and store 2 is $46415.89

    SQL:
        ```
        SELECT inventory.store_id AS "Store Number",
        sum(film.replacement_cost) AS "Total Replacement Cost"
        FROM inventory JOIN film
        ON film.film_id = inventory.film_id
        GROUP BY inventory.store_id;
        ```
    
## Pagila ERP:
![pagila ERP](./pagila-erd.png)
