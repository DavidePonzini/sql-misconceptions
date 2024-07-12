SELECT c1.cid AS C1, c2.cid AS C2
FROM customer c1, customer c2
WHERE c1.street = c2.street AND c1.city <> c2.city