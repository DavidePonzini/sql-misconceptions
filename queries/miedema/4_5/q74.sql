SELECT DISTINCT pName 
FROM Inventory 
INNER JOIN Product ON Inventory.pID = Product.pID AND unit_price > 
 (SELECT MAX(unit_price) FROM Inventory INNER JOIN Product ON Inventory.pID = Product.pID AND pName = 'Banana');