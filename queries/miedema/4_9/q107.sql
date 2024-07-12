SELECT DISTINCT Store.sName
FROM miedema.Store, miedema.Inventory, miedema.Product
WHERE Store.sID = Inventory.sID AND Product.pID=Inventory.pID AND Inventory.quantity >4