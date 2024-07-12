SELECT DISTINCT store.sname, COUNT(store.sid) AS number_of_stores
FROM miedema.store
LEFT JOIN miedema.transaction on store.sid = transaction.sid
WHERE transaction.sid IS NULL AND transaction.quantity > 4
GROUP BY store.sname
HAVING COUNT(store.sid) > 1;