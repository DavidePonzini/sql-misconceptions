SELECT * 
FROM CorsiDiLaurea 
WHERE Attivazione < '2006/2007' OR Attivazione > '2009/2010'
ORDER BY Facolta ASC, Denominazione ASC