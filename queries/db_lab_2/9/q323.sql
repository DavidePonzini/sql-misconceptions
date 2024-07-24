SELECT studenti.matricola
FROM studenti 
JOIN corsidilaurea ON studenti.corsodilaurea = corsidilaurea.id
JOIN esami ON studenti.matricola = esami.studente

WHERE  corsidilaurea.denominazione = 'Informatica' 
AND esami.corso = 'bdd1n'
AND EXTRACT(YEAR FROM esami.data) = 2010
AND EXTRACT(MONTH FROM esami.data) = 6

INTERSECT

SELECT studenti.matricola
FROM studenti 
JOIN corsidilaurea ON studenti.corsodilaurea = corsidilaurea.id
JOIN esami ON studenti.matricola = esami.studente
WHERE  corsidilaurea.denominazione = 'Informatica' 
AND esami.corso = 'ig'
AND EXTRACT(YEAR FROM esami.data) = 2010
AND EXTRACT(MONTH FROM esami.data) = 6