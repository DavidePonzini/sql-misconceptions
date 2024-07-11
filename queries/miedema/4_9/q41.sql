GROUP BY t.sID
FROM transaction as t
WHERE AVG(t.quantity) > 4;