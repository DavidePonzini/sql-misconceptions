SELECT p.pName
FROM product p
JOIN inventory i ON p.pID = i.pID
WHERE i.unit_price > (
    SELECT unit_price
    FROM inventory
    JOIN product ON product.pID = inventory.pID
    WHERE pName = 'Banana'
)
