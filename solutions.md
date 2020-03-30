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

## Part II

### Link below

[ERD link](https://app.diagrams.net?lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=pagila-diagram#R7Z1dd5s4HsY%2FTS6Tw7vxZZ2k7UyT3azTnaZ706MY2WaKkRfIi%2FPpRwJhXmQCwRaSjzW9mEiAMNLDD%2F0fSXBmXq5ev0RgvbxFHgzODM17PTOvzgxD10wX%2F4%2FkbLIc27WzjEXke3SnIuPef4P5kTT3yfdgXNkxQShI%2FHU1c4bCEM6SSh6IIvRS3W2OgupZ12ABmYz7GQjY3B%2B%2BlyyzXNcYFflfob9Y5mfWnXG2ZQXynemVxEvgoZdSlnl9Zl5GCCXZX6vXSxiQysvr5ccfmx%2FBzW%2Fny5%2F%2Fif8P%2Fjv59v1ff51nhX3%2ByCHbS4hgmHQtGj3%2BTarT0ALwiJs0PSorJz%2FXGnz%2BuRlpcPrXdPrtIYHx%2F8buuW7a20vb%2Fro42eTVCT1cuzSJf42fbKYwAImPwutiy2SOwoRKQceFTWDofSJtidPXUxTC7%2BgWhFhQkzgBUVJseoMR2m6Dr37ygLO1i%2FF4RNM%2F07Ru2DR9RXSq5YlNKXEHI38FExjRvGWyIrWg4z%2BzaiBXUpNIS%2F3S%2FWL0FM3ge3VomFToIFrA5J09tVJdf4EI%2F95og497KYSqa1R9y7JI88worfvn6nUAescstgVuz3GH%2FJBogt7dhkXLofe2aWvVIrJLpUeVZVsryKwVZNQLymqCKQj%2FUbrwIivVXZ6kSt59w%2BxuAJfe3c8geKKVs8Q%2FhdzU4Ya2YqHpBL4mVYWAwF%2BE%2BO8ZFgRR0OQZRomPofKJblj5npcqPYKx%2FwYe06KIzNbkEtOLtidn9hXOSe%2B%2FCZj9XkToKfQuUYCi9LzmPP1vK0hyDvhaaUoKRVp%2BgaKyVDvcxiVp0fLxPaS57n4iom19XjsCzecx%2FGArd2xW02GalWnMfoAqtX2dVVnWZz%2FY7kC5pFeY1EKkEF%2F6QzlROooki8PSVH4cd1SZWkdUjXXBrBrXWGX2ZVWtIKNeUG9WdYWTy6j4awoncBpkct4l07l2obl5pzNHjLGfhPijSWOa9NMswbVZb9D4xV8FINwiiG4h7TNb%2BoF3AzboiVQf7hjNfuepyRJF%2FhveH%2BQySPtNFGCGQ0rDfCo1INTIv8qR96REeq5UG%2FAubyu9lnULXis73oA4yX8lCgKwjv2s3cmBK3y7%2BOEEJQla0Z3yq%2Fxc%2FVFbVTEiLuPYek923cDXKC6n3uGhyTLEnF0Q091msVW09GEaMMIBRDi%2F8EGMdpZgTf7EdZD4IJiS2y9cpPd6gta06gM4z5sqor%2Bf%2FP2YN0%2BZIdm%2BzQQpayrMnoTxGsz8cHGTncW0iqwpPRvJQrjIeZA%2BQpe4MBiSX4MSkDTiaIIr%2FZI8DjGYjEuc1ot0yqo1ipJLFMZJBPxUABBr8gUSXU68CK2%2F588vrXZr2Tue9p3k9ZEOe%2F4ocbrJqf7EOZiaDEZNd9%2F21tFj%2BdbeoYmucqpq52DSaVMHuUwq%2FM466P90a%2B0kmUPqwWT0MPejOPkVghXkwxetXRBpYUcOlwFgYneESQ6dg4vHYsQjGiWZck6BI2YvjnCTgs1IIQAKI0eBEdcQjJEOno3CCCeMNJiAojAyPrwUFD240kPX3I4RMq8urM5aK4ofQ%2FFj3Isf3LQwZrVwgxv6iQwBK6dNaqfN0DpabWODl3hYqy2g4lFum5xu21hyuy3XqvLbhD2gJDPcxqzjpoJkGbq5LSgRbraNldsmkCKS2W1jFSgfHUG6%2BmwcA2UVKQtEiGShsm6yUyAZNfCfK5edUoaptromegKbU42I%2B09gqxU0%2FAQ21tI%2FqQlso91CKqbWVptnP%2FUMMK1WY52RS5DABYrYudLKVhNqq9VcNcvs1ungZqrpGmuBzKh2lKsmp6vW%2BCSUxVbTNdZFUb7asPPYsvtaHmNN11iDRDlrMsTFbTgRbq3pGjt9STRMTicwpjeuPOaazmNGgaIIZ4qIt9d0NkpSFBmMInr7Uulh%2FTWD7aPiaHGlAma5AmZTr7luXVd8WRY35bA9WdyWKxUuSxouGw2jg9KEywbbv1Xh8rCPJ6NfJ5ejJliPnvtsN9XfPRxVxEfNRocBRNXf5QaUhrckCIuaDfatFYmfBMqAkx4lwleA6QaH%2BUwKJZ3l4UqGEpM14DwYzyJ%2FTaaeKKDIDpTOi8I4SkiZcQKJYvYz4zjKwTi8HBRGeGPEtLphhOMkSdbEVRgZDiNGL4xwk4PDhjhTmFrwytSX2tR3HOGuvsOGOFGqHWXry2nrOw1RkSyu%2FogNkpSpP%2Bjzyem3pIOfItiYZ%2FYU4%2BaE%2FF4Xqfq7ByOKcEd%2FxCFIUp3djuIY9Vuozk8MbOSDO6PzuSKJ%2FCQRbuiP1GJ1gSSRbLH6iJ19gjslkZpmcAQkEe%2Fkj9TrIQWiRLL3Q444TDlRCOGMEOEu%2Foi1bRVCBkNIw2J4UR6%2BzSLkkpokrCiUi38m0MXXjaqLb427vmuWm4tvsyjhbrEpH3%2Bvx5PdACBZfHybHRhSPv6wL0HvN%2F%2BNmyIcdmQHeB6Ge6xCZgn6uy1AEW7jO2rqm8AxQclmvjnsmI76wtPRsES4ke%2Bo%2BW8CWWJIxhJ2VEd95elYUCLeyXfUW3YEskSyl%2Bw4HIZ1FEI4I0S4k%2B%2BoJccCEdJvxTE3MVgsQu7JDCVWEcrGPxNo49uadDa%2BxXKE7%2BQ25eHv9WCyGtAji4dvscNCysMf9OFk9Rtm5qcIdlRHTXqTpZ%2FbghPhDr6tPtQikCT9VvXwEwM7nKNGA4%2BGJcIdfJsdAFIsGWxmgWSLemx2OEeNBh4NS8Rb%2BLZa1yMQJpKt67E5jOcohHBGiHAL31breQQipN96Hm5iMFmE3BOXhFWEsvDPBFr49ffpWLml34oR3eUlHZYjfA02ZeHv9WAyG9Aji4W%2F43O4ysIf9OFk9htf5qcIdlBHGW%2Fy9HRbgCLcxDfVO60FskSyV1pb7IjOCoRgAaNf6q06R0IU4Va%2BpRb2CBwWlGxhj8XBilUE4UuQzgY%2BvzmTag6%2BQIT0m4PP770obA%2F1j%2FAZXwOihSsHTloHrvt3Krk5cC7bp%2FVz%2BSgXTk4XbtQwuUkWF85lu7jKhRv0IeX26%2BfyU4TBKEJNpJWlv9uCE%2BEenKuWrwskiSFXxOwO%2FFltBZKDgUS49eaquFkgSCRbu%2B5yeJ%2BoIghfgoi33lw1HigQIf3GAzl%2BWLADQ6C3gLkNgC%2FPTzZTGADyCdzrYgtTectklXttMPQ%2BRVHaaNdTrIjv6BaEm3QDvogH2mxp4idJXNh58uq1vPFqQ1PZTyS%2Fq%2FHmbPa28LWhp2gGW29iQ0tyRjTXX3uYqms7W5RmRmlVPlcvZFc703PcEXGX%2FDiz6seZ45pUsmulRxVqYQqyagUZ9YKyumAKSmW3vfA9lLija5POwfTIkezHlvEtmVRVxniijf5J6sm%2BC4wAPMJgAma%2FFxF6Cr1dFuzh4aA3zRag5WsXjp0HD5vKKfuKKN8Fzecx5NOsO2YccAbMCoTev7O%2BB%2FH4d20ouHNh23aZPfqF5rTAJ03dwcjHdUN0lmW%2B%2BslDwS6c%2BlnaUpREEkNRLJ%2FV3EqxDk%2BlQSFmHQpiDA25Q4yN7TFIULiISTugk6BY0wyFLcUMTR9VmunckB9jHea89MNYhV1vMELb3lENX9k2FmCVrlMLu0pCk4Y%2BTW%2F7Goo%2BRg0aTt4T%2BSh96hiz6wXxps%2BOD4x8BYQ8KyKok2DP%2B6PX59qFPqqy5wjQ02HwgF%2BI1qkP9REEceeO25E7TUsUB%2Bv11D8Obvft9dQKsusFcecOaymdGnca1kQX3MGy0audnj1jt1oxA4Box6dYxYGo0lOS1UdyOrOo%2FWU%2FXFlk1z5xNOobgTm1gpzBI7AdHx%2BPIMCbTwJETR9dLYHIGR%2BUQ0OAp8McczHgkQYgooMo3T0QQAxXNEDYpxxpzBPBR8MQd4EP0xxXA6gjwEeHSROHxcd7Ns7%2BEVThNVujktmsv2s2k0TdtOZNr3xtUCu9mj7dOlgoVu%2B19A7FDMGh2I7J8HcRevY9eFLxWNMHowuOadvXf0vQD8LJCKGkvHsE1stb5EGyxz8%3D)