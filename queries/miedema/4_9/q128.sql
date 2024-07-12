SELECT s.sName
FROM store s
JOIN transaction t ON s.sID = t.sID
GROUP BY s.sName
HAVING AVG(t.quantity) >= 4;