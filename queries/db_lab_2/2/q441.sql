SELECT Facolta, Denominazione
FROM CorsiDiLaurea
WHERE (CAST(SUBSTRING(Attivazione FROM 1 FOR 4) AS INTEGER) < 2006 
       OR CAST(SUBSTRING(Attivazione FROM 1 FOR 4) AS INTEGER) > 2010)
ORDER BY Facolta, Denominazione;
