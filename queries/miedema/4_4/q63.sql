SELECT t.cID, t.date, t.quantity
FROM transaction t
WHERE t.pID IN (SELECT p.pID
FROM product p
WHERE pName = ”Apples”)