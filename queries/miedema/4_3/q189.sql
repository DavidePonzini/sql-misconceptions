SELECT C1.cID, C2.cID 
FROM customer C1, customer C2 
WHERE C1.cID < C2.cID AND C1.city <> C2.city AND C1.street = C2.street