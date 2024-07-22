SELECT c1.cID AS Customer1_ID, c2.cID AS Customer2_ID
FROM customer c1
JOIN customer c2
ON c1.street = c2.street
AND c1.city <> c2.city
ORDER BY c1.cID, c2.cID;