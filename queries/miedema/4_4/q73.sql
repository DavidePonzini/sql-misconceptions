SELECT cID, date, quantity 
FROM Transaction 
INNER JOIN Product ON Transaction.pID = Product.pID AND pName = 'Apples';