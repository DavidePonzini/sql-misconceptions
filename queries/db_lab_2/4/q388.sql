SELECT DISTINCT Studenti.Matricola
FROM Studenti, Esami, Corsi
WHERE Studenti.Matricola = Esami.Studente
AND Esami.Corso = Corsi.Id
AND Corsi.CorsoDiLaurea = (
    SELECT id
    FROM CorsiDiLaurea
    WHERE Denominazione = 'Informatica'
)
AND Studenti.Laurea < '2009-11-01';