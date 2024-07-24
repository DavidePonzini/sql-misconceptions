SELECT  DISTINCT Studenti.Cognome, Studenti.Nome
FROM Studenti JOIN pianidistudio ON Studenti.matricola = pianidistudio.studente 
			  JOIN CorsiDiLaurea ON Studenti.CorsoDiLaurea = CorsiDiLaurea.id
where pianidistudio.anno = 5 AND CorsiDiLaurea.Denominazione = 'Informatica' 
		AND pianidistudio.annoaccademico = 2011 AND studenti.relatore IS NOT NULL
ORDER BY Studenti.Cognome, Studenti.Nome DESC;