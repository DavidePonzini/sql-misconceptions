SELECT A1.cid , A2.cid 
FROM customer A1 JOIN customer A2 ON A1.street = A2.street
WHERE A1.city <> A2.city 