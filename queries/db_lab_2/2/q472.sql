SELECT 
    CorsiDiLaurea.Facolta, 
    CorsiDiLaurea.Denominazione 
FROM 
    CorsiDiLaurea 
JOIN 
    Corsi ON Corsi.CorsoDiLaurea = CorsiDiLaurea.id 
WHERE 
    CorsiDiLaurea.Attivazione < '2006/2007' 
    AND CorsiDiLaurea.Attivazione > '2009/2010' 
ORDER BY 
    CorsiDiLaurea.Facolta, 
    CorsiDiLaurea.Denominazione;
