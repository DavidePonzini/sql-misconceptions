SELECT 
    CONCAT(Studenti.Cognome, ' ', Studenti.Nome) AS StudentName, 
    Professori.Cognome AS AdvisorLastName
FROM 
    Studenti
LEFT JOIN 
    Professori ON Studenti.Relatore = Professori.Id
ORDER BY 
    StudentName;
