SELECT Product.pName
FROM miedema.Product, miedema.Inventory
WHERE Product.pID=Inventory.pID AND Inventory.unit_price > (SELECT Inventory.unit_price FROM miedema.Inventory, miedema.Product WHERE Product.pID=Inventory.pID AND pName='Banana' )