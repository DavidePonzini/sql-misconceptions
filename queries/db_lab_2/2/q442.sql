SELECT Facolta, Denominazione
FROM CorsiDiLaurea
WHERE (SUBSTRING(Attivazione, 1, 4)::INTEGER < 2006 OR SUBSTRING(Attivazione, 1, 4)::INTEGER > 2010)
ORDER BY Facolta, Denominazione;
