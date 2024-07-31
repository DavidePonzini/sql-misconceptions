SELECt idProd, P.nome
FROM Prodotto P
JOIN Categoria C ON P.idCat = C.idCat
WHERE C.nome = 'Bevande'
AND idProd NOT IN (
	SELECT idProd
	FROM Ordine O
	JOIN DettaglioOrdine D
	ON O.idOrd = D.idOrd
	WHERE EXTRACT (YEAR FROM data) = '2023'
)
