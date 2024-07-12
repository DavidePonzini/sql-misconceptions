SELECT city, street, sName, sID
FROM store
GROUP BY city
ORDER BY city ASC;