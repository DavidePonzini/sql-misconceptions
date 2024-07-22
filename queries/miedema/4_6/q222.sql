SELECT city, COUNT(*) AS number_of_stores
FROM store
GROUP BY city;