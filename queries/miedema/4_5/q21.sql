SELECT p.pName
FROM miedema.product p
JOIN miedema.inventory i ON p.pID = i.pID
WHERE i.unit_price > (
    SELECT unit_price
    FROM miedema.inventory
    JOIN miedema.product ON miedema.product.pID = miedema.inventory.pID
    WHERE pName = 'Banana'
)
