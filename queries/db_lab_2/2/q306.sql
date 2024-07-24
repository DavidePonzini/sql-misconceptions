SELECT Facolta, Denominazione
FROM CorsiDiLaurea
WHERE SUBSTRING(Attivazione, 1, 4) NOT IN ('2006', '2007', '2008')
ORDER BY Facolta, Denominazione;