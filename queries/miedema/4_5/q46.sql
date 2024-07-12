SELECT unit_price
FROM inventory
INNER JOIN product
ON pID = pID
WHERE pName = ”Bananas”