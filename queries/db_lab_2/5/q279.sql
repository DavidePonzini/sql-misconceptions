SELECT  Studenti.Cognome, Studenti.Nome, Professori.Cognome
FROM Studenti JOIN Professori ON Studenti.Relatore = Professori.Id
ORDER BY Studenti.Cognome, Studenti.Nome;