SELECT pname
FROM product P JOIN inventory I ON P.pid = I.pid
WHERE unit_price > (SELECT MAX(unit_price)
                                   FROM inventory I2 JOIN product P2 ON P2.pid = I2.pid
                                   WHERE pname = 'Bananas')