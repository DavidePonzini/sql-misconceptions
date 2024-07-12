SELECT Store.city, COUNT(Store.sName)
FROM Store
GROUP BY Store.city