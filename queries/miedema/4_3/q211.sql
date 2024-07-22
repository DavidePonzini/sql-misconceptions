SELECT c1.cID AS Customer1, c2.cID AS Customer2
FROM customer c1
JOIN customer c2
ON c1.street = c2.street
AND c1.city <> c2.city
AND c1.cID < c2.cID;
