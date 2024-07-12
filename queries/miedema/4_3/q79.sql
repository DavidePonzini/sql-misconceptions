SELECT DISTINCT x.cID AS customer1_id, y.cID AS customer2_id
FROM customer x, customer y
WHERE x.street = y.street 
AND x.city != y.city;