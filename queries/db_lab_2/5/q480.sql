SELECT 
    s.Nome AS Student_First_Name,
    s.Cognome AS Student_Last_Name,
    p.Cognome AS Advisor_Last_Name
FROM 
    Studenti s
LEFT JOIN 
    Professori p ON s.Relatore = p.Id
ORDER BY 
    s.Cognome, s.Nome;
