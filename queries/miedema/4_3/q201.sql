SELECT c1.cid, c2.cid
FROM customer c1 c2
WHERE c1.street = c2.street AND c1.city <> c2.city