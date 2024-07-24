SELECT S.Cognome, S.Nome, P.Cognome 
FROM Studenti S JOIN Professori P ON id = Relatore
ORDER BY S.Cognome ASC