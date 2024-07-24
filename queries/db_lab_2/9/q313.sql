SELECT s.Matricola
FROM unicorsi.Studenti s
JOIN unicorsi.Esami e ON s.Matricola = e.Studente
JOIN unicorsi.Corsi c ON e.Corso = c.id
JOIN unicorsi.CorsiDiLaurea l ON s.corsodilaurea=l.id
WHERE l.denominazione = 'Informatica'
AND c.Denominazione = 'Basi Di Dati 1'
AND e.Data BETWEEN '2010-06-01' AND '2010-06-30'
AND s.Matricola IN (
    SELECT s.Matricola
	FROM unicorsi.Studenti s
	JOIN unicorsi.Esami e ON s.Matricola = e.Studente
	JOIN unicorsi.Corsi c ON e.Corso = c.id
	JOIN unicorsi.CorsiDiLaurea l ON s.corsodilaurea=l.id
	WHERE l.denominazione = 'Informatica'
	AND c.Denominazione = 'Interfacce Grafiche'
	AND e.Data BETWEEN '2010-06-01' AND '2010-06-30'
);
