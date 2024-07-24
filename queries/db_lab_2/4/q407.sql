SELECT DISTINCT S.Matricola
FROM Studenti AS S
	JOIN PianiDiStudio AS P ON S.Matricola = P.Studente
	JOIN CorsiDiLaurea AS C ON S.CorsoDiLaurea = C.id
WHERE C.Denominazione = 'Informatica'
  AND S.Laurea IS NOT NULL
  AND S.Laurea < '2009-11-01';