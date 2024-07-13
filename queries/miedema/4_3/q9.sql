SELECT a.cID AS Customer1_ID, b.cID AS Customer2_ID
FROM customer AS a
JOIN customer AS b ON a.street = b.street AND a.city <> b.city
WHERE a.cID < b.cID;