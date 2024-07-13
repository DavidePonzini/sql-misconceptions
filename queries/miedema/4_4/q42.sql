SELECT c.cID, t.date, t.quantity
FROM customer as c,
transaction as t,
product as p
WHERE t.pID = p.pID
AND c.cID = t.cID
AND p.pName = ”Apples”;