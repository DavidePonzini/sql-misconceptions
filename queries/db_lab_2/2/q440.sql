SELECT Facolta, Denominazione
FROM CorsiDiLaurea
WHERE (substring(Attivazione, 1, 4)::integer < 2006 OR substring(Attivazione, 6, 9)::integer < 2006)
  AND (substring(Attivazione, 1, 4)::integer > 2010 OR substring(Attivazione, 6, 9)::integer > 2010)
ORDER BY Facolta, Denominazione;
