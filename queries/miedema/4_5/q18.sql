SELECT DISTINCT p1.pName AS item_name
FROM product p1
JOIN inventory i1 ON p1.pID = i1.pID
JOIN product p2 ON p2.pName = 'Banana'
JOIN inventory i2 ON p2.pID = i2.pID
WHERE i1.unit_price > i2.unit_price;