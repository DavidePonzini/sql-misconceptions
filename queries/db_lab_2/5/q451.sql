SELECT 
    S.Nome AS StudentName,
    S.Cognome AS StudentLastName,
    P.Cognome AS AdvisorLastName
FROM 
    Studenti S
LEFT JOIN 
    Professori P ON S.Relatore = P.Id
ORDER BY 
    S.Nome, S.Cognome;
