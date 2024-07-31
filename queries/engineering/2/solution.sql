SELECT O.idOrd, SUM (prezzo*d.quantità) AS TotaleOrdine
FROM Ordine O
JOIN DettaglioOrdine D ON O.idOrd=D.idOrd
JOIN Prodotto P ON D.idProd = P.idProd
WHERE O.idClient = '1234'
AND O.data = (
	SELECT MAX(data)
	FROM Ordine WHERE idClient='1234'
)
GROUP BY O.idOrd
