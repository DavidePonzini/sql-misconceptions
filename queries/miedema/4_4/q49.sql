SELECT t.cID, t.date, t.quantity
FROM transaction as t
WHERE (SELECT pName
FROM product
WHERE pID = t.pID
AND pName = ”Apples”)