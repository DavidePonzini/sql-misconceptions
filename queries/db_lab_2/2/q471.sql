SELECT 
    CorsiDiLaurea.Facolta, 
    CorsiDiLaurea.Denominazione
FROM 
    CorsiDiLaurea
WHERE 
    CorsiDiLaurea.Attivazione < '2006/2007' 
    AND CorsiDiLaurea.Attivazione > '2009/2010'
ORDER BY 
    CorsiDiLaurea.Facolta, 
    CorsiDiLaurea.Denominazione;
