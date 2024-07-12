SELECT p.pName AS ProductName
FROM inventory inv
JOIN product p ON inv.pID = p.pID
JOIN product bananas ON bananas.pName = 'Banana'
WHERE inv.unit_price > (SELECT unit_price FROM inventory WHERE pID = bananas.pID);