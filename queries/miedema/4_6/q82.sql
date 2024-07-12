SELECT store.city, COUNT(*) AS number_of_store
FROM store
GROUP BY store.city;