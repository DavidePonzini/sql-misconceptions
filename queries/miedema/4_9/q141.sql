SELECT s.sName AS StoreChainName FROM store s JOIN (
    SELECT sName
    FROM store
    GROUP BY sName
    HAVING COUNT(DISTINCT sID) >= 2
) chain ON s.sName = chain.sName
JOIN "transaction" t ON s.sID = t.sID
GROUP BY s.sName
HAVING AVG(t.quantity) > 4;