# Problem Set 7.2 - Intro to Relational Databases

### Directions

Fork and clone this repo. For this problem set, you will be working with the [Pagila](https://github.com/devrimgunduz/pagila) database.

## Part I: SQL Challenges

In `solutions.md`, write your solutions to the questions below. Also, include the SQL queries (formatted nicely, using a multi-line code snippet) that you used to obtain your answer.

1.  What percentage of films have a rental rate of `$0.99`?

-   The total number of films is `1000` determined by the query:

    ```SQL
    SELECT COUNT(title) FROM film;
    ```

    The total number of films with a rental rate of `$0.99` is `341` determined by the query:

    ```SQL
    SELECT COUNT(rental_rate) FROM film WHERE rental_rate = 0.99;
    ```

    :arrow_right: The percentage of films is **34.1%.**

2.  What is the percentage breakdown of all films by rating? (Format this answer as a [table](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#tables) in Markdown)

-   The breakdown is the following:

| Rating | Percentage from all films |
| :----- | :------------------------ |
| R      | 19.5                      |
| G      | 17.8                      |
| PG-13  | 22.3                      |
| PG     | 19.4                      |
| NC-17  | 21.0                      |

-   The data was obtained by the following query, a pattern similar to the first question but in just one expression:

    ```SQL
    SELECT rating, COUNT(rating)::DECIMAL / 1000 * 100
    FROM film GROUP BY rating;
    ```

3.  Which actor appeared in the most films?

-   The actor that appeared in the most films was `GINA DEGENERES` based on this entry:

    ```SQL
    SELECT CONCAT(actor.first_name, ' ', actor.last_name)
    AS actor, count(film_actor.actor_id) AS appearances
    FROM actor JOIN film_actor
    ON film_actor.actor_id = actor.actor_id
    group by Actor, film_actor.actor_id
    ORDER BY appearances DESC LIMIT 1;
    ```

4.  Which customer has the most movie rentals?

-   Eleanor Hunt, with 46 rentals.

    ```SQL
    SELECT CONCAT(c.first_name, ' ', c.last_name) AS name, COUNT(r.customer_id) AS rentals
    FROM customer c JOIN rental r
    ON c.customer_id = r.customer_id
    GROUP BY name ORDER BY rentals
    DESC LIMIT 1;
    ```

5.  What was the longest rental period? (Hint: See `rental.rental_date` and `rental.return_date`)

-   It seems a good chunk of people didn't return their movies. In terms of law abiding customers, the longest period was 9 days, 5 hours, 59 minutes, 0 seconds.

    ```SQL
    SELECT (rental.return_date - rental.rental_date) AS duration FROM rental ORDER BY duration DESC;
    ```

6.  What is the address of the store with the most films in their inventory?

-   The store with the most films is located at 28 MySQL Boulevard.

    ```SQL
    SELECT a.address, COUNT(i.film_id)
    FROM store s
    JOIN address a
    ON a.address_id = s.address_id
    JOIN inventory i
    ON s.store_id = i.store_id
    GROUP BY a.address
    ORDER BY count(i.film_id) DESC
    LIMIT 1;
    ```

7.  Which category has the most films? How many films are in that category?
8.  What is the address of the customer "Margaret Moore"? (Just the street address. Not the district, city, and ZIP code)
9.  There is a customer with the email "CARMEN.OWENS@sakilacustomer.org". What is the name of the city that they live in?
10. What country is Store #2 (`store_id = 2`) located in?
11. What is the total replacement cost of each store's entire inventory? (**Hint**: Each store has multiple copies of many films that each have a replacement cost.)

## Part II: Entity Relationship Diagram

Create an Entity Relationship Diagram using [draw.io](https://draw.io). Include the following entities in your diagram.

-   film
-   actor
-   category
-   language
-   inventory
-   rental
-   staff
-   store
-   customer

Include your ERD as a link in your `solutions.md` file. You can get a link to your _draw.io_ diagram by clicking on _File_ -> _Publish_ -> _Link..._

#### Note

There are some M:M relationships in here. Be sure to include the cross reference tables that mediate these relationships. For example, there is a M:M relationship between `film`s and `actor`s. This relationship is mediated by the `film_actor` table. Be sure to include that in your ERD as well.

Lastly, for your entities, you do not have to list the data types next to your attributes (column). Simply place an asterisks next to the primary key of the entity. See below:
![sample ERD](./erd.png)

## Due Date

Submit via PR by 9AM on Monday, March 31
