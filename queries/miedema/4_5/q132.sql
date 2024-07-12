SELECT pName
FROM Product
NATURAL JOIN Inventory
WHERE unit_price>(SELECT unit_price
                                FROM Inventory NATURAL JOIN Product
                                WHERE pName='Banana');