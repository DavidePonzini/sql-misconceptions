SELECT P.nome
FROM Prodotto P
JOIN Categoria C ON P.idCat = C.idCat
LEFT JOIN DettaglioOrdine DO1 ON P.idProd = DO1.idProd
LEFT JOIN Ordine O ON DO1.idOrd = O.idOrd AND EXTRACT(YEAR FROM O.data) = 2023
WHERE C.nome = 'bevande' AND O.idOrd IS NULL;
