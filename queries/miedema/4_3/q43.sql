SELECT cName, cName
AS name_1, name_2
FROM customer
WHERE (street_1 == street_2
AND city_1 != city_2);