WITH StoreChainAvgQuantity AS (
    SELECT
        s.sName,
        AVG(t.quantity) AS avg_quantity
    FROM
        store s
    JOIN
        transaction t ON s.sID = t.sID
    GROUP BY
        s.sName
    HAVING
        COUNT(DISTINCT s.sID) > 1
)
SELECT
    sName
FROM
    StoreChainAvgQuantity
WHERE
    avg_quantity > 4;