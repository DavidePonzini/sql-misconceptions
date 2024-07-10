SELECT c.cID, c.cName
FROM customer c
JOIN store s ON c.city = s.city
WHERE category = 'Eindhoven';