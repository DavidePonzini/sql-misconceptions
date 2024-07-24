SELECT matricola
FROM studenti  
JOIN corsidilaurea
ON studenti.corsodilaurea = corsidilaurea.id
WHERE corsidilaurea.denominazione = 'Informatica' AND studenti.laurea < '2009-11-01'