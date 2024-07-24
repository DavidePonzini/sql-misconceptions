SELECT DISTINCT S.Cognome, S.Nome
FROM PianiDiStudio P 
JOIN Studenti S ON P.Studente = S.Matricola 
JOIN CorsiDiLaurea C ON S.CorsoDiLaurea = C.id 
WHERE C.Denominazione = 'Informatica' AND P.AnnoAccademico = 2011 AND P.Anno = 5 AND S.Relatore IS NOT NULL 
ORDER BY S.Cognome DESC