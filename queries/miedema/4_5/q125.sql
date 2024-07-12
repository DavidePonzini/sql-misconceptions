SELECT p.pName
FROM product p
JOIN inventory i ON p.pID = i.pID
WHERE i.unit_price > (
    SELECT unit_price
    FROM product
    WHERE pName = 'Banana'
);