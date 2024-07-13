SELECT DISTINCT Store.sName
FROM Store, Inventory, Product
WHERE Store.sID = Inventory.sID AND Product.pID=Inventory.pID AND Inventory.quantity >4