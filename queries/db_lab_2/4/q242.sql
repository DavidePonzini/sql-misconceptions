SELECT matricola, cognome, nome
FROM studenti
inner JOIN corsidilaurea ON studenti.corsodilaurea = corsidilaurea.id
WHERE corsidilaurea.denominazione LIKE 'Informatica'
AND laurea < '2009-11-01'
ORDER BY matricola ASC;