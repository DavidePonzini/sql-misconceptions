WITH ChainStores AS (
    SELECT sName, COUNT(DISTINCT sID) AS NumStores
    FROM store
    GROUP BY sName
    HAVING COUNT(DISTINCT sID) > 1
),
AverageQuantities AS (
    SELECT s.sName, AVG(t.quantity) AS AvgQuantity
    FROM transaction t
    JOIN ChainStores cs ON t.sID = cs.sID
    JOIN store s ON t.sID = s.sID
    GROUP BY s.sName
    HAVING AVG(t.quantity) > 4
)
SELECT sName
FROM AverageQuantities;
