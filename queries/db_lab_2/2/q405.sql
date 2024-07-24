SELECT Facolta, Denominazione
FROM CorsiDiLaurea
WHERE Attivazione NOT BETWEEN '2006/2007' AND '2009/2010'
ORDER BY Facolta, Denominazione;