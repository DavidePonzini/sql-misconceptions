SELECT Prodotto.nome FROM
(SELECT Prodotto.nome FROM CATEGORIA INNER JOIN
PRODOTTO
ON CATEGORIA.idCat = PRODOTTO.IDCAT
WHERE Categoria.nome = "bevande") - (SELECT Prodotto.nome
FROM Ordine INNER JOIN Dettaglio_ordine D ON O.idOrd = D.idOrd
INNER JOIN Prodotto P ON P.id Prod = D.id Prod
INNER JOIN Categoria C ON C.idCat = P.idCat
WHERE Ordine.data BETWEEN '01/01/2023' AND '31/12/2023'
HAVING C.nome = "Bevande"
GROUP BY P.nome)
