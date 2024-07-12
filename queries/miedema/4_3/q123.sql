SELECT DISTINCT c1.cID, c2.cID
FROM customer AS c1
JOIN customer AS c2 ON c1.street = c2.street AND c1.city <> c2.city;