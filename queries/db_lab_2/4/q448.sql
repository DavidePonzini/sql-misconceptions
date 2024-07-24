SELECT Matricola
FROM Studenti
WHERE CorsoDiLaurea IN (
    SELECT id
    FROM CorsiDiLaurea
    WHERE Denominazione = 'Informatica'
)
AND Laurea < '2009-11-01';