1. What percentage of films have a rental rate of $0.99?

Answer: 34.10%
```sql
SELECT count(film_id)::DECIMAL / (SELECT count(film_id) FROM film) * 100 
FROM film 
WHERE rental_rate = 0.99;
```

2. What is the percentage breakdown of all films by rating? (Format this answer as a table in Markdown)


| Rating | Count |
| ------ | :---: |
| NC-17  | 21.0  |
| R      | 19.5  |
| PG     | 19.4  |
| G      | 17.8  |
| PG-13  | 22.3  |

```sql
SELECT rating, count(film_id)::DECIMAL / (SELECT count(film_id) FROM film) * 100 
FROM film 
GROUP BY rating;
```

3. Which actor appeared in the most films?

Answer: Gina Degeneres
```sql
SELECT actor.first_name, actor.last_name FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id ORDER BY count(film_actor.actor_id) DESC LIMIT 1;
```

4. Which customer has the most movie rentals?

Answer: Eleanor Hunt
```sql
SELECT customer.first_name, customer.last_name, count(rental.rental_id) 
AS "Total Rentals"
FROM customer 
JOIN rental ON customer.customer_id = rental.customer_id 
GROUP BY customer.customer_id 
ORDER BY count(rental.rental_id) DESC LIMIT 1;
```

5. What was the longest rental period? (Hint: See rental.rental_date and rental.return_date)

Answer: 9 days
```sql
SELECT max(return_date - rental_date) FROM rental;
```

6. What is the address of the store with the most films in their inventory?

Answer: MySQL Boulevard
```sql
SELECT store_id, count(film_id) 
FROM inventory 
GROUP BY store_id;
SELECT address from address where address_id = 2;
```

7. Which category has the most films? How many films are in that category?

Answer: Sports, 74 films
```sql
SELECT category.name 
AS "Category", 
count(film_category.category_id)              
AS "Count" 
FROM film_category
JOIN category ON film_category.category_id = category.category_id 
GROUP BY category.name 
ORDER BY count(film_category.film_id) DESC LIMIT 1;
```

8. What is the address of the customer "Margaret Moore"? (Just the street address. Not the district, city, and ZIP code)

Answer: 613 Korolev Drive
```sql
SELECT customer.first_name, customer.last_name, address.address
FROM customer 
JOIN address ON customer.address_id = address.address_id
WHERE customer.first_name = 'MARGARET';
```

9. There is a customer with the email "CARMEN.OWENS@sakilacustomer.org". What is the name of the city that they live in?

Answer: Caracas
```sql
SELECT customer.first_name, customer.last_name, customer.email, city.city
FROM customer JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id 
WHERE customer.email = 'CARMEN.OWENS@sakilacustomer.org';
```

10. What country is Store #2 (store_id = 2) located in?

Answer: Australia
```sql
SELECT country.country FROM store JOIN address
ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE store.store_id = 2;
```

11. What is the total replacement cost of each store's entire inventory? (Hint: Each store has multiple copies of many films that each have a replacement cost.)

Answer: Store 1 - $46,205.30 | Store 2 - $46,415.89
```sql
SELECT inventory.store_id, sum(film.replacement_cost) 
AS "Total Replacement Costs" 
FROM inventory 
JOIN film ON inventory.film_id = film.film_id 
GROUP BY inventory.store_id;
```

--- [My Pagila ERD](https://app.diagrams.net?lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=Pagila%20ERD#R7V3bbts4EP2avARoobvsx8a9bIEEGyTFtn0yWIu2hcqil6KTOF%2B%2FlEXKlsYX2aJCdcG2KCxapCWewzPD4Yi6ckeLly8ULed3JMLJlWNFL1fuxyvHGQQD%2Fn9esC4KnCAcFiUzGkdFmb0teIxfsSi0ROkqjnBWOZERkrB4WS2ckDTFE1YpQ5SS5%2BppU5JUf3WJZhgUPE5QAku%2FxxGbi%2FvyrW35XziezeUv25b4ZoHkyaIgm6OIPO8UuZ%2Bu3BElhBWfFi8jnOSdJ%2FulqPf5wLflhVGcsiYVvrr%2Ffh%2F%2FePjn4acVffk291%2FuJ6%2FvPLdo5gklK3HH4mrZWnYBjniPiEP%2BWzFbP%2BAEsZikn7bf3ExJygR8Nr%2B3mzlbJPln%2FhGn0YccCn746YGk%2BBu5QyknxE3GEGX7v8IvMfuR139vWYE4%2FsmPrfe274njjznLLHmw3jm4xzReYIapLEsZXefNvbNke3mJaHDoyIJti5uj9e5Rvc2in%2FLOOQiIKMrIik7wERRcMSZ4d8wwO3KiE5TE4SMOE349dM0rPm%2BpWRJwvktLWUg3yD1VLxmJMTIrGyx%2F457E%2FGYcS4xnNxTtiOH8znblQJWNFDcr6u3SsdaUB5ry6k0V3QGa4h92bn5btOH7Odz3%2Bs79Cu%2F946yXDLeq5PZPUFsli%2F2GLHYHvWOxp47F9aY6ZrH%2FZ7FYiO1l6q2P29Len%2BS2F%2FaN2%2FZAGbedelNdc9vvK7cvZOQlyq5SoZ2GLPZtvSwuXYEt9ZwLWewGYEBYb8viwDmPxYSyOZmRFCWKGbxAafR3ihXw1zqDv5MVfcKRuFQtZNbtbniAzHUGNpZkOC7cZmTmLEDrndOW%2BQnZ4Yv24UWLueKha9tTw7WO342loIZ9vEbZPy1q8JlJTReK3lSqEuGf5ceFvZ%2BOBF5DfXDcvrls3qXGDrpsfr2pjo1deKbL1pmxa%2BKuOafoWLFdmp23UIY%2FT%2FG5IL4%2BPkMBdX33QucN6H0QdmPvHDhyBsPjdgLW8E5YFmC9z6%2FhiTnRwRqOghrWiRqD9jV8x%2BveptoDIEaf42QBBCl7jhcJSkvlEd9sFGAeJ9EtWpNVPkq4xkx%2By6ObOaHxKz8fSW3aSJDQLSePMk%2FjJBmRhNDN77jYyv9Waj7mLYrfojjjde%2BlNti1ojv0UjnxFmVMXiVJErTM4l%2Bb684rLviwiNMbwhhZiJPkXX6uXtR084d%2Fj5J4lvKyCf%2BtPPZSUWGvFLMnTBl%2BOS5nUHykkzgEA1rSb1eegj3y5A5rI39XiSpm7GyaDAFNrjlyizGvVacKv3W2QZqS31j2YkoK7ux0rCjKlmgSp7NbPM3vwtuWPIgby4sI79JpsrFb8ziKcJpDTBhi6FfJQ6Ff%2FBr8G%2F6Pd8Uotz0%2Bv6YRP7a3x%2FxffjplI5Lyy0TxBhnMyfKMc8IA49oI1iPjC4JdLvY1Q1aepxxYSa0dYLnTzPvUoHo5qr6jG1UboBrhbELjZT4TMti2wDYc6MYWxsq4N8q7Ao%2FXGFEDbgtwbcvTjS7MNuAOyWyFZtjY2pbgug3dqO7AhQEs7uVyJxQlY4OyIpR97S4VjO%2Fkt8QxjlYUGQPcFuCBdu8qOAQwh9d4zq3mQ5Z29yqEBhinM34xBtcWuLraHSsY6KJ4maAJXvA7G09IxgzCrSIZ2r0rGKPKzW06M7i2wXWg259yYYgq4R0xXi0jY27bgevaun0pF0aqsiWexNyZmmLEVhRnBuE2CLu6HSqZhLSD8HSVJBsQDbItkA10u1QBHLsA0TfLx9nJ3LsgA6%2FDZJyjy67qUviKE%2FWlNLyrrfWDJP%2FmCQ2VdsBzB12nosIY3df0iaNJxIgxq%2BI6VsVdkDHj%2Bw0nHGVQX70AwkjfdSzJYgK5JzTwUBJWX5bGAxjmMzkPCoDVvjoewBDfdcaHrFl7aYms9rVxd3822%2FjDhMNrrLc%2B6w2SVMuM7lNckZxSz5U9KW0o54lRgRMqcOjh5L4Ybg8GDI3hVgCsdsPtwSG7kfcRYnhm5mdas5aBwttN52edKbxvdOAyHSjGWX8F3oeBx%2BuJ0AADbjtw9Ys8DKoYfdeu74Ff13fL0q3v3p4AjZGBpjLg91vjPRikSdHCLPe3AVW7tvsQ1FuR92y0XZu2O3IdA26IpM93h5G8a5Mi31AG%2FAM7bPVF2304jzfa3hJU7do%2BMDuRqd3MQoB3MvOjeB5CX%2BbH4T0bzs%2F9AE0Fb5z%2BMYTSdJzFyS%2FyfAl5XzElHecy2efxXSF3B025O9TMXZhWEl66sRDc0yV4642F4Hx4tMq4r8kdR%2BNda1v79OredThs6F2Xj7opN9bhnhSIieCKca9PeGLhgS3G%2B%2BJeh3vmTia%2FRQGy2n3sEHon05hmbGymTy2h1Z66JF2m%2BlNOBtmWyOrf02MAlyvxAsWJgbUNrNp385DOWSWBLIq4p5oZQ9sSXO2beLhwHx6TRKp3IgU39rYasqS7J0Bc%2BLSQSSJtpADugS2l%2BzKJcmE427jaSqDVPotyYZzMuNoqkNU%2BiRrCSdTDZmcmY7Y1PvtRM9uDpskF3YU%2Fh3sSSMUWXsZuH5eAYoj1124P4axM7r5ndotph612wz2EkzLzvLUqdLUbb9uG1tssSilCV38U1Lah0aWYrWhqlLk1utqDobbcSay66IimUzNyW2KrPRZq73lJDIBUSVLUn7i%2Fk%2FKXU9mW5ret2fC1TfLpn3OTouB72%2BotqXo5Fbjk6jsMO3p7kgVt2mMuemB4mHjDW8UbwDs2vaZbTZSbFKtXUMtYxwutoxhi%2FQ04CLk2KwUdgKs94lBOm8xagWpsexBv2BNOMgkcatDtQ7wBDl2TdtUe2B6EGvZsu2nym5WA24NYA1ycX2WYGnvbGlvt702ybfjUyRJl2TOhZty2mwRpf21SAJ9MeMwlGeBqAiFvFQgBLxQP%2FIY%2BWXf5kjIUY0z32Vvv9nxPthBGQq8XKEUzTMcm0qUAYe2xkHBPDNNMl5Vg24NYyP9o3wN9a3xlSOn0Il%2BxXq5vkQ%2Bu8cn0m7M37YBNDWpNKVrkgxuNuK0W%2BfghJYTtnk7Rcn5HIpyf8R8%3D) ---