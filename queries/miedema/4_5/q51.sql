SELECT B.pName
FROM inventory A, product B
WHERE A.pID = B.pID
AND B.unit_price >
(SELECT DISTINCT C.unit_price
FROM inventory C, product D
WHERE C.pName = ”Banana”
AND D.pID = C.pID)