SELECT p.pName
FROM Product p 
INNER JOIN Inventory i ON p.pID = i.pID
WHERE i.unit_price > (SELECT i.unit_price
                                        FROM Inventory i
                                        INNER JOIN Product p on p.pID = i.pID
                                        WHERE p.pName='Banana')