SELECT p.pName
FROM inventory i
JOIN product p ON i.pID = p.pID
WHERE i.unit_price > (
    SELECT unit_price
    FROM inventory
    WHERE pID = (SELECT pID FROM product WHERE pName = 'Banana')
);