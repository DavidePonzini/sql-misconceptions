SELECT city, COUNT(*) AS StoresForCity
FROM Store
GROUP BY city;