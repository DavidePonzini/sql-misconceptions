WITH store_chains AS (
    SELECT
        sName,
        COUNT(sID) AS store_count
    FROM
        store
    GROUP BY
        sName
    HAVING
        COUNT(sID) > 1
),
average_sales AS (
    SELECT
        s.sName,
        AVG(t.quantity) AS avg_quantity
    FROM
        transaction t
    JOIN
        store s ON t.sID = s.sID
    GROUP BY
        s.sName
)
SELECT
    sc.sName
FROM
    store_chains sc
JOIN
    average_sales a ON sc.sName = a.sName
WHERE
    a.avg_quantity > 4;