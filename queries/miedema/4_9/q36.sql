SELECT sName
FROM (
    SELECT sName, COUNT(DISTINCT sID) AS store_count, AVG(quantity) AS avg_quantity
    FROM store
    JOIN inventory USING(sID)
    GROUP BY sName
) AS store_stats
WHERE store_count > 1 AND avg_quantity > 4;
