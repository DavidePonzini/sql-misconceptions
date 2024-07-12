SELECT c1.cID, c2.cID
FROM customer, customer
WHERE c1.street == c2.street
AND c1.city != c2.city