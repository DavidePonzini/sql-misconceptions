SELECT c1.cid, c2.cid
FROM customer AS c1
JOIN customer AS c2
        ON c1.street = c2.street AND c1.city != c2.city