SELECT DISTINCT p.pName
FROM product p
JOIN inventory i ON p.pID = i.pID
JOIN product banana ON banana.pName = 'Banana'
WHERE i.unit_price > (SELECT unit_price FROM inventory WHERE pID = banana.pID);