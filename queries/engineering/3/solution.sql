SELECT idProd, nome
FROM Prodotto P
WHERE NOT EXISTS(SELECT nome
	FROM Cliente C
	JOIN Ordine O
	ON C.idClient= O.idClient
	JOIN DettaglioOrdine D
	ON P.idProd=D.idProd
	WHERE C.città IN ('Venezia', 'Brescia')
)
