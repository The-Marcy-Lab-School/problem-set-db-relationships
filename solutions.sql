-- 1
-- Answer: 18.56%
SELECT count(amount)::DECIMAL / (SELECT count(amount) FROM payment) * 100
AS "$0.99 rentals"
FROM payment
WHERE amount = 0.99;

-- 2
-- Answer:
-- rating |       percentage
-- --------+-------------------------
--  PG-13  | 22.36710130391173520600
--  G      | 17.75325977933801404200
--  R      | 19.35807422266800401200
--  PG     | 19.45837512537612838500
--  NC-17  | 21.0631895687061183550
SELECT rating, count(rating)::DECIMAL / (SELECT count(rating) FROM film_list) * 100
AS "percentage"
FROM film_list
GROUP BY rating;

-- 3
-- Answer = Gina Degeneres
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY count(film_actor.actor_id)
DESC LIMIT 1;

-- 4
-- Answer: Eleanor Hunt
SELECT customer.first_name, customer.last_name
FROM customer
JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY count(rental.customer_id)
DESC;

-- 5
-- Answer: 9 days 05:59:00
SELECT max(return_date - rental_date)
AS "longest rental period"
FROM rental;

-- 6
-- Answer:  28 MySQL Boulevard, Woodridge
SELECT address.address, city.city
FROM address
JOIN store
ON store.address_id = address.address_id
JOIN inventory
ON store.store_id = inventory.store_id
JOIN city
ON address.city_id = city.city_id
GROUP BY address.address, city.city
ORDER BY count(inventory.store_id)
DESC LIMIT 1;

-- 7
-- Answer: 74 | Sports
SELECT count (film_category.film_id), category.name
FROM film_category
JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY count(film_category.film_id) DESC LIMIT 1;

-- 8
-- Answer:  613 Korolev Drive
SELECT address.address
FROM address
JOIN customer
ON customer.address_id = address.address_id
WHERE customer.first_name = 'MARGARET'
AND customer.last_name = 'MOORE';


-- 9
-- Answer: Caracas
SELECT city.city
FROM address
JOIN customer
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
WHERE customer.email = 'CARMEN.OWENS@sakilacustomer.org';

-- 10
-- Answer: Australia
SELECT country.country
FROM country
JOIN city
ON city.country_id = country.country_id
JOIN address
ON address.city_id = city.city_id
JOIN store
ON store.address_id = address.address_id
WHERE store.store_id =2;

-- 11
-- Answer: 
-- store_id |   sum
-- ----------+----------
--        1 | 46205.30
--        2 | 46415.89
SELECT inventory.store_id, sum(film.replacement_cost)
FROM inventory
JOIN film
ON inventory.film_id = film.film_id
GROUP BY inventory.store_id ;




[My ERD](https://app.diagrams.net?lightbox=1&highlight=FF3BF8&edit=_blank&layers=1&nav=1&title=ps7_2.ERD#R7V1bc9o4FP41vGSmGd9tHgNJ24d2mk13ZrdPGRUr4KmxWCMSyK9fyZYwknxRAGMetN0HJMuyfc53LvqO7Izc6XL7JQerxXcUw3TkWPF25N6PHMe2HWdE%2F7fiHeuxxqxnnicx66s6fibvkA9kvZskhmthIEYoxclK7JyhLIMzLPSBPEdv4rAXlIpXXYE5VDp%2BzkCq9v6TxHhR9ka%2BVfV%2Fhcl8wa9sW%2BzIEvDBrGO9ADF6O%2BhyH0buNEcIl7%2BW2ylMqfS4XMrzPjcc3d9YDjOsc8KPv%2B7cr9Hkv%2FfH3fjzfPJlmll3nzyvnOYVpBv2xCN%2Fym4Y77gUMNySa0wWeJmSDpv8BGkyz8jvGbk6zEnHK8xxQuR2xw4skzimp09yuE7ewe9iKou0VyjJcKEVfzLy7%2BlcG4zWpebp1OyOyHxw2%2Fis9l6CBHsQLSHOd2QIO8HnQmewcx32nG%2BVDvmQxYH6eB9gqJnvZ64ES34w2X5AzravyHkGMJwjNvehsNdvyTIFGZXdC8rwT3aEym62SNL4G9ihDb3hNQazP7w1WaA8eSfjAVcROZxjZlFOQGdL0nSKUpQX13GhRf8JZ%2F6kM7JrFXqDj1zmttT1HWyFgd%2FAGvO7RGkKVuuk1Dk9cQnyeZJNEMZoyQbxp%2Fws3tRL8V8dwApZMJR454FJYIswccaWAhM7qMGJbXl9ASVQgHLDkfJMzmywzDXO0R%2FI5ZihEj0HomVd6xWYJdn8G3yhT%2BJVPU%2Fs4WgXIkJ9SQtftSBWDDOqZIQBbrTiCZHR1Lr1qT07U9K2q3Zh4iuU4ynKyG2CpNANJHB5gxQygmIdXcW2WJmqbq7eQE%2B7fNz5lRsqys3AEhqlnqBU3xlaqZGi1By%2BQPJUM0js1fpNb5Zobfnc6PGNvvX1HUYD69tRjZg%2BEQm7JpAPFshdMZB7kWYgd6yWjI9d7omsK0A2JzKo8stQyi9t9XqhBihBSkSSEbcwQZssXivY3D%2Fp8XD11MzzpsSrSSc6PFFp6debTjhjdVGxWRPLhHmhW3JdCkxq2IW%2BYwI0oRdv8oz1GhwcjQPdDMSPesIBd351GciaciMMFILuD44n2SsRAF9g1I8hMYh48%2BqgOI6nOSuwW0KqwKkzurMMqk5AlV0TUmphNe6Ls3Cb3YtJda6GswhDXc7C7Qsonup%2FboRAZNxAl5Vdb5Lh2YpyX5J8jZ9L5mIfBVKw7zPqPlrdurmE21cu4TntuQSx6hx2BH8DgOMBoMtAe71F%2FRpzT5cm4A8W8B0p4O8rjJ0BP%2Bgt4KvxviA4%2F0DDbbYb%2F3XHepUqwglOTUQ%2FQaeDlyfUeqIQz4l3m2%2FAHDYs%2FWOhgAFmJPp3kgBSraNuyJ5xMETBqQDTrYdETl8Jg%2Bo1WJJoUoaBUgY3EFOGSJsjsHtLK2v2NRQwMQRBl%2Flf%2BaYGt64euvf09dxzYxyoG8SoZ4ORozEyfIVCJZHqtWpixKVixH4Z%2BWEeuT%2FqQeWebgqYmBjRZf8Nur6aGFHHKrWTyAeLDKP5ozU%2FOJ%2FsqlxRK5%2BsV1c24DgHOHS5Zr8vh%2B%2BobqHKCE1qMFRq4IuZge%2FqZgb9AaWGcRZ3rRg30GVm15sdOCqDRKQB5zX7TIxe9fU6OPXsdHDPBVHctuWM00Md2UHD9muDFX2s6LLIYV8ssq1uNuOlCZMJXEsm4GqXnnt7kZJPfJgJCDUs4wS6jOyKEwGVJjQ7yk5U6vBZgMrq1ZeXTS34ZGXrhnG%2By%2B%2F8O0hqvicgKxTGc8hjNkx%2Fo7eHqkMR1cEnB2AW39EvOpDmw9M7zNHf6DvIdjyQV8eWIIt%2FFGAgwsx3%2F1KFEk2x5i%2Bm36JxvxVaO96it0V%2B848a0K5tgsuZrMhmbTqVfWsVN0rb1Wy0sTtoPMI8IRKmcfq%2B4q2oJNojMxEc2uQz2CJyZrdEBHN4DHQOsWLVxXLemcMU4ORVvOOW9%2BYeqQFVuYQjFRwUtqB8UnZWhUNlIjsSJ1Le4StFoUx0rjfqAtWhKRg%2FCsbkCE32DrPTppEMjIdAZBBvhmFlC3YkWIN9a%2Ftel0XQ1hWgOLBGg6LYk1DsyjsmdFHsSa%2BsKrs1%2B0axSrpcHMV7RAq%2B%2BdbxO8Coj7tur9iwALoUnvyxCIMoOg5OofTFGxmWPaPJVjN3tlnQrN2HelEskBfvermhbfe1ErDVwHlToMQs3LvS%2Fiuv79ut9X25aGteFTuH0gcv7dstpX1hYf9cHwqMsvWVrVuq7%2B%2FVEPUrRy2qNVH%2BUlHe48XTDwIl7Msr%2BGohR6jqGV%2FQ6QtKW7veaM8v1lLXNQo%2BQcGDU%2FahqmBFoWcmavfsqkdySYFddbwPs6sHVFf4Id53dHlCq6kwfzFadnwuQktiIHx5n3jPFESoUhBHg7YCZidiKf9%2FiFhaHzgesJ%2FI6Y4I2VvbcgcmZ%2Fkm3k4wuw3fNLoUmF1pw0Igk6q6YJYnGl8azOpLVQqYhTpahhO8eyqkh7KTC2qnc7hdFG59BcNpL2GcE9K%2BJqS9oQsOEhL37%2Bl8FNK%2BbBvyRH1DWl1BtkO659JwW4l3j8NfhzDsKqu5tisawTiMhvbcY13PPTDMffmzZvLXynRhHkjV4UD%2BPl7fMFfXvz17bp1k5VQvfWu5keCpo%2FDjWc4Zca296SEY2HtLSbEno1Hbe8t%2F0eLCsOZWdf0JSWNe3pFctC8kRbtx3aFTckfXAoZ27K60vgyOdeyeNJEvT9S3BWisL6%2FcAsIjnLawNC13unE7ID2uNXSGo28IA4cCmWgJjyVaFIu68F4P%2FiWhC7KDNbl6Myyt2yAIj0Fllf%2BH%2Bvn%2FGaGsvSYd2qd7nojASH7dQzurCTrSo6OhTJrVn1Yrh1d%2Foc59%2BB8%3D)
