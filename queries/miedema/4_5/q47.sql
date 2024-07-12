SELECT p.pName
FROM inventory as I, product as p
WHERE (SELECT i.unit_price
FROM inventory as I, product as p
WHERE i.pID = p.pID
AND p.pName = ”Bananas”)
< i.unit_price,
p.pID = i.pID;