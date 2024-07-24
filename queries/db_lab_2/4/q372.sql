SELECT Matricola
FROM Studenti, CorsiDiLaurea
WHERE CorsoDiLaurea = id AND Denominazione = 'Informatica' AND Laurea < '2009-11-01'