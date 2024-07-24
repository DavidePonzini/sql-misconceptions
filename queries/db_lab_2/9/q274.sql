SELECT studenti.matricola
FROM studenti
JOIN esami
ON esami.studente = studenti.matricola
JOIN corsi
ON esami.corso = corsi.id
JOIN corsidilaurea
ON corsidilaurea.id = corsi.corsodilaurea
WHERE corsi.denominazione = 'Basi Di Dati 1' AND esami.data BETWEEN '2010-06-01' AND '2010-06-30' AND corsidilaurea.denominazione = 'Informatica'
INTERSECT
SELECT studenti.matricola
FROM studenti
JOIN esami
ON esami.studente = studenti.matricola
JOIN corsi
ON esami.corso = corsi.id
JOIN corsidilaurea
ON corsidilaurea.id = corsi.corsodilaurea
WHERE corsi.denominazione = 'Interfacce Grafiche' AND esami.data BETWEEN '2010-06-01' AND '2010-06-30' AND corsidilaurea.denominazione = 'Informatica'