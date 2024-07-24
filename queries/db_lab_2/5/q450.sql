SELECT 
    Studenti.Nome AS StudentFirstName, 
    Studenti.Cognome AS StudentLastName, 
    Professori.Cognome AS AdvisorLastName
FROM 
    Studenti
LEFT JOIN 
    Professori ON Studenti.Relatore = Professori.Id
ORDER BY 
    Studenti.Cognome, Studenti.Nome;
