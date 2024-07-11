SELECT s.sName
FROM store s
JOIN transaction t ON s.sID = t.sID
GROUP BY s.sName
HAVING COUNT(DISTINCT s.sID) >= 2 AND AVG(t.quantity) > 4;
