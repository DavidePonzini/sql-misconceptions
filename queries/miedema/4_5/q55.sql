SELECT p.pName
FROM inventory AS i
WHERE i.unit_price >
(SELECT i.unit_price
FROM inventory AS i
JOIN product p ON i.pID = p.pID
WHERE p.pName = ”Banana”;);