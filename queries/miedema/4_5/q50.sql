WITH u AS (SELECT i.sID, i.date, i.unit_price
FROM inventory AS i, product AS p
WHERE i.pID = p.pID AND
p.pName = ”Bananas”)
SELECT p.pName
FROM inventory AS i, product AS p
WHERE u.sID = i.sID AND
u.date = i.date AND
i.unit_price > u.unit_price AND
i.pID = p.pID