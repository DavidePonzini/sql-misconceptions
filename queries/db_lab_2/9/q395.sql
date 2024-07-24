SELECT matricola
FROM studenti JOIN corsidilaurea on studenti.corsodilaurea = corsidilaurea.id 
JOIN corsi on corsi.corsodilaurea = corsidilaurea.id
JOIN esami on esami.studente = studenti.matricola AND esami.corso = corsi.id
WHERE corsidilaurea.id = 9 AND extract(month from data) = 6
AND corsi.denominazione = 'Basi Di Dati 1' AND esami.voto >= 18
INTERSECT
SELECT matricola
FROM studenti JOIN corsidilaurea on studenti.corsodilaurea = corsidilaurea.id 
JOIN corsi on corsi.corsodilaurea = corsidilaurea.id
JOIN esami on esami.studente = studenti.matricola AND esami.corso = corsi.id
WHERE corsidilaurea.id = 9 AND extract(month from data) = 6
AND corsi.denominazione = 'Interfacce Grafiche' AND esami.voto >= 18;