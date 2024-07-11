SELECT DISTINCT c1.cID, c2.cID
FROM customer c1
JOIN customer c2 ON c1.street = c2.street AND c1.city <> c2.city;
