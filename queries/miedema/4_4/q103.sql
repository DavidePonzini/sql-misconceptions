SELECT transaction.cid, transaction.date, transaction.quantity
FROM miedema.transaction, miedema.product
WHERE product.pName='Apples' AND product.pid = transaction.pid