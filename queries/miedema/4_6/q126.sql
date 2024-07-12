SELECT city, COUNT(*) AS store_count
FROM store
GROUP BY city;