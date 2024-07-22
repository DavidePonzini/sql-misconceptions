SELECT p.pName
FROM product p
JOIN inventory i ON p.pID = i.pID
WHERE i.unit_price > (
    SELECT i2.unit_price
    FROM product p2
    JOIN inventory i2 ON p2.pID = i2.pID
    WHERE p2.pName = 'Banana'
    LIMIT 1
);