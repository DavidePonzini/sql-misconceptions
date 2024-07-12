SELECT transaction.cID,
transaction.date,
transaction.quantity
FROM transaction
JOIN transaction.pID = product.pName
WHERE pnamed = ”Apples”;