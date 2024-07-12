SELECT city, COUNT(sID) AS number_of_stores
FROM store
GROUP BY city;