SELECT transaction.cID, transaction.date, transaction.quantity
FROM transaction
LEFT JOIN product on product.pID = transaction.pID
WHERE product.pName = 'Apples';