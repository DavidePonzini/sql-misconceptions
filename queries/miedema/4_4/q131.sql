SELECT ID, date, quantity
FROM Transaction
NATURAL JOIN Product
WHERE pName='Apples';