SELECT
    c1.cid AS id1,
    c2.cid AS id2
FROM
    customer c1
    JOIN customer c2 ON c1.street = c2.street AND c1.city <> c2.city
WHERE c1.cID < c2.cID;  -- needed to remove repeated pairs
