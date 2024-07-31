SELECt idProd, P.nome
FROM Prodotto P
JOIN Categoria C ON P.idCat = C.id Cat
WHERE C.nome = 'bevande'
AND idProd NOT IN (
	SELECT idProd
	FROM Ordine O
	JOIN DettaglioOrdine D
	ON O.idOrd = D.idOrd
	WHERE YEAR(data) = '2023'
)
