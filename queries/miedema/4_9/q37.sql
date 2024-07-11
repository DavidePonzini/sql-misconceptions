WITH ChainAvgQuantity AS (
    SELECT sName, AVG(quantity) AS avg_quantity
    FROM transaction
    JOIN store ON transaction.sID = store.sID
    GROUP BY sName
    HAVING COUNT(DISTINCT transaction.sID) >= 2
)
SELECT sName
FROM ChainAvgQuantity
WHERE avg_quantity > 4
