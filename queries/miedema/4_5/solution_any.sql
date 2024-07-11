SELECT DISTINCT pname
FROM product p
    JOIN inventory i ON i.pid = p.pid
WHERE
    i.unit_price > ANY(
        SELECT i.unit_price
        FROM product p
            JOIN inventory i ON i.pid = p.pid
        WHERE p.pname = 'Banana'
    );