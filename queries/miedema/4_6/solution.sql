SELECT
    city,
    COUNT(sID) AS num_stores
FROM store
GROUP BY city;
