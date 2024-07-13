SELECT transaction.cid, transaction.date, transaction.quantity
FROM transaction, product
WHERE product.pName='Apples' AND product.pid = transaction.pid