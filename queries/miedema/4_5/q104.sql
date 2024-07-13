SELECT Product.pName
FROM Product, Inventory
WHERE Product.pID=Inventory.pID AND Inventory.unit_price > (SELECT Inventory.unit_price FROM Inventory, Product WHERE Product.pID=Inventory.pID AND pName='Banana' )