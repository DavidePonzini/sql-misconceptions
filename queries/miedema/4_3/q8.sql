SELECT
    a.cID AS Customer1_ID,
    b.cID AS Customer2_ID,
    a.street AS Street_Name,
    a.city AS City1,
    b.city AS City2
FROM
    customer a
JOIN
    customer b
ON
    a.street = b.street AND a.city <> b.city
WHERE
    a.cID < b.cID;