SELECT matricola
FROM unicorsi.studenti JOIN unicorsi.corsidilaurea on studenti.corsodilaurea = corsidilaurea.id 
JOIN unicorsi.corsi on corsi.corsodilaurea = corsidilaurea.id
JOIN unicorsi.esami on esami.studente = studenti.matricola AND esami.corso = corsi.id
WHERE corsidilaurea.id = 9 AND extract(month from data) = 6
AND corsi.denominazione = 'Basi Di Dati 1' AND esami.voto >= 18
INTERSECT
SELECT matricola
FROM unicorsi.studenti JOIN unicorsi.corsidilaurea on studenti.corsodilaurea = corsidilaurea.id 
JOIN unicorsi.corsi on corsi.corsodilaurea = corsidilaurea.id
JOIN unicorsi.esami on esami.studente = studenti.matricola AND esami.corso = corsi.id
WHERE corsidilaurea.id = 9 AND extract(month from data) = 6
AND corsi.denominazione = 'Interfacce Grafiche' AND esami.voto >= 18;