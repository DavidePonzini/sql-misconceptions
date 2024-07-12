SELECT DISTINCT c1.cID AS customer1_ID, c2.cID AS customer2_ID 
FROM customer c1  
JOIN customer c2 ON c1.street = c2.street AND c1.city <> c2.city;