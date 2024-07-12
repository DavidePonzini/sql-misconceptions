SELECT cID.transaction, date.transaction,
quantity.transaction
FROM transaction AS t, product AS p
JOIN product
ON transaction.pID = product.pID
WHERE product.pName = ”Apples”;