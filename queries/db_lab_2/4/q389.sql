SELECT DISTINCT Studenti.Matricola
FROM Studenti
JOIN Esami ON Studenti.Matricola = Esami.Studente
JOIN Corsi ON Esami.Corso = Corsi.Id
JOIN CorsiDiLaurea ON Corsi.CorsoDiLaurea = CorsiDiLaurea.id
WHERE CorsiDiLaurea.Denominazione = 'Informatica'
AND Studenti.Laurea < '2009-11-01';