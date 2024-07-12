SELECT c1.cID, c2.cID
FROM customer c1, customer c2
WHERE c1.city <> c2.city AND c1.street = c2.street