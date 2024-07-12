SELECT transaction.cID, transaction.date, transaction.quantity
FROM miedema.transaction
LEFT JOIN miedema.product on product.pID = transaction.pID
WHERE product.pName = 'Apples';