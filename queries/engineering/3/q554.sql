SELECT P.NOME 
FROM PRODOTTO P
WHERE p.idProd NOT IN ( 
SELECT DISTINCT d.IdProd
FROM Dettaglio_Ordine
JOIN Ordine O ON
d.idOrd= O.idOrd
JOIN Cliente C ON O.IdClient = c.idClient
WHERE C.CIttà = "venezia" OR
c.città ="Brescia");
