SELECT city, COUNT(DISTINCT sID) AS num_stores
FROM store
GROUP BY city;
