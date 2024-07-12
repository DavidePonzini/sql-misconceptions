SELECT s.cID, s.date, s.quantity
FROM shoppinglist s, product p
WHERE p.pName = ”Apples”;