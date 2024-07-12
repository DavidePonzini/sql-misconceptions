SELECT product.pName
FROM inventory
LEFT JOIN product on inventory.pID = product.pID
WHERE inventory.unit_price  >
(SELECT inventory.unit_price
FROM inventory
LEFT JOIN product on inventory.pID = product.pID
WHERE product.pName = 'Banana');