SELECT DISTINCT S.Cognome, S.Nome
FROM Studenti AS S
	JOIN PianiDiStudio AS P ON S.Matricola = P.Studente
	JOIN CorsiDiLaurea AS C ON S.CorsoDiLaurea = C.id
WHERE P.AnnoAccademico = 2011
  AND P.Anno = 5
  AND S.Relatore IS NOT NULL
ORDER BY S.Cognome DESC, S.Nome DESC;