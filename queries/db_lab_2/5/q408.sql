SELECT S.Nome AS Nome_Studente, S.Cognome AS Cognome_Studente, P.Cognome AS Cognome_Relatore
FROM Studenti AS S
	LEFT JOIN Professori AS P ON S.Relatore = P.Id
ORDER BY S.Cognome, S.Nome;